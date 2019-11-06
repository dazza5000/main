import 'package:flutter/material.dart';

import '../data/mockData/campaigns.dart';

class CampaignView extends StatelessWidget {
  CampaignView({Key key}) : super(key: key);
  final List<Campaign> campaigns = [
    Campaign('XR'),
    Campaign('Fridays for future'),
    Campaign('Greta'),
    Campaign('Campain 4'),
    Campaign('Campain 5'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Campaign'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: campaigns.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildExpando(campaigns[index], context);
        },
      ),
    );
  }

  Widget _buildExpando(Campaign campaign, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        shape: RoundedRectangleBorder(
            side: BorderSide(width: 0.5, color: Colors.grey)),
        elevation: 0,
        child: Column(
          children: <Widget>[
            ExpansionTile(
              title: Text(campaign.name),
              children: <Widget>[
                ListTile(
                  title: Text(campaign.videoUrl),
                )
              ],
            ),
            Container(
              height: 0.5,
              color: Colors.grey,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed('/generalcampaign');
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.5 - 16,
                      height: 40,
                      alignment: Alignment.center,
                      child: const Text('Select')),
                ),
                Container(
                  height: 40,
                  width: 0.5,
                  color: Colors.grey,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed('/campaigndetails/$campaign');
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.5 - 16,
                      height: 40,
                      alignment: Alignment.center,
                      child: const Text('View Details')),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
