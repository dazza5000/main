import 'package:flutter/material.dart';

import 'package:com.winwisely99.app/services/services.dart';

class NotReadyView extends StatelessWidget {
  const NotReadyView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "What meterics you need to join?",
                style: Theme.of(context).textTheme.display1,
              ),
              Utils.verticalMargin(32),
              Text("1. How much willing you are to join?"),
              Utils.verticalMargin(16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Slider(
                  min: 0.0,
                  max: 100,
                  value: 30,
                  onChanged: null,
                ),
              ),
              Utils.verticalMargin(16),
              Row(
                children: <Widget>[
                  Text("2. I need to be more confident re legal defense "),
                  Spacer(),
                  Checkbox(
                    value: true,
                    onChanged: null,
                  )
                ],
              ),
              Utils.verticalMargin(16),
              Row(
                children: <Widget>[
                  Text("3. I need to be more confident re legal defense "),
                  Spacer(),
                  Checkbox(
                    value: true,
                    onChanged: null,
                  )
                ],
              ),
              Utils.verticalMargin(16),
              Row(
                children: <Widget>[
                  Text("4. I need to be invited to join by a friend"),
                  Spacer(),
                  Checkbox(
                    value: true,
                    onChanged: null,
                  )
                ],
              ),
              Utils.verticalMargin(16),
              Row(
                children: <Widget>[
                  Text(
                      "5. I’m a party animal: I need to be invited to a \nparty of other strikers and conditional strikers"),
                  Spacer(),
                  Checkbox(
                    value: true,
                    onChanged: null,
                  )
                ],
              ),
              Utils.verticalMargin(16),
              Row(
                children: <Widget>[
                  Text("6. Need transport"),
                  Spacer(),
                  Checkbox(
                    value: true,
                    onChanged: null,
                  )
                ],
              ),
              Utils.verticalMargin(16),
              Row(
                children: <Widget>[
                  Text("7. Need bail support"),
                  Spacer(),
                  Checkbox(
                    value: true,
                    onChanged: null,
                  )
                ],
              ),
              Utils.verticalMargin(16),
              Row(
                children: <Widget>[
                  Text("8. Need childcare"),
                  Spacer(),
                  Checkbox(
                    value: true,
                    onChanged: null,
                  )
                ],
              ),
              Utils.verticalMargin(16),
              Row(
                children: <Widget>[
                  Text(
                      "9. Need housing (if long term strike and worry\n about losing housing)"),
                  Spacer(),
                  Checkbox(
                    value: true,
                    onChanged: null,
                  )
                ],
              ),
              Utils.verticalMargin(16),
              TextFormField(
                maxLines: 5,
                decoration: new InputDecoration(
                  labelText: "Write another need you have....",
                  alignLabelWithHint: true,
                  hintText: "Write another need you have....",
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(4.0),
                    borderSide: new BorderSide(),
                  ),
                  //fillColor: Colors.green
                ),
                validator: (String val) {
                  if (val.isEmpty) {
                    return 'Email cannot be empty';
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                ),
              ),
              Utils.verticalMargin(16),
              const Text(
                '10. If we cannot satisfy your conditions, would you be willing to consider providing a support role to those willing to strike?',
              ),
              Utils.verticalMargin(16),
              ButtonBar(
                children: <Widget>[
                  FlatButton(
                    textColor: Colors.blue,
                    onPressed: () {}, //TODO
                    child: const Text('No'),
                  ),
                  RaisedButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.of(context).pushNamed('/supportroles');
                    },
                    child: const Text('Yes'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
