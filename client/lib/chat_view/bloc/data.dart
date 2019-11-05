import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:repository/repository.dart';

import 'package:com.winwisely99.app/services/services.dart';

part 'data.g.dart';

@HiveType()
enum AttachmentType {
  @HiveField(0)
  image,

  @HiveField(1)
  file,

  @HiveField(2)
  video,

  @HiveField(3)
  none,

  @HiveField(4)
  geolocation,

  @HiveField(5)
  calender,
}

@immutable
@HiveType()
class ChatModel implements Entity {
  const ChatModel({
    @required this.id,
    this.text,
    @required this.uid,
    @required this.createdAt,
    @required this.attachmentType,
    this.attachmentUrl,
    this.user,
    this.conversationsId,
  })  : assert(id != null),
        assert(uid != null),
        assert(attachmentType != null),
        assert(createdAt != null);

  @HiveField(0)
  final Id<ChatModel> id;

  @HiveField(1)
  final String text;

  @HiveField(2)
  final Id<User> uid;

  @HiveField(3)
  final User user;

  @HiveField(4)
  final DateTime createdAt;

  @HiveField(5)
  final AttachmentType attachmentType;

  @HiveField(6)
  final String attachmentUrl;

  @HiveField(7)
  final String conversationsId;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'text': text,
      'user': user,
      'createdAt': createdAt,
      'attachmentType': attachmentType,
      'attachmentUrl': attachmentUrl,
      'conversationsId': conversationsId,
    };
  }
}
