import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Image.network(
              'https://images.squarespace-cdn.com/content/5985dfd0b8a79b27663a4a57/1539539574841-CEC34OXJ778L6EN32SGN/Logo+png.png?content-type=image%2Fpng',
              height: MediaQuery.of(context).size.height * 0.8,
            ),
          ),
          Center(
            child: RaisedButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/home', ModalRoute.withName('/login'));
              }, // TODO
              child: const Text('Sign In'),
            ),
          ),
          Center(
            child: FlatButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/userinfo');
              },
              child: const Text('Get Started'),
            ),
          )
        ],
      ),
    );
  }
}
