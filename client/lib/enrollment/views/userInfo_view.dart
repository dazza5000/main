import 'package:flutter/material.dart';

import 'package:com.winwisely99.app/services/services.dart';

class UserInfoView extends StatelessWidget {
  UserInfoView({Key key}) : super(key: key);
  final countries = ['Germany', 'Australia', 'Pakistan', 'USA'];
  final cities = ['Berlin', 'Newyork', 'Vancouver', 'Shanghai'];
  final issues = ['Student Debt', 'Health Care', 'Climate'];
  final campaings = ['XR', 'Fridays for future'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Classify the user'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('1. Where are you?'),
              Utils.verticalMargin(16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  children: <Widget>[
                    _select(countries, 'Select Country'),
                    Utils.verticalMargin(10),
                    _select(cities, 'Select City'),
                    Utils.verticalMargin(10),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Zip Code',
                      ),
                    ),
                    Utils.verticalMargin(10),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: 'Your Location',
                          suffix: Icon(Icons.search)),
                    ),
                  ],
                ),
              ),
              Utils.verticalMargin(32),
              Text('2. Travel distance you can afford?'),
              Utils.verticalMargin(16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Distance in KM',
                  ),
                ),
              ),
              Utils.verticalMargin(32),
              Text('3. Issue with enviornment?'),
              Utils.verticalMargin(16),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: _select(issues, 'Your Issue')),
              Utils.verticalMargin(32),
              Text('4. Any Campaign Affiliations ?'),
              Utils.verticalMargin(16),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: _select(campaings, 'Select Affiliation ')),
              Utils.verticalMargin(32),
              Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(right: 16),
                child: RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/campaignview');
                  },
                  child: Text('Next'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  DropdownButton _select(List<String> items, String hint,
      [IconData iconData = Icons.arrow_drop_down]) {
    return DropdownButton<String>(
      icon: Icon(iconData),
      iconSize: 24,
      elevation: 16,
      isExpanded: true,
      hint: Text(hint),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String newValue) {},
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
