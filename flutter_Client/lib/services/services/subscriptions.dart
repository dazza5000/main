import 'dart:isolate';
import 'package:meta/meta.dart';

class Subscriptions<T> {
  Subscriptions({
    @required this.receivingIsolate,
    @required this.sendingIsolate,
    @required this.onSendDo,
    @required this.onRecieveDo,
  })  : portReceiving = ReceivePort(),
        portSendStatus = ReceivePort();

  void Function(SendPort portReceive) receivingIsolate;
  void Function(SendPort portSend) sendingIsolate;

  /// Port to receive messages
  ReceivePort portReceiving;

  /// Port to get status of message sending
  ReceivePort portSendStatus;

  /// Port to send message
  SendPort portSending;

  /// _isolateSending is isolate to send chat messages
  Isolate isolateSending;

  /// _isolateReceiving is isolate to receive chat messages
  Isolate isolateReceiving;

  /// Actions to perform on sending a message
  Future<bool> Function(dynamic message) onSendDo;

  /// Actions to perform on recieving a message
  Future<bool> Function(dynamic message) onRecieveDo;

  /// Actions to perform on send
  Future<bool> onSend() async {
    await for (dynamic event in portSendStatus) {
      // Register the sendport from the isolate to recieve messages
      if (event is SendPort) {
        portSending = event;
      } else {
        onSendDo(event);
      }
    }
    return true;
  }

  /// Actions to perform on recieve
  Future<bool> onRecieve() async {
    await for (dynamic event in portReceiving) {
      onRecieveDo(event);
    }
    return true;
  }
}
