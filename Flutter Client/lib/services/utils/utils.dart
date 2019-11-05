import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:repository/repository.dart';

/// Converts a hex string (like, '#ffdd00') to a [Color].
Color hexStringToColor(String hex) =>
    Color(int.parse('ff' + hex.substring(1), radix: 16));

/// Prints a file size given in byte as a string.
String formatFileSize(int bytes) {
  const List<String> units = <String>['B', 'kB', 'MB', 'GB', 'TB', 'YB'];

  int index = 0;
  int power = 1;
  while (bytes > 1000 * power && index < units.length - 1) {
    power *= 1000;
    index++;
  }

  return '${(bytes / power).toStringAsFixed(index == 0 ? 0 : 1)} ${units[index]}';
}

/// Converts a DateTime to a string.
String dateTimeToString(DateTime dt) => DateFormat.yMMMd().format(dt);

/// A special kind of item that also carries its id.
abstract class Entity {
  const Entity();
  Id<Entity> get id;
}

abstract class CollectionFetcher<Item extends Entity> extends Repository<Item> {
  CollectionFetcher() : super(isFinite: true, isMutable: false);

  Future<List<Item>> _downloader;
  Map<Id<Item>, Item> _items;

  Future<void> _ensureItemsAreDownloaded() async {
    _downloader ??= downloadAll();
    _items ??= <Id<Item>, Item>{
      // ignore: sdk_version_ui_as_code
      for (Item item in await _downloader) item.id: item
    };
  }

  @override
  Stream<Item> fetch(Id<Item> id) async* {
    await _ensureItemsAreDownloaded();
    if (_items.containsKey(id)) {
      yield _items[id];
    } else {
      throw ItemNotFound<Item>(id);
    }
  }

  @override
  Stream<Map<Id<Item>, Item>> fetchAll() async* {
    await _ensureItemsAreDownloaded();
    yield _items;
  }

  Future<List<Item>> downloadAll();
}
