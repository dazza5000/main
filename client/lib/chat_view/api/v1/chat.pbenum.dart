///
//  Generated code. Do not modify.
//  source: chat.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

// ignore_for_file: UNDEFINED_SHOWN_NAME,UNUSED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class Chat_AttachmentType extends $pb.ProtobufEnum {
  static const Chat_AttachmentType NONE = Chat_AttachmentType._(0, 'NONE');
  static const Chat_AttachmentType IMAGE = Chat_AttachmentType._(1, 'IMAGE');
  static const Chat_AttachmentType FILE = Chat_AttachmentType._(2, 'FILE');
  static const Chat_AttachmentType VIDEO = Chat_AttachmentType._(3, 'VIDEO');
  static const Chat_AttachmentType GEOLOCATION = Chat_AttachmentType._(4, 'GEOLOCATION');
  static const Chat_AttachmentType CALENDER = Chat_AttachmentType._(5, 'CALENDER');

  static const $core.List<Chat_AttachmentType> values = <Chat_AttachmentType> [
    NONE,
    IMAGE,
    FILE,
    VIDEO,
    GEOLOCATION,
    CALENDER,
  ];

  static final $core.Map<$core.int, Chat_AttachmentType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Chat_AttachmentType valueOf($core.int value) => _byValue[value];

  const Chat_AttachmentType._($core.int v, $core.String n) : super(v, n);
}

