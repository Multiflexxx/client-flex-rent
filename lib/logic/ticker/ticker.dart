import 'dart:async';

import 'package:flexrent/logic/models/models.dart';
import 'package:flexrent/logic/services/services.dart';
import 'package:rxdart/rxdart.dart';

class Ticker {
  Stream<NewRequestNumbers> getNumberOfNewRequestesAsStream() {
    return MergeStream(
      [
        Stream.fromFuture(ApiOfferService().getNumberOfNewRequests()),
        Stream.periodic(
          const Duration(seconds: 5),
          (_) => ApiOfferService().getNumberOfNewRequests(),
        ).asyncMap((event) async => await event),
      ],
    );
  }

  Stream<ChatResponse> getChatResponseAsStream({int page}) {
    return MergeStream(
      [
        Stream.fromFuture(
            ApiChatService().getAllChatsByLoggedInUser(page: page)),
        Stream.periodic(const Duration(seconds: 20),
                (_) => ApiChatService().getAllChatsByLoggedInUser(page: page))
            .asyncMap((event) async => await event),
      ],
    );
  }

  Stream<ChatMessageResponse> getChatMessageResponseAsStream(
      {String chatId, int page}) {
    return MergeStream(
      [
        Stream.fromFuture(ApiChatService()
            .getAllMessagesByChatId(chatId: chatId, page: page)),
        Stream.periodic(
            const Duration(milliseconds: 500),
            (_) => ApiChatService().getAllMessagesByChatId(
                chatId: chatId,
                page: page)).asyncMap((event) async => await event),
      ],
    );
  }
}
