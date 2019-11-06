import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:com.winwisely99.app/services/services.dart';

import '../data/mockData/support_roles.dart';

class SupportRolesView extends StatefulWidget {
  SupportRolesView({Key key}) : super(key: key);

  @override
  _SupportRolesViewState createState() => _SupportRolesViewState();
}

class _SupportRolesViewState extends State<SupportRolesView> {
  int _number = 1;
  final List<SupportRoles> supportRoles = [
    SupportRoles("Lawyer", description),
    SupportRoles("Social Media ", description),
    SupportRoles("Transport", description),
    SupportRoles("Child care", description),
    SupportRoles("Bail support", description),
    SupportRoles("Phonebanker or p2p texter", description),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Roles"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: _supportRolesList(supportRoles),
      ),
    );
  }

  Widget _supportRolesList(List<SupportRoles> roles) {
    return ListView.builder(
      itemCount: roles.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: <Widget>[
            _supportRole(roles[index], context),
            Utils.verticalMargin(16)
          ],
        );
      },
    );
  }

  Widget _supportRole(SupportRoles role, BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border.all(width: 0.5),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      width: MediaQuery.of(context).size.width - 32,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(role.title,
              style: Theme.of(context)
                  .textTheme
                  .body1
                  .copyWith(fontWeight: FontWeight.bold)),
          Utils.verticalMargin(16),
          Text(role.description),
          Utils.verticalMargin(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text("Minimum hours you can dedicate"),
              Spacer(),
              Text("$_number hr",
                  style: Theme.of(context)
                      .textTheme
                      .body1
                      .copyWith(fontWeight: FontWeight.bold)),
              SizedBox(
                width: 16,
              )
            ],
          ),
          Row(
            children: <Widget>[
              Text("Choose"),
              Spacer(),
              NumberPicker.horizontal(
                  initialValue: _number,
                  minValue: 0,
                  maxValue: 24,
                  onChanged: (value) {
                    setState(() {
                      _number = value;
                    });
                  }),
            ],
          )
        ],
      ),
    );
  }
}
