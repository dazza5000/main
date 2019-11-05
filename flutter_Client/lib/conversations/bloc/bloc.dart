import 'package:meta/meta.dart';
import 'package:repository/repository.dart';

import 'package:com.winwisely99.app/services/services.dart';
import 'package:com.winwisely99.app/vendor_plugins/vendor_plugins.dart';
import '../bloc/data.dart';
import 'data.dart';

class ConversationsBloc {
  ConversationsBloc({
    @required this.network,
    @required this.user,
  })  : assert(network != null),
        assert(user != null),
        _conversations = CachedRepository<Conversations>(
          strategy: CacheStrategy.onlyFetchFromSourceIfNotInCache,
          source: ConversationsDownloader(network: network, user: user),
          cache: HiveRepository<Conversations>('conversations'),
        );

  final NetworkService network;
  final UserService user;
  final Repository<Conversations> _conversations;
  Stream<List<Conversations>> getConversations() =>
      _conversations.fetchAllItems();
  Future<Conversations> getConversation(Id<Conversations> id) =>
      _conversations.fetch(id).first;
}

class ConversationsDownloader extends CollectionFetcher<Conversations> {
  ConversationsDownloader({
    @required this.network,
    @required this.user,
  });

  final NetworkService network;
  final UserService user;

  @override
  Future<List<Conversations>> downloadAll() async {
    final List<Map<String, dynamic>> dataList =
        await network.getAllItem(path: 'conversations');
    return <Conversations>[
      // ignore: sdk_version_ui_as_code
      for (Map<String, dynamic> data in dataList)
        Conversations(
          id: Id<Conversations>(data['_id']),
          title: data['title'],
          avatarURL: data['avatarURL'],
          timestamp: DateTime.parse(data['timestamp']),
          members: <User>[
            for (String id in data['membersIds'])
              await user.getUser(Id<User>(id)),
          ],
        ),
    ];
  }
}
