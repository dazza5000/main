///
//  Generated code. Do not modify.
//  source: chat.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

const Chat$json = const {
  '1': 'Chat',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'text', '3': 2, '4': 1, '5': 9, '10': 'text'},
    const {'1': 'uid', '3': 3, '4': 1, '5': 9, '10': 'uid'},
    const {'1': 'createdAt', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'attachmentType', '3': 5, '4': 1, '5': 14, '6': '.v1.Chat.AttachmentType', '10': 'attachmentType'},
    const {'1': 'attachmentUrl', '3': 6, '4': 1, '5': 9, '10': 'attachmentUrl'},
    const {'1': 'conversationsId', '3': 7, '4': 1, '5': 9, '10': 'conversationsId'},
  ],
  '4': const [Chat_AttachmentType$json],
};

const Chat_AttachmentType$json = const {
  '1': 'AttachmentType',
  '2': const [
    const {'1': 'NONE', '2': 0},
    const {'1': 'IMAGE', '2': 1},
    const {'1': 'FILE', '2': 2},
    const {'1': 'VIDEO', '2': 3},
    const {'1': 'GEOLOCATION', '2': 4},
    const {'1': 'CALENDER', '2': 5},
  ],
};

