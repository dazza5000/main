// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AttachmentTypeAdapter extends TypeAdapter<AttachmentType> {
  @override
  AttachmentType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return AttachmentType.image;
      case 1:
        return AttachmentType.file;
      case 2:
        return AttachmentType.video;
      case 3:
        return AttachmentType.none;
      case 4:
        return AttachmentType.geolocation;
      case 5:
        return AttachmentType.calender;
      default:
        return null;
    }
  }

  @override
  void write(BinaryWriter writer, AttachmentType obj) {
    switch (obj) {
      case AttachmentType.image:
        writer.writeByte(0);
        break;
      case AttachmentType.file:
        writer.writeByte(1);
        break;
      case AttachmentType.video:
        writer.writeByte(2);
        break;
      case AttachmentType.none:
        writer.writeByte(3);
        break;
      case AttachmentType.geolocation:
        writer.writeByte(4);
        break;
      case AttachmentType.calender:
        writer.writeByte(5);
        break;
    }
  }
}

class ChatModelAdapter extends TypeAdapter<ChatModel> {
  @override
  ChatModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChatModel(
      id: fields[0] as Id,
      text: fields[1] as String,
      uid: fields[2] as Id,
      createdAt: fields[4] as DateTime,
      attachmentType: fields[5] as AttachmentType,
      attachmentUrl: fields[6] as String,
      user: fields[3] as User,
      conversationsId: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ChatModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.text)
      ..writeByte(2)
      ..write(obj.uid)
      ..writeByte(3)
      ..write(obj.user)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.attachmentType)
      ..writeByte(6)
      ..write(obj.attachmentUrl)
      ..writeByte(7)
      ..write(obj.conversationsId);
  }
}
