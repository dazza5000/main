import 'package:collection/collection.dart' show groupBy;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:com.winwisely99.app/services/services.dart';
import 'package:com.winwisely99.app/chat_view/chat_view.dart';

import '../bloc/bloc.dart';
import '../bloc/data.dart';

class ConversationsFeed extends StatelessWidget {
  const ConversationsFeed({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildCloneableWidget>[
        ProxyProvider2<NetworkService, UserService, ConversationsBloc>(
          builder: (BuildContext _, NetworkService network, UserService user,
                  ConversationsBloc __) =>
              ConversationsBloc(
            network: network,
            user: user,
          ),
        ),
      ],
      child: _ConversationsFeedBody(),
    );
  }
}

class _ConversationsFeedBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Conversations>>(
      stream: Provider.of<ConversationsBloc>(context).getConversations(),
      builder:
          (BuildContext context, AsyncSnapshot<List<Conversations>> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error occurred: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return Center(child: const CircularProgressIndicator());
        }

        final Map<DateTime, List<Conversations>> conversations =
            groupBy<Conversations, DateTime>(
          snapshot.data,
          (Conversations h) => h.timestamp,
        );
        final List<DateTime> dates = conversations.keys.toList()
          ..sort((DateTime a, DateTime b) => b.compareTo(a));
        return ListView(
          children: ListTile.divideTiles(
            context: context,
            tiles: <Widget>[
// ignore: sdk_version_ui_as_code
              for (DateTime key in dates) ...<Widget>[
                for (Conversations conversation in conversations[key])
                  Column(
                    children: <Widget>[
                      const SizedBox(height: 10.0),
                      ProxyProvider2<NetworkService, UserService, ChatBloc>(
                        builder: (BuildContext _, NetworkService network,
                                UserService user, ChatBloc __) =>
                            ChatBloc(
                                network: network,
                                user: user,
                                conversationsId: conversation.id.id),
                        child: _ConversationTile(
                          conversation: conversation,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                    ],
                  ),
              ],
            ],
          ).toList(),
        );
      },
    );
  }
}

class _ConversationTile extends StatelessWidget {
  const _ConversationTile({Key key, this.conversation}) : super(key: key);
  final Conversations conversation;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ChatModel>>(
        stream: Provider.of<ChatBloc>(context).getChats(),
        builder:
            (BuildContext context, AsyncSnapshot<List<ChatModel>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).primaryColor,
                ),
              ),
            );
          } else {
            ChatModel lastChat;
            if (snapshot.data.isNotEmpty) {
              final List<ChatModel> _list = snapshot.data;
              _list.sort((ChatModel a, ChatModel b) =>
                  b.createdAt.compareTo(a.createdAt));
              lastChat = _list.firstWhere(
                  (ChatModel chat) =>
                      chat.conversationsId == conversation.id.id,
                  orElse: null);
            } else {
              lastChat = null;
            }
            return ListTile(
              onTap: () {
                Navigator.of(context)
                    .pushNamed('/chatfeed/${conversation.id.id}');
              },
              title: Text(conversation.title),
              subtitle: Text(
                lastChat != null ? lastChat.text : 'No messages',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(conversation.avatarURL),
                child: const Text(''),
              ),
            );
          }
        });
  }
}
