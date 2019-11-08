import 'package:meta/meta.dart';
import 'package:hive/hive.dart';
import 'package:repository/repository.dart';
import 'package:rxdart/rxdart.dart';

import 'package:com.winwisely99.app/services/services.dart';
import 'package:com.winwisely99.app/chat_list/chat_list.dart';
import 'package:com.winwisely99.app/vendor_plugins/vendor_plugins.dart';

import 'data.dart';

class ChatBloc {
  ChatBloc(
      {@required this.network,
      @required this.user,
      @required this.conversationsId})
      : assert(network != null),
        assert(user != null),
        _chats = CachedRepository<ChatModel>(
          // strategy: CacheStrategy.onlyFetchFromSourceIfNotInCache,
          source: _ChatFetcher(
            network: network,
            user: user,
            conversationsId: conversationsId,
          ),
          cache: HiveRepository<ChatModel>('chats'),
        ),
        _conversations = CachedRepository<Conversations>(
          // strategy: CacheStrategy.onlyFetchFromSourceIfNotInCache,
          source: ConversationsDownloader(network: network, user: user),
          cache: HiveRepository<Conversations>('conversations'),
        ) {
    _chatFetcher.stream
        .transform(_chatScreenTransformer())
        .pipe(_chatScreenOutput);
    initializeScreen();
  }

  final NetworkService network;
  final UserService user;
  final String conversationsId;
  final Repository<ChatModel> _chats;
  final Repository<Conversations> _conversations;

// this is similar to the Streambuilder and Itemsbuilder we have in the Stories bloc
  final PublishSubject<ChatModel> _chatFetcher = PublishSubject<ChatModel>();
  final BehaviorSubject<Map<Id<ChatModel>, ChatModel>> _chatScreenOutput =
      BehaviorSubject<Map<Id<ChatModel>, ChatModel>>();
// Getter to Stream
  Observable<Map<Id<ChatModel>, ChatModel>> get chatScreen =>
      _chatScreenOutput.stream;
  Function(ChatModel) get addChatToScreen => _chatFetcher.sink.add;

  ScanStreamTransformer<ChatModel, Map<Id<ChatModel>, ChatModel>>
      _chatScreenTransformer() {
    return ScanStreamTransformer<ChatModel, Map<Id<ChatModel>, ChatModel>>(
        (Map<Id<ChatModel>, ChatModel> cache, ChatModel value, int index) {
      cache ??= <Id<ChatModel>, ChatModel>{};
      cache[value.id] = value;
      return cache;
    }, <Id<ChatModel>, ChatModel>{});
  }

  Future<bool> initializeScreen() async {
/*     _chats.fetchAllItems().listen((List<ChatModel> list) {
      // ignore: prefer_foreach
      for (ChatModel chat in list) {
        addChatToScreen(chat);
      }
    }); */
    hiveBox['chats'].watch().listen((BoxEvent event) async {
      if (event.value is ChatModel) {
        final User _user = await user.getUser(event.value.uid);
        addChatToScreen(
          ChatModel(
            id: event.value.id,
            text: event.value.text,
            uid: event.value.uid,
            user: _user,
            createdAt: event.value.createdAt,
            attachmentType: event.value.attachmentType,
            attachmentUrl: event.value.attachmentUrl,
            conversationsId: event.value.conversationsId,
          ),
        );
      }
    });
    return true;
  }

  Stream<List<ChatModel>> getChats() => _chats.fetchAllItems();
  Future<Conversations> getConversation(Id<Conversations> id) =>
      _conversations.fetch(id).first;
  Future<User> getCurrentUser() async {
    // TODO(Vineeth): Remove this logic later once authentication is complete
    return user.getUser(const Id<User>('A'));
  }

  Future<dynamic> sendChat(ChatModel chat) async {
    network.send(
      MessageHandler<ChatModel>(
        message: chat,
        status: MessageStatus.NEW,
        messageType: MessageType.CHAT,
      ),
    );
  }

  void drain() {
    _chatFetcher.drain<bool>();
    _chatScreenOutput.drain<List<Map<String, dynamic>>>();
  }

  Future<bool> dispose() async {
    await _chatFetcher.drain<bool>();
    _chatScreenOutput.drain<List<Map<String, dynamic>>>();

    _chatFetcher.close();
    _chatScreenOutput.close();

    return true;
  }
}

class _ChatFetcher extends CollectionFetcher<ChatModel> {
  _ChatFetcher(
      {@required this.network,
      @required this.user,
      @required this.conversationsId});

  final NetworkService network;
  final UserService user;
  final String conversationsId;
  @override
  Future<List<ChatModel>> downloadAll() async {
    final List<Map<String, dynamic>> dataList = await network.getAllItemForId(
      path: 'chats',
      field: 'conversationsId',
      id: conversationsId,
    );

    return <ChatModel>[
      // ignore: sdk_version_ui_as_code
      for (dynamic data in dataList)
        ChatModel(
          id: Id<ChatModel>(data['_id']),
          text: data['text'],
          uid: Id<User>(data['uid']),
          user: await user.getUser(Id<User>(data['uid'])),
          createdAt: DateTime.parse(data['createdAt']),
          attachmentType: _getAttachmentType(data),
          attachmentUrl: data['attachmentUrl'],
          conversationsId: data['conversationsId'],
        ),
    ];
  }

  static AttachmentType _getAttachmentType(Map<String, dynamic> data) {
    AttachmentType type;
    switch (data['attachmentType']) {
      case 'image':
        type = AttachmentType.image;
        break;
      case 'file':
        type = AttachmentType.file;
        break;
      case 'video':
        type = AttachmentType.video;
        break;
      case 'geolocation':
        type = AttachmentType.geolocation;
        break;
      case 'calender':
        type = AttachmentType.calender;
        break;
      default:
        return AttachmentType.none;
    }
    return type;
  }
}
