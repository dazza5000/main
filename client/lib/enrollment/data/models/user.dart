import 'package:hive/hive.dart';

@HiveType()
class User {
  User(this.uuid, this.distance, this.issues, this.location);
  @HiveField(0)
  final String uuid;

  @HiveField(1)
  final double distance;

  @HiveField(2)
  final List<String> issues;

  @HiveField(3)
  final Location location;
}

@HiveType()
class Location {
  Location(this.country);
  @HiveType()
  final String country;
}
