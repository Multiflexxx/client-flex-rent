// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMessageResponse _$ChatMessageResponseFromJson(Map<String, dynamic> json) {
  return ChatMessageResponse(
    messages: (json['messages'] as List)
        ?.map((e) =>
            e == null ? null : ChatMessage.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    currentPage: json['current_page'] as int,
    maxPage: json['max_page'] as int,
    messagesPerPage: json['messages_per_page'] as int,
    chatPartner: json['chat_partner'] == null
        ? null
        : User.fromJson(json['chat_partner'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ChatMessageResponseToJson(ChatMessageResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('messages', instance.messages);
  writeNotNull('current_page', instance.currentPage);
  writeNotNull('max_page', instance.maxPage);
  writeNotNull('messages_per_page', instance.messagesPerPage);
  writeNotNull('chat_partner', instance.chatPartner);
  return val;
}
