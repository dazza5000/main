import 'package:flutter/material.dart';

import '../services.dart';

/// This splash screen waits for all the services to be initialized. When they
/// are, it automatically redirects either to the [NewsFeed] or the
/// [LoginScreen] based on whether the user is logged in.
class SplashScreen extends StatelessWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<dynamic>.microtask(() async {
      await storageReady;
      await networkReady;
      await userServiceReady;
      // TODO(Vineeth): Add the authentication logic here
      await authUserReady;
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/news', ModalRoute.withName('/'));
    });

    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: const CircularProgressIndicator(),
    );
  }
}
