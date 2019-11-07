import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// TODO(FlutterDevelopers): Import modules here
import 'package:com.winwisely99.app/chat_view/chat_view.dart';
import 'package:com.winwisely99.app/enrollment/enrollment.dart';
import 'package:com.winwisely99.app/signup/signup.dart';
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
    case '/settings':
      _route = MaterialPageRoute<dynamic>(
        builder: (BuildContext context) {
          return ChangeNotifierProvider<AppConfiguration>.value(
            value: Provider.of<AppConfiguration>(context),
            child: const Settings(),
          );
        },
      );
      break;
    case '/campaignview':
      _route = MaterialPageRoute<dynamic>(
        builder: (BuildContext context) {
          return CampaignView(
            key: ValueKey<String>(settings.name),
          );
        },
      );
      break;
    case '/generalcampaign':
      _route = MaterialPageRoute<dynamic>(
        builder: (BuildContext context) {
          return GeneralCampaignView(
            key: ValueKey<String>(settings.name),
          );
        },
      );
      break;
    case '/home':
      _route = MaterialPageRoute<dynamic>(
        builder: (BuildContext context) {
          return HomeScreen(
            key: ValueKey<String>(settings.name),
          );
        },
      );
      break;
    case '/login':
      _route = MaterialPageRoute<dynamic>(
        builder: (BuildContext context) {
          return LoginScreen(
            key: ValueKey<String>(settings.name),
          );
        },
      );
      break;
    case '/notready':
      _route = MaterialPageRoute<dynamic>(
        builder: (BuildContext context) {
          return NotReadyView(
            key: ValueKey<String>(settings.name),
          );
        },
      );
      break;
    case '/signup':
      _route = MaterialPageRoute<dynamic>(
        builder: (BuildContext context) {
          return SignUpView(
            key: ValueKey<String>(settings.name),
          );
        },
      );
      break;
    case '/supportroles':
      _route = MaterialPageRoute<dynamic>(
        builder: (BuildContext context) {
          return SupportRolesView(
            key: ValueKey<String>(settings.name),
          );
        },
      );
      break;
    case '/userinfo':
      _route = MaterialPageRoute<dynamic>(
        builder: (BuildContext context) {
          return UserInfoView(
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
        case 'campaigndetails':
          // /campaigndetails/{campaignID}
          _route = MaterialPageRoute<dynamic>(
            builder: (BuildContext context) {
              return CampainDetailsView(
                key: ValueKey<String>(settings.name),
                campaign: info[2],
                // need to add campaign
              );
            },
          );
          break;
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
              return HomeScreen(
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
