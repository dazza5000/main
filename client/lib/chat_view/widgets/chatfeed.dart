import 'package:intl/intl.dart';
import 'package:dash_chat/dash_chat.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repository/repository.dart';

import 'package:com.winwisely99.app/chat_list/chat_list.dart';
import 'package:com.winwisely99.app/services/services.dart';
import '../bloc/bloc.dart';
import '../bloc/data.dart';

class ChatFeed extends StatelessWidget {
  const ChatFeed({Key key, @required this.conversationsId}) : super(key: key);
  final String conversationsId;
  @override
  Widget build(BuildContext context) {
    return ProxyProvider2<NetworkService, UserService, ChatBloc>(
      builder: (BuildContext _, NetworkService network, UserService user,
              ChatBloc __) =>
          ChatBloc(
        network: network,
        user: user,
        conversationsId: conversationsId,
      ),
      child: _ChatFeedView(conversationsId: conversationsId),
    );
  }
}

class _ChatFeedView extends StatelessWidget {
  const _ChatFeedView({
    Key key,
    @required this.conversationsId,
  }) : super(key: key);

  final String conversationsId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<Conversations>(
          future: Provider.of<ChatBloc>(context)
              .getConversation(Id<Conversations>(conversationsId)),
          builder: (
            BuildContext context,
            AsyncSnapshot<Conversations> snapshot,
          ) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor,
                  ),
                ),
              );
            } else {
              return ListTile(
                title: Text(snapshot.data.title),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                    snapshot.data.avatarURL,
                  ),
                  child: const Text(''),
                ),
              );
            }
          },
        ),
      ),
      body: FutureBuilder<User>(
          future: Provider.of<ChatBloc>(context).getCurrentUser(),
          builder: (BuildContext context, AsyncSnapshot<User> user) {
            if (!user.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor,
                  ),
                ),
              );
            }
            return _ChatFeedBody(
              user: ChatUser(
                name: user.data.name,
                uid: user.data.id.id,
                avatar: user.data.avatarURL,
              ),
              conversationsId: conversationsId,
            );
          }),
    );
  }
}

class _ChatFeedBody extends StatefulWidget {
  const _ChatFeedBody({this.user, this.conversationsId});
  final ChatUser user;
  final String conversationsId;
  @override
  _ChatFeedBodyState createState() => _ChatFeedBodyState();
}

class _ChatFeedBodyState extends State<_ChatFeedBody> {
  final GlobalKey<DashChatState> _chatViewKey = GlobalKey<DashChatState>();

  @override
  Widget build(BuildContext context) {
    final ChatBloc _chatBloc = Provider.of<ChatBloc>(context);
    return StreamBuilder<Map<Id<ChatModel>, ChatModel>>(
      stream: _chatBloc.chatScreen,
      builder: (BuildContext context,
          AsyncSnapshot<Map<Id<ChatModel>, ChatModel>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).primaryColor,
              ),
            ),
          );
        }
        if (snapshot.data == null) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).primaryColor,
              ),
            ),
          );
        }
        List<ChatMessage> messages = snapshot.data.values
            .map((ChatModel chat) => ChatMessage(
                  id: chat.id.id,
                  text: chat.text,
                  user: ChatUser(
                    uid: chat.user.id.id,
                    name: chat.user.displayName,
                    avatar: chat.user.avatarURL,
                  ),
                  image: chat.attachmentType == AttachmentType.image
                      ? chat.attachmentUrl
                      : null,
                  vedio: chat.attachmentType == AttachmentType.video
                      ? chat.attachmentUrl
                      : null,
                  createdAt: chat.createdAt,
/*                     quickReplies: QuickReplies(
                      values: <Reply>[
                        Reply(
                          title: "😋 Yes",
                          value: "Yes",
                        ),
                        Reply(
                          title: "😞 Nope. What?",
                          value: "no",
                        ),
                      ],
                    ), */
                ))
            .toList();

        return DashChat(
          key: _chatViewKey,
          inverted: false,
          onSend: (ChatMessage message) async {
            await _chatBloc.sendChat(
              ChatModel(
                id: Id<ChatModel>(UniqueKey().toString()),
                uid: Id<User>(widget.user.uid),
                text: message.text,
                createdAt: DateTime.now().toUtc(),
                attachmentType: AttachmentType.none,
                attachmentUrl: '',
                conversationsId: widget.conversationsId,
              ),
            );
          },
          user: widget.user,
          inputDecoration:
              InputDecoration.collapsed(hintText: 'Add message here...'),
          dateFormat: DateFormat('yyyy-MMM-dd'),
          timeFormat: DateFormat('HH:mm'),
          messages: messages,
          showUserAvatar: true,
          showAvatarForEveryMessage: false,
          scrollToBottom: false,
          onPressAvatar: (ChatUser user) {
            print('OnPressAvatar: ${user.name}');
          },
          onLongPressAvatar: (ChatUser user) {
            print('OnLongPressAvatar: ${user.name}');
          },
          inputMaxLines: 5,
          messageContainerPadding: const EdgeInsets.only(left: 5.0, right: 5.0),
          alwaysShowSend: true,
          inputTextStyle: TextStyle(fontSize: 16.0),
          inputContainerStyle: BoxDecoration(
            border: Border.all(width: 0.0),
            color: Colors.white,
          ),
          onQuickReply: (Reply reply) {
            setState(
              () {
                messages.add(
                  ChatMessage(
                      text: reply.value,
                      createdAt: DateTime.now(),
                      user: widget.user),
                );
// ignore: sdk_version_ui_as_code
                messages = <ChatMessage>[...messages];
              },
            );
          },
        );
      },
    );
  }
}
