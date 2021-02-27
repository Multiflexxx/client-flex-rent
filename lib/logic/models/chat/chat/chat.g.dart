// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chat _$ChatFromJson(Map<String, dynamic> json) {
  return Chat(
    chatId: json['chat_id'] as String,
    chatParner: json['chat_parner'] == null
        ? null
        : User.fromJson(json['chat_parner'] as Map<String, dynamic>),
    lastMessage: json['last_message'] == null
        ? null
        : ChatMessage.fromJson(json['last_message'] as Map<String, dynamic>),
    unreadMessages: json['unread_messages'] as bool,
  );
}

Map<String, dynamic> _$ChatToJson(Chat instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('chat_id', instance.chatId);
  writeNotNull('chat_parner', instance.chatParner);
  writeNotNull('last_message', instance.lastMessage);
  writeNotNull('unread_messages', instance.unreadMessages);
  return val;
}
