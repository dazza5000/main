import 'package:flutter/material.dart';
// TODO(FlutterDevelopers): Import modules here
import 'package:com.winwisely99.app/chat_view/chat_view.dart';
import 'package:com.winwisely99.app/conversations/conversations.dart';
import 'package:com.winwisely99.app/news/news.dart';
import 'package:com.winwisely99.app/services/services.dart';

Route<dynamic> routes(RouteSettings settings) {
  MaterialPageRoute<dynamic> _route;
  // TODO(FlutterDevelopers): Add the path to module as a 'case'
  switch (settings.name) {
    case '/':
      _route = MaterialPageRoute<dynamic>(
        builder: (BuildContext context) {
          return SplashScreen(
            key: ValueKey<String>(settings.name),
          );
        },
      );
      break;
    case '/news':
      _route = MaterialPageRoute<dynamic>(
        builder: (BuildContext context) {
          return NewsFeed(
            key: ValueKey<String>(settings.name),
          );
        },
      );
      break;
    case '/conversations':
      _route = MaterialPageRoute<dynamic>(
        builder: (BuildContext context) {
          return ConversationsFeed(
            key: ValueKey<String>(settings.name),
          );
        },
      );
      break;
    default:
      // TODO(FlutterDevelopers): Add the path to module as a 'case' - user this when data needs to be
      // passed to the module
      final List<String> info = settings.name.split('/');
      switch (info[1]) {
        case 'chatfeed':
          // /chatfeed/{conversationID}
          _route = MaterialPageRoute<dynamic>(
            settings: settings,
            builder: (BuildContext context) {
              return ChatFeed(
                key: ValueKey<String>(settings.name),
                conversationsId: info[2],
                //         user: ,
              );
            },
          );
          break;
        default:
          _route = MaterialPageRoute<dynamic>(
            builder: (BuildContext context) {
              return NewsFeed(
                key: ValueKey<String>(settings.name),
              );
            },
          );
          break;
      }
      break;
  }
  return _route;
}
