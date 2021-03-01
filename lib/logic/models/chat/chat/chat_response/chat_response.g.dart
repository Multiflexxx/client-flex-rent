// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatResponse _$ChatResponseFromJson(Map<String, dynamic> json) {
  return ChatResponse(
    chats: (json['chats'] as List)
        ?.map(
            (e) => e == null ? null : Chat.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    currentPage: json['current_page'] as int,
    maxPage: json['max_page'] as int,
    chatsPerPage: json['chats_per_page'] as int,
  );
}

Map<String, dynamic> _$ChatResponseToJson(ChatResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('chats', instance.chats);
  writeNotNull('current_page', instance.currentPage);
  writeNotNull('max_page', instance.maxPage);
  writeNotNull('chats_per_page', instance.chatsPerPage);
  return val;
}
