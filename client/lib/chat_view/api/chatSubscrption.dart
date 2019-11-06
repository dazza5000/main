import 'dart:io';
import 'dart:isolate';

import 'package:com.winwisely99.app/services/services.dart';
import 'package:grpc/grpc.dart';
import 'package:repository/repository.dart';

import '../api/v1/chat.pbgrpc.dart' as grpc;
import '../api/v1/google/protobuf/empty.pb.dart';
import '../api/v1/google/protobuf/timestamp.pb.dart';
import '../bloc/data.dart';

Future<dynamic> chatReceivingIsolate(SendPort portReceive) async {
  ClientChannel client;

  do {
    // create new client
    client ??= ClientChannel(
      '127.0.0.1', // Your IP here or localhost
      port: 3000,
      options: ChannelOptions(
        // TODO(Vineeth): Change to secure with server certificates
        credentials: const ChannelCredentials.insecure(),
        idleTimeout: Duration(seconds: 1),
      ),
    );

    final ResponseStream<grpc.Chat> stream =
        grpc.ChatServiceClient(client).subscribe(Empty.create());

    try {
      await for (grpc.Chat message in stream) {
        portReceive.send(MessageHandler<ChatModel>(
          message: ChatModel(
              id: Id<ChatModel>(message.id),
              text: message.text,
              uid: Id<User>(message.uid),
              createdAt: message.createdAt.toDateTime(),
              attachmentType: _getAttachmentType(message.attachmentType),
              attachmentUrl: message.attachmentUrl,
              conversationsId: message.conversationsId),
          status: MessageStatus.RECIEVED,
          messageType: MessageType.CHAT,
        ));
      }
    } catch (e) {
      // notify caller
      portReceive.send(MessageHandler<String>(
        message: e.toString(),
        messageType: MessageType.ERROR,
        status: MessageStatus.FAILED,
      ));
      // reset client
      client.shutdown();
      client = null;
    }
    // try to connect again
    sleep(Duration(seconds: 5));
  } while (true);
}

Future<bool> chatOnRecieveDo(dynamic message) async {
  // listen send status
  if (message is MessageHandler<ChatModel>) {
    final MessageHandler<ChatModel> _chat = message;
    // call for success handler
    switch (_chat.status) {
      case MessageStatus.NEW:
        break;
      case MessageStatus.RECIEVED:
        await hiveBox['chats'].put(_chat.message.id.id, _chat.message);
        // Write to block
        break;
      case MessageStatus.FAILED:
        // Notify error
        break;
      default:
        break;
    }
  } else {
    if (message is MessageHandler<String>) {
      assert(false, 'Error ${message.message}');
    } else {
      assert(false, 'Unknown event type ${message.runtimeType}');
    }
  }
  return true;
}

/// Thread to send messages
Future<dynamic> chatSendingIsolate(SendPort portSendStatus) async {
  // Port to get messages to send
  final ReceivePort portSendMessages = ReceivePort();

  // send port to send messages to the caller
  portSendStatus.send(portSendMessages.sendPort);

  ClientChannel client;

  // waiting messages to send
  await for (MessageHandler<ChatModel> message in portSendMessages) {
    bool sent = false;
    int retries = 0;
    do {
      // create new client
      client ??= ClientChannel(
        '127.0.0.1', // Your IP here or localhost
        port: 3000,
        options: ChannelOptions(
          // TODO(Vineeth): Change to secure with server certificates
          credentials: const ChannelCredentials.insecure(),
          idleTimeout: Duration(seconds: 1),
        ),
      );

      try {
        // try to send
        final grpc.Chat request = grpc.Chat()
          ..id = message.message.id.id
          ..text = message.message.text
          ..uid = message.message.uid.id
          ..createdAt = Timestamp.fromDateTime(message.message.createdAt)
          ..attachmentType =
              _convertAttachmentType(message.message.attachmentType)
          ..attachmentUrl = message.message.attachmentUrl
          ..conversationsId = message.message.conversationsId;
        await grpc.ChatServiceClient(client).send(request);
        // sent successfully
        message.status = MessageStatus.SENT;
        portSendStatus.send(message);
        sent = true;
      } catch (e) {
        // sent failed
        message.status = MessageStatus.FAILED;
        portSendStatus.send(message);
        // reset client
        client.shutdown();
        client = null;
      }

      if (!sent) {
        // try to send again
        retries = retries + 1;
        sleep(Duration(seconds: 5));
      }
      if (retries > 10) {
        break;
      }
    } while (!sent);
  }
}

Future<bool> chatOnSendDo(dynamic message) async {
  // listen send status
  if (message is MessageHandler<ChatModel>) {
    final MessageHandler<ChatModel> _chat = message;
    // call for success handler
    switch (_chat.status) {
      case MessageStatus.NEW:
        break;
      case MessageStatus.SENT:
        // Write to block
        await hiveBox['chats'].put(_chat.message.id.id, message.message);
        break;
      case MessageStatus.FAILED:
        // Notify error
        break;
      default:
    }
  } else {
    assert(false, 'Unknown event type ${message.runtimeType}');
  }
  return true;
}

AttachmentType _getAttachmentType(
  grpc.Chat_AttachmentType chatAttachmentType,
) {
  switch (chatAttachmentType) {
    case grpc.Chat_AttachmentType.NONE:
      return AttachmentType.none;
      break;
    case grpc.Chat_AttachmentType.IMAGE:
      return AttachmentType.image;
      break;
    case grpc.Chat_AttachmentType.VIDEO:
      return AttachmentType.video;
      break;
    case grpc.Chat_AttachmentType.FILE:
      return AttachmentType.file;
      break;
    case grpc.Chat_AttachmentType.GEOLOCATION:
      return AttachmentType.geolocation;
      break;
    case grpc.Chat_AttachmentType.CALENDER:
      return AttachmentType.calender;
      break;
    default:
      return AttachmentType.none;
      break;
  }
}

grpc.Chat_AttachmentType _convertAttachmentType(
  AttachmentType chatAttachmentType,
) {
  switch (chatAttachmentType) {
    case AttachmentType.none:
      return grpc.Chat_AttachmentType.NONE;
      break;
    case AttachmentType.image:
      return grpc.Chat_AttachmentType.IMAGE;
      break;
    case AttachmentType.video:
      return grpc.Chat_AttachmentType.VIDEO;
      break;
    case AttachmentType.file:
      return grpc.Chat_AttachmentType.FILE;
      break;
    case AttachmentType.geolocation:
      return grpc.Chat_AttachmentType.GEOLOCATION;
      break;
    case AttachmentType.calender:
      return grpc.Chat_AttachmentType.CALENDER;
      break;
    default:
      return grpc.Chat_AttachmentType.NONE;
      break;
  }
}
