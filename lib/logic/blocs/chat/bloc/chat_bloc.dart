import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flexrent/logic/ticker/ticker.dart';
import 'package:flexrent/logic/models/models.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc(this._ticker) : super(ChatInitial());

  final Ticker _ticker;

  @override
  Stream<ChatState> mapEventToState(
    ChatEvent event,
  ) async* {
    if (event is ChatOverviewTickerStarted) {
      Stream<ChatResponse> stream = _ticker.getChatResponseAsStream();
      yield ChatOverviewSuccess(chatResponse: stream);
    }

    if (event is ChatMessageTickerStarted) {
      Stream<ChatMessageResponse> stream =
          _ticker.getChatMessageResponseAsStream(
              chatId: event.chatId, page: event.page);
      yield ChatMessageSuccess(chatMessageResponse: stream);
    }
  }
}
