import 'dart:convert';
import 'dart:developer';

import 'package:flexrent/logic/config/config.dart';
import 'package:flexrent/logic/exceptions/exceptions.dart';
import 'package:flexrent/logic/models/chat/chat/chat_response/chat_response.dart';
import 'package:flexrent/logic/models/chat/chat_message/chat_message_response/chat_message_response.dart';
import 'package:flexrent/logic/models/models.dart';
import 'package:flexrent/logic/services/services.dart';
import 'package:http/http.dart' as http;

abstract class ChatService {
  Future<ChatResponse> getAllChatsByLoggedInUser({int page});
  Future<ChatMessageResponse> getAllMessagesByChatId(
      {String chatId, int lastMessageCount, bool newer});
  Future<ChatMessage> sendMessage({ChatMessage chatMessage});
}

class ApiChatService extends ChatService {
  @override
  Future<ChatResponse> getAllChatsByLoggedInUser({int page}) async {
    Session session = await HelperService.getSession();

    final response = await http.post(
      '${CONFIG.url}/chat/all/${session.userId}',
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(
        <String, dynamic>{
          'session': session.toJson(),
          'query': {
            'page': page ?? 1,
          }
        },
      ),
    );

    if (response.statusCode == 201) {
      final dynamic jsonBody = json.decode(response.body);
      final ChatResponse chatResponse = ChatResponse.fromJson(jsonBody);
      if (chatResponse.chats.isNotEmpty) {
        return chatResponse;
      }
      return Future.error(
        ChatException(message: 'Du hast keine Chats.'),
      );
    } else if (response.statusCode == 400) {
      return Future.error(
        ChatException(message: 'Das waren alle deine Chats'),
      );
    } else {
      return Future.error(
        ChatException(message: 'Hier ist etwas schief gelaufen.'),
      );
    }
  }

  @override
  Future<ChatMessageResponse> getAllMessagesByChatId(
      {String chatId, int lastMessageCount, bool newer}) async {
    Session session = await HelperService.getSession();

    final response = await http.post(
      '${CONFIG.url}/chat/$chatId',
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(
        <String, dynamic>{
          'session': session.toJson(),
          'query': {
            'message_count': lastMessageCount,
            'newer': newer ?? false,
          }
        },
      ),
    );

    if (response.statusCode == 201) {
      final jsonBody = json.decode(response.body);
      ChatMessageResponse chatMessageResponse =
          ChatMessageResponse.fromJson(jsonBody);
      return chatMessageResponse;
    } else {
      return Future.error(
        ChatException(message: 'Hier ist etwas schief gelaufen.'),
      );
    }
  }

  @override
  Future<ChatMessage> sendMessage({ChatMessage chatMessage}) async {
    Session session = await HelperService.getSession();

    final response = await http.put(
      '${CONFIG.url}/chat',
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(
        <String, dynamic>{
          'session': session.toJson(),
          'message': chatMessage.toJson(),
        },
      ),
    );

    if (response.statusCode == 200) {
      final dynamic jsonBody = json.decode(response.body);
      ChatMessage _chatMessage = ChatMessage.fromJson(jsonBody);
      return _chatMessage;
    } else {
      return Future.error(
        ChatException(message: 'Hier ist etwas schief gelaufen.'),
      );
    }
  }
}
