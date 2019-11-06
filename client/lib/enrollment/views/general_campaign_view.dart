import 'package:flutter/material.dart';
import 'package:com.winwisely99.app/services/services.dart';

import '../data/mockData/campaign_genreal.dart';

class GeneralCampaignView extends StatelessWidget {
  GeneralCampaignView({Key key}) : super(key: key);
  final CampaignGeneral campaignGeneral = CampaignGeneral();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Campaign Name'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Utils.verticalMargin(16),
              const Text('Here are some details and videos\nto fill you up'),
              Utils.verticalMargin(32),
              const Text('1. Story Link'),
              Utils.verticalMargin(16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Text(campaignGeneral.videoUrl),
              ),
              Utils.verticalMargin(16),
              const Text('2. Other Details'),
              Utils.verticalMargin(16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Text(campaignGeneral.details),
              ),
              Utils.verticalMargin(16),
              const Text('3. More Videos'),
              Utils.verticalMargin(16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Text(campaignGeneral.urls[0]),
              ),

              //TODO : Make slivers
              // SizedBox(
              //   height: 16,
              // ),
              // Text('3. Helping Content Links'),
              // SizedBox(
              //   height: 16,
              // ),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 32),
              //   child: Text('more urls')
              // ),

              ButtonBar(
                children: <Widget>[
                  FlatButton(
                    color: Colors.white,
                    textColor: Colors.blue,
                    onPressed: () {
                      Navigator.of(context).pushNamed('/notready');
                    },
                    child: const Text('Not Ready'),
                  ),
                  RaisedButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.of(context).pushNamed('/signup');
                    },
                    child: const Text('Ready'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

/*   List<Widget> _buildUrlList() {
    return campaignGeneral.urls.map((url) {
      return Text(url);
    });
  } */
}
