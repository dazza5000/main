///
//  Generated code. Do not modify.
//  source: chat.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'chat.pb.dart' as $0;
import 'google/protobuf/empty.pb.dart' as $1;
export 'chat.pb.dart';

class ChatServiceClient extends $grpc.Client {
  static final _$send = $grpc.ClientMethod<$0.Chat, $1.Empty>(
      '/v1.ChatService/Send',
      ($0.Chat value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));
  static final _$subscribe = $grpc.ClientMethod<$1.Empty, $0.Chat>(
      '/v1.ChatService/Subscribe',
      ($1.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Chat.fromBuffer(value));

  ChatServiceClient($grpc.ClientChannel channel, {$grpc.CallOptions options})
      : super(channel, options: options);

  $grpc.ResponseFuture<$1.Empty> send($0.Chat request,
      {$grpc.CallOptions options}) {
    final call = $createCall(_$send, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseStream<$0.Chat> subscribe($1.Empty request,
      {$grpc.CallOptions options}) {
    final call = $createCall(_$subscribe, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseStream(call);
  }
}

abstract class ChatServiceBase extends $grpc.Service {
  $core.String get $name => 'v1.ChatService';

  ChatServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.Chat, $1.Empty>(
        'Send',
        send_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Chat.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Empty, $0.Chat>(
        'Subscribe',
        subscribe_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $1.Empty.fromBuffer(value),
        ($0.Chat value) => value.writeToBuffer()));
  }

  $async.Future<$1.Empty> send_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Chat> request) async {
    return send(call, await request);
  }

  $async.Stream<$0.Chat> subscribe_Pre(
      $grpc.ServiceCall call, $async.Future<$1.Empty> request) async* {
    yield* subscribe(call, await request);
  }

  $async.Future<$1.Empty> send($grpc.ServiceCall call, $0.Chat request);
  $async.Stream<$0.Chat> subscribe($grpc.ServiceCall call, $1.Empty request);
}
