import 'package:flutter/material.dart';
import '../widgets/video_player.dart';

class CampainDetailsView extends StatelessWidget {
  const CampainDetailsView({Key key, this.campaign}) : super(key: key);
  final dynamic campaign;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Campaign Details'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //VidPlayer(videoUrl: campaign.videoUrl),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Text(campaign.name),
            ),
            Container(
              height: 0.5,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Text(campaign.mission),
            ),
            Container(
              height: 0.5,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Text(campaign.moto),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Text(campaign.significance),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Text(campaign.hisRational),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Text(campaign.strategy),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Text(campaign.barriers),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Text(campaign.endorsers),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Text(campaign.campCrucials),
            ),
          ],
        ),
      ),
    );
  }
}
