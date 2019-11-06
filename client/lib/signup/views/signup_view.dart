import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:com.winwisely99.app/services/services.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).canvasColor,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(48),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.network(
                'https://images.squarespace-cdn.com/content/5985dfd0b8a79b27663a4a57/1539539574841-CEC34OXJ778L6EN32SGN/Logo+png.png?content-type=image%2Fpng',
                width: 200,
                height: 100,
              ),
              Utils.verticalMargin(32),
              Text("Sign up for you account",
                  style: Theme.of(context).textTheme.display1),
              Utils.verticalMargin(32),
              TextFormField(
                cursorColor: Colors.grey,
                decoration: InputDecoration(
                  labelText: "Email Address",
                  labelStyle: Theme.of(context).textTheme.body2,
                  suffix: Icon(MdiIcons.emailOutline),
                ),
              ),
              Utils.verticalMargin(16),
              TextFormField(
                cursorColor: Colors.grey,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  labelStyle: Theme.of(context).textTheme.body2,
                  suffix: Icon(Icons.lock_outline),
                ),
              ),
              Utils.verticalMargin(32),
              Row(
                children: <Widget>[
                  Text("Meet up with others?"),
                  Radio(
                    value: "yes",
                  ),
                  Radio(
                    value: "now",
                  ),
                ],
              ),
              Utils.verticalMargin(32),
              Text("Setup notification channel"),
              Utils.verticalMargin(8),
              Row(
                children: <Widget>[
                  Text("Email"),
                  Spacer(),
                  Switch(
                    onChanged: null, //TODO
                    value: true,
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Text("App Messaging"),
                  Spacer(),
                  Text("Enabled")
                ],
              ),
              Utils.verticalMargin(60),
              Container(
                width: MediaQuery.of(context).size.width,
                child: RaisedButton(
                  color: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text("Sign Up",
                      style: Theme.of(context).textTheme.body2.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  onPressed: () {}, // TODO
                ),
              ),
              Utils.verticalMargin(48),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Need a protonmail?"),
                  InkWell(
                    onTap: () {
                      _showBottomSheet(context);
                    },
                    child: Text("Explain why?",
                        style: Theme.of(context).textTheme.body2.copyWith(
                            color: Colors.blue, fontWeight: FontWeight.bold)),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet<Widget>(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16))),
        context: context,
        builder: (BuildContext con) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Utils.verticalMargin(4),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 40,
                    color: Colors.grey,
                    height: 4,
                  ),
                ),
                Utils.verticalMargin(32),
                Text(
                  "Why Protonmail",
                  style: Theme.of(context).textTheme.display1,
                ),
                Utils.verticalMargin(32),
                Text(
                    " It uses end-to-end encryption, meaning that only the people sending and receiving messages can read them, and it was founded by former CERN and MIT scientists, so the implication is that it’s basically the Fort Knox of email providers. It’s the email provider of choice for Elliot, the hacker protagonist on Mr. Robot."),
                Utils.verticalMargin(16),
                Text("Would you like to get the protonmail?"),
                Utils.verticalMargin(16),
                ButtonBar(
                  children: <Widget>[
                    FlatButton(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text("No",
                          style: Theme.of(context).textTheme.body2.copyWith(
                              color: Colors.blue, fontWeight: FontWeight.bold)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    RaisedButton(
                      color: Colors.blue,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text("Yes",
                          style: Theme.of(context).textTheme.body2.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      onPressed: () {}, // TODO
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }
}
