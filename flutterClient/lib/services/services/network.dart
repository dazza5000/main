import 'dart:isolate';

import 'package:rxdart/rxdart.dart';
import 'package:collection/collection.dart' show groupBy;
import 'package:meta/meta.dart';

import '../services.dart';
import 'message_handler.dart';
import 'storage.dart';
import 'subscriptions.dart';

export 'message_handler.dart';
export 'subscriptions.dart';

class NoConnectionToServerError {}

class AuthenticationError {}

/// A service that offers networking post and get requests to the backend
/// servers. It depends on the authentication storage, so if the user's token
/// is stored there, the requests' headers are automatically enriched with the
/// access token.
class NetworkService {
  factory NetworkService(
    String _name, {
    @required StorageService storage,
    @required Map<MessageType, Subscriptions<dynamic>> subscriptions,
  }) {
    if (_cache.containsKey(_name)) {
      return _cache[_name];
    } else {
      assert(storage != null);
      assert(subscriptions != null);
      final NetworkService _instance = NetworkService._internal(_name);
      _cache[_name] = _instance;
      _cache[_name].storage = storage;
      _cache[_name].subscriptions = subscriptions;
      _cache[_name]._startSending();
      _cache[_name]._startReceiving();
      networkServiceReadyCompleter.complete();
      return _instance;
    }
  }

  // Setup for factory constructor
  NetworkService._internal(this.name);
  final String name;
  static final Map<String, NetworkService> _cache = <String, NetworkService>{};

  /// Storage Service
  StorageService storage;

  /// Subscriptions
  Map<MessageType, Subscriptions<dynamic>> subscriptions;

  /// Controller to send message status to rest of the application
  final BehaviorSubject<MessageHandler<dynamic>> _messageSendController =
      BehaviorSubject<MessageHandler<dynamic>>();
  Sink<MessageHandler<dynamic>> get addMessage => _messageSendController.sink;
  Stream<MessageHandler<dynamic>> get messageStream =>
      _messageSendController.stream;

  /// Start thread to send messages
  Future<bool> _startSending() async {
    // start thread to send messages
    for (MessageType type in subscriptions.keys) {
      subscriptions[type].isolateSending = await Isolate.spawn(
        subscriptions[type].sendingIsolate,
        subscriptions[type].portSendStatus.sendPort,
      );
      subscriptions[type].onSend();
    }
    return false;
  }

  /// Start listening messages from the server
  void _startReceiving() async {
    // start thread to receive messages for all Subscriptions
    for (MessageType type in subscriptions.keys) {
      subscriptions[type].isolateReceiving = await Isolate.spawn(
        subscriptions[type].receivingIsolate,
        subscriptions[type].portReceiving.sendPort,
      );
      subscriptions[type].onRecieve();
    }

/*     // listen for incoming messages
    await for (var event in _portReceiving) {
      if (event is MessageReceivedEvent) {
        if (onMessageReceived != null) {
          print('event: $event');
          onMessageReceived(event);
        }
      } else if (event is MessageReceiveFailedEvent) {
        if (onMessageReceiveFailed != null) {
          onMessageReceiveFailed(event);
        }
      }
    } */
  }

  // Shutdown client
  void shutdown() {
    for (MessageType type in subscriptions.keys) {
      // stop sending
      subscriptions[type].isolateSending?.kill(priority: Isolate.immediate);
      subscriptions[type].isolateSending = null;
      // stop receiving
      subscriptions[type].isolateReceiving?.kill(priority: Isolate.immediate);
      subscriptions[type].isolateReceiving = null;
      subscriptions[type].portReceiving?.close();
      subscriptions[type].portSendStatus?.close();
      subscriptions[type].portReceiving = null;
      subscriptions[type].portSendStatus = null;
    }
  }

  /// Send message to the server
  void send(MessageHandler<dynamic> message) {
    assert(subscriptions[message.messageType].portSending != null,
        "Port to send message can't be null");
    subscriptions[message.messageType].portSending.send(message);
  }

  Future<Map<String, dynamic>> getItem({
    @required String path,
    @required String id,
  }) async {
    assert(path != null);
    assert(id != null);
    return mockData[path].firstWhere(
        (Map<String, dynamic> item) => item['_id'] == id,
        orElse: () => <String, dynamic>{});
  }

  Future<Map<String, List<Map<String, dynamic>>>> getLastItem({
    @required String path,
    @required String field,
    @required String sortBy,
  }) async {
    assert(path != null);
    final List<Map<String, dynamic>> _list = mockData[path].toList();
    _list.sort((Map<String, dynamic> a, Map<String, dynamic> b) =>
        DateTime.parse(b[sortBy]).compareTo(DateTime.parse(a[sortBy])));
    final Map<String, List<Map<String, dynamic>>> pivot =
        groupBy<Map<String, dynamic>, String>(
            _list, (Map<String, dynamic> h) => h[field]);

    return pivot;
  }

  Future<List<Map<String, dynamic>>> getAllItemForId({
    @required String path,
    @required String field,
    @required String id,
  }) async {
    assert(path != null);
    assert(field != null);
    assert(id != null);
    return mockData[path]
        .where(
          (Map<String, dynamic> item) => item[field] == id,
        )
        .toList();
  }

  Future<List<Map<String, dynamic>>> getAllItem({
    @required String path,
  }) async {
    assert(path != null);
    return mockData[path];
  }
}

final Map<String, List<Map<String, dynamic>>> mockData =
    <String, List<Map<String, dynamic>>>{
  'users': <Map<String, dynamic>>[
    <String, dynamic>{
      '_id': 'A',
      'firstName': 'User A',
      'lastName': 'Last Name A',
      'email': 'userA@email.com',
      'displayName': 'UserA',
      'avatarURL':
          'https://upload.wikimedia.org/wikipedia/commons/6/6b/1975_Patty_Hearst.jpg'
    },
    <String, dynamic>{
      '_id': 'B',
      'firstName': 'User B',
      'lastName': 'Last Name B',
      'email': 'userB@email.com',
      'displayName': 'UserB',
      'avatarURL':
          'https://upload.wikimedia.org/wikipedia/commons/c/c5/Benjamin_Mayi_%D7%91%D7%A0%D7%99%D7%9E%D7%99%D7%9F_%D7%9E%D7%90%D7%99.jpg'
    },
    <String, dynamic>{
      '_id': 'C',
      'firstName': 'User C',
      'lastName': 'Last Name C',
      'email': 'userC@email.com',
      'displayName': 'UserC',
      'avatarURL':
          'https://upload.wikimedia.org/wikipedia/commons/d/d2/Menashe_Raz.jpg'
    }
  ],
  'chats': <Map<String, dynamic>>[
    <String, dynamic>{
      '_id': 'A',
      'text': 'Chat A',
      'uid': 'A',
      'createdAt': '2019-10-19 17:13:30.072',
      'conversationsId': 'conversationsA',
      'attachmentType': 'image',
      'attachmentUrl':
          'https://upload.wikimedia.org/wikipedia/commons/6/6b/1975_Patty_Hearst.jpg'
    },
    <String, dynamic>{
      '_id': 'B',
      'text': 'Chat B',
      'uid': 'B',
      'createdAt': '2019-10-20 17:13:30.072',
      'conversationsId': 'conversationsA',
    },
    <String, dynamic>{
      '_id': 'C',
      'text':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
      'uid': 'C',
      'createdAt': '2019-10-29 17:13:30.072',
      'conversationsId': 'conversationsA',
    },
  ],
  'conversations': <Map<String, dynamic>>[
    <String, dynamic>{
      '_id': 'conversationsA',
      'title': 'Conversations A',
      'uid': 'A',
      'timestamp': '2019-10-19 17:13:30.072',
      'avatarURL':
          'https://live.staticflickr.com/8365/8551937456_9f2c1544d3_n.jpg',
      'membersIds': <String>['A', 'B'],
    },
    <String, dynamic>{
      '_id': 'conversationsB',
      'title': 'Conversations B',
      'uid': 'B',
      'timestamp': '2019-10-19 17:13:30.072',
      'avatarURL':
          'https://upload.wikimedia.org/wikipedia/commons/f/f8/%22Jewish_Dance%22_by_Alexandr_Onishenko%2C_1999.jpg',
      'membersIds': <String>['A', 'B'],
    },
  ],
  'news': <Map<String, dynamic>>[
    <String, dynamic>{
      '_id': 'newsA',
      'title': 'News A',
      'uid': 'C',
      'text':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      'timestamp': '2019-10-19 12:13:30.072',
      'thumbnailUrl':
          'https://www.maxpixel.net/static/photo/2x/Newspaper-News-Paper-Headlines-Article-Journal-154444.png',
    },
    <String, dynamic>{
      '_id': 'newsB',
      'title': 'News B',
      'uid': 'A',
      'text':
          'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?',
      'timestamp': '2019-10-19 17:13:30.072',
      'thumbnailUrl':
          'https://www.maxpixel.net/static/photo/640/Press-Newspaper-Print-Paper-News-Media-37782.png',
    },
    <String, dynamic>{
      'uid': 'B',
      '_id': 'newsC',
      'title': 'News C',
      'text':
          'At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae. Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat',
      'timestamp': '2019-11-19 17:13:30.072',
      'thumbnailUrl':
          'https://www.maxpixel.net/static/photo/640/Corporate-Break-Drink-Cup-Breakfast-Sunday-Food-18987.png',
    },
    <String, dynamic>{
      'uid': 'C',
      '_id': 'newsD',
      'title': 'News D',
      'text':
          'On the other hand, we denounce with righteous indignation and dislike men who are so beguiled and demoralized by the charms of pleasure of the moment, so blinded by desire, that they cannot foresee the pain and trouble that are bound to ensue; and equal blame belongs to those who fail in their duty through weakness of will, which is the same as saying through shrinking from toil and pain. These cases are perfectly simple and easy to distinguish. In a free hour, when our power of choice is untrammelled and when nothing prevents our being able to do what we like best, every pleasure is to be welcomed and every pain avoided. But in certain circumstances and owing to the claims of duty or the obligations of business it will frequently occur that pleasures have to be repudiated and annoyances accepted. The wise man therefore always holds in these matters to this principle of selection: he rejects pleasures to secure other greater pleasures, or else he endures pains to avoid worse pains.',
      'timestamp': '2019-10-20 17:13:30.072',
      'thumbnailUrl':
          'https://www.maxpixel.net/static/photo/640/Fireworks-Rockets-Night-Explosion-Colors-Sparks-1758.jpg',
    },
  ]
};
