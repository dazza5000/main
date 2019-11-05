import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:repository/repository.dart';

import 'package:com.winwisely99.app/services/services.dart';
import 'package:com.winwisely99.app/chat_view/chat_view.dart';

part 'data.g.dart';

@immutable
@HiveType()
class Conversations implements Entity {
  const Conversations({
    @required this.id,
    @required this.title,
    @required this.members,
    @required this.avatarURL,
    @required this.timestamp,
    this.membersIds,
    this.lastChat,
  })  : assert(id != null),
        assert(title != null),
        assert(members != null),
        assert(timestamp != null),
        assert(avatarURL != null);
  @HiveField(0)
  final Id<Conversations> id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final List<User> members;

  @HiveField(3)
  final String avatarURL;

  @HiveField(4)
  final DateTime timestamp;

  @HiveField(5)
  final List<Id<User>> membersIds;

  @HiveField(6)
  final ChatModel lastChat;
}
