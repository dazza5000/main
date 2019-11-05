import 'package:repository/repository.dart';
import 'package:repository_hive/repository_hive.dart';

import '../bloc/data.dart';

/// A service that offers storage of app-wide data.
class StorageService {
  StorageService() {
    _storage = CachedRepository<StorageData>(
      cache: _inMemory,
      source: HiveRepository<StorageData>('dataStorage'),
    );
  }
  static const Id<StorageData> _dataId = Id<StorageData>('data');

  final InMemoryStorage<StorageData> _inMemory = InMemoryStorage<StorageData>();
  CachedRepository<StorageData> _storage;

  Future<void> initialize() async {
    await _inMemory.update(_dataId, StorageData());

    await _storage.loadItemsIntoCache().whenComplete(() {
      print('${DateTime.now().toUtc().toString()} Complete');
    }).then((void value) {
      print('${DateTime.now().toUtc().toString()} then');
    }).catchError((dynamic e) {
      print('${DateTime.now().toUtc().toString()} Error ${e.toString()}');
    });
  }

  StorageData get data => _inMemory.get(_dataId);
  Stream<StorageData> get dataStream => _inMemory.fetch(_dataId);
  set data(StorageData data) => _storage.update(_dataId, data);

  String get email => data.email;
  String get token => data.token;
  bool get hasToken => token != null;

  set email(String email) =>
      data = data.copy((MutableStorageData data) => data..email = email);
  set token(String token) =>
      data = data.copy((MutableStorageData data) => data..token = token);

  Future<void> clear() => _storage.clear();
}
