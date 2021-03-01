// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) {
  return ChatMessage(
    chatId: json['chat_id'] as String,
    fromUserId: json['from_user_id'] as String,
    toUserId: json['to_user_id'] as String,
    messageContent: json['message_content'] as String,
    messageType: json['message_type'] as int,
    statusId: json['status_id'] as int,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    messageId: json['message_id'] as String,
  );
}

Map<String, dynamic> _$ChatMessageToJson(ChatMessage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('chat_id', instance.chatId);
  writeNotNull('from_user_id', instance.fromUserId);
  writeNotNull('to_user_id', instance.toUserId);
  writeNotNull('message_content', instance.messageContent);
  writeNotNull('message_type', instance.messageType);
  writeNotNull('status_id', instance.statusId);
  writeNotNull('created_at', instance.createdAt?.toIso8601String());
  writeNotNull('message_id', instance.messageId);
  return val;
}
