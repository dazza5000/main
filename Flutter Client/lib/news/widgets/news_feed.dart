import 'package:collection/collection.dart' show groupBy;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:com.winwisely99.app/services/services.dart';

import '../bloc/bloc.dart';
import '../bloc/data.dart';

class NewsFeed extends StatelessWidget {
  const NewsFeed({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ProxyProvider2<NetworkService, UserService, NewsBloc>(
      builder: (
        BuildContext _,
        NetworkService network,
        UserService user,
        NewsBloc __,
      ) =>
          NewsBloc(
        network: network,
        user: user,
      ),
      child: Scaffold(
          appBar: AppBar(
            title: const Text('News'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.comment),
                onPressed: () {
                  Navigator.of(context).pushNamed('/conversations');
                },
              )
            ],
          ),
          body: _NewsFeedBody()),
    );
  }
}

class _NewsFeedBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<News>>(
      stream: Provider.of<NewsBloc>(context).getNews(),
      builder: (BuildContext context, AsyncSnapshot<List<News>> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error occurred: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return Center(child: const CircularProgressIndicator());
        }

        final Map<DateTime, List<News>> news = groupBy<News, DateTime>(
          snapshot.data,
          (News h) => h.timestamp,
        );
        final List<DateTime> dates = news.keys.toList()
          ..sort((DateTime a, DateTime b) => b.compareTo(a));
        return ListView(
          children: ListTile.divideTiles(
            context: context,
            tiles: <Widget>[
// ignore: sdk_version_ui_as_code
              for (DateTime key in dates) ...<Widget>[
                for (News news in news[key])
                  Column(
                    children: <Widget>[
                      const SizedBox(height: 10.0),
                      ListTile(
                        title: Text(news.title),
                        subtitle: Column(
                          children: <Widget>[
                            const SizedBox(height: 10.0),
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5.0),
                                child: news.thumbnailUrl == null
                                    ? const Text('')
                                    : Image.network(
                                        news.thumbnailUrl,
                                      ),
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Text(
                              news.text,
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 10.0),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                DateFormat('MMM dd').format(news.timestamp),
                              ),
                            ),
                            const SizedBox(height: 10.0),
                          ],
                        ),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                            news.createdBy.avatarURL,
                          ),
                          child: const Text(''),
                        ),
                      ),
                    ],
                  ),
              ],
            ],
          ).toList(),
        );
      },
    );
  }
}
