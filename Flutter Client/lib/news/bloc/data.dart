import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:repository/repository.dart';

import 'package:com.winwisely99.app/services/services.dart';

part 'data.g.dart';

@immutable
@HiveType()
class News implements Entity {
  const News({
    @required this.id,
    @required this.title,
    @required this.text,
    @required this.timestamp,
    @required this.thumbnailUrl,
    this.uid,
    this.createdBy,
  })  : assert(id != null),
        assert(title != null),
        assert(timestamp != null),
        assert(thumbnailUrl != null);

  @HiveField(0)
  final Id<News> id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String text;

  @HiveField(3)
  final String thumbnailUrl;

  @HiveField(4)
  final DateTime timestamp;

  @HiveField(5)
  final Id<User> uid;

  @HiveField(6)
  final User createdBy;
}
