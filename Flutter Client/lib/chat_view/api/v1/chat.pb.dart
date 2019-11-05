///
//  Generated code. Do not modify.
//  source: chat.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $2;

import 'chat.pbenum.dart';

export 'chat.pbenum.dart';

class Chat extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Chat', package: const $pb.PackageName('v1'), createEmptyInstance: create)
    ..aOS(1, 'id')
    ..aOS(2, 'text')
    ..aOS(3, 'uid')
    ..aOM<$2.Timestamp>(4, 'createdAt', protoName: 'createdAt', subBuilder: $2.Timestamp.create)
    ..e<Chat_AttachmentType>(5, 'attachmentType', $pb.PbFieldType.OE, protoName: 'attachmentType', defaultOrMaker: Chat_AttachmentType.NONE, valueOf: Chat_AttachmentType.valueOf, enumValues: Chat_AttachmentType.values)
    ..aOS(6, 'attachmentUrl', protoName: 'attachmentUrl')
    ..aOS(7, 'conversationsId', protoName: 'conversationsId')
    ..hasRequiredFields = false
  ;

  Chat._() : super();
  factory Chat() => create();
  factory Chat.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Chat.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Chat clone() => Chat()..mergeFromMessage(this);
  Chat copyWith(void Function(Chat) updates) => super.copyWith((message) => updates(message as Chat));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Chat create() => Chat._();
  Chat createEmptyInstance() => create();
  static $pb.PbList<Chat> createRepeated() => $pb.PbList<Chat>();
  @$core.pragma('dart2js:noInline')
  static Chat getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Chat>(create);
  static Chat _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get text => $_getSZ(1);
  @$pb.TagNumber(2)
  set text($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasText() => $_has(1);
  @$pb.TagNumber(2)
  void clearText() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get uid => $_getSZ(2);
  @$pb.TagNumber(3)
  set uid($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasUid() => $_has(2);
  @$pb.TagNumber(3)
  void clearUid() => clearField(3);

  @$pb.TagNumber(4)
  $2.Timestamp get createdAt => $_getN(3);
  @$pb.TagNumber(4)
  set createdAt($2.Timestamp v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasCreatedAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearCreatedAt() => clearField(4);
  @$pb.TagNumber(4)
  $2.Timestamp ensureCreatedAt() => $_ensure(3);

  @$pb.TagNumber(5)
  Chat_AttachmentType get attachmentType => $_getN(4);
  @$pb.TagNumber(5)
  set attachmentType(Chat_AttachmentType v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasAttachmentType() => $_has(4);
  @$pb.TagNumber(5)
  void clearAttachmentType() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get attachmentUrl => $_getSZ(5);
  @$pb.TagNumber(6)
  set attachmentUrl($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasAttachmentUrl() => $_has(5);
  @$pb.TagNumber(6)
  void clearAttachmentUrl() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get conversationsId => $_getSZ(6);
  @$pb.TagNumber(7)
  set conversationsId($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasConversationsId() => $_has(6);
  @$pb.TagNumber(7)
  void clearConversationsId() => clearField(7);
}

