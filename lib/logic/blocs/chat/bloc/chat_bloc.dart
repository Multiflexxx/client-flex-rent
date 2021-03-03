import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flexrent/logic/services/chat_service.dart';
import 'package:flexrent/logic/ticker/ticker.dart';
import 'package:flexrent/logic/models/models.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final Ticker _ticker;
  final ChatService _chatService;

  ChatBloc(this._ticker, ChatService chatService)
      : assert(chatService != null),
        _chatService = chatService,
        super(ChatInitial());

  StreamSubscription _subscription;
  StreamSubscription _messageSubscription;

  @override
  Stream<ChatState> mapEventToState(
    ChatEvent event,
  ) async* {
    if (event is ChatOverviewTickerStarted) {
      yield* _mapChatOverviewTickerStartedToState(event);
    }

    if (event is _ChatOverviewTickerSuccess) {
      yield* _map_ChatOverviewTickerSuccessToState(event);
    }

    if (event is ChatOverviewTickerStopped) {
      await _subscription?.cancel();
      yield ChatOverviewInitial();
    }

    if (event is ChatMessageFirstMessages) {
      yield* _mapChatMessageFirstMessagesToState(event);
    }

    if (event is ChatMessageTickerStarted) {
      yield* _mapChatMessageTickerStartedToState(event);
    }

    if (event is _ChatMessageTickerSuccess) {
      yield* _map_ChatMessageTickerSuccessToState(event);
    }
  }

  Stream<ChatState> _mapChatOverviewTickerStartedToState(
      ChatOverviewTickerStarted event) async* {
    await _subscription?.cancel();

    _subscription = _ticker.getChatResponseAsStream().listen((chatResponse) =>
        add(_ChatOverviewTickerSuccess(chatResponse: chatResponse)));
  }

  Stream<ChatState> _map_ChatOverviewTickerSuccessToState(
      _ChatOverviewTickerSuccess event) async* {
    yield ChatOverviewSuccess(chatResponse: event.chatResponse);
  }

  // stop missing

  Stream<ChatState> _mapChatMessageFirstMessagesToState(
      ChatMessageFirstMessages event) async* {
    final ChatMessageResponse chatMessageResponse =
        await _chatService.getAllMessagesByChatId(
            chatId: event.chatId, lastMessageCount: -1, newer: false);
    yield ChatMessageInitalSuccess(chatMessageResponse: chatMessageResponse);
  }

  Stream<ChatState> _mapChatMessageTickerStartedToState(
      ChatMessageTickerStarted event) async* {
    _messageSubscription?.cancel();

    _messageSubscription = _ticker
        .getNewChatMessageResponseAsStream(
          chatId: event.chatId,
          lastMessageCount: event.lastMessageCount,
        )
        .listen((chatMessageResponse) => add(_ChatMessageTickerSuccess(
              chatMessageResponse: chatMessageResponse,
            )));
  }

  Stream<ChatState> _map_ChatMessageTickerSuccessToState(
      _ChatMessageTickerSuccess event) async* {
    final ChatMessageResponse chatMessageResponse = event.chatMessageResponse;

    if (chatMessageResponse.messages.isNotEmpty) {
      yield ChatMessageSuccess(
        chatMessageResponse: chatMessageResponse,
      );
    }
    yield ChatMessageNewInitial();
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
