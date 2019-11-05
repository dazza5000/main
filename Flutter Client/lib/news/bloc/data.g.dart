// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NewsAdapter extends TypeAdapter<News> {
  @override
  News read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return News(
      id: fields[0] as Id,
      title: fields[1] as String,
      text: fields[2] as String,
      timestamp: fields[4] as DateTime,
      thumbnailUrl: fields[3] as String,
      uid: fields[5] as Id,
      createdBy: fields[6] as User,
    );
  }

  @override
  void write(BinaryWriter writer, News obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.text)
      ..writeByte(3)
      ..write(obj.thumbnailUrl)
      ..writeByte(4)
      ..write(obj.timestamp)
      ..writeByte(5)
      ..write(obj.uid)
      ..writeByte(6)
      ..write(obj.createdBy);
  }
}
