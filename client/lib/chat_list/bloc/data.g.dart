// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ConversationsAdapter extends TypeAdapter<Conversations> {
  @override
  Conversations read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Conversations(
      id: fields[0] as Id,
      title: fields[1] as String,
      members: (fields[2] as List)?.cast<User>(),
      avatarURL: fields[3] as String,
      timestamp: fields[4] as DateTime,
      membersIds: (fields[5] as List)?.cast<Id>(),
      lastChat: fields[6] as ChatModel,
    );
  }

  @override
  void write(BinaryWriter writer, Conversations obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.members)
      ..writeByte(3)
      ..write(obj.avatarURL)
      ..writeByte(4)
      ..write(obj.timestamp)
      ..writeByte(5)
      ..write(obj.membersIds)
      ..writeByte(6)
      ..write(obj.lastChat);
  }
}
