part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class ChatOverviewTickerStarted extends ChatEvent {
  final int page;

  ChatOverviewTickerStarted({this.page});

  @override
  List<Object> get props => [page];
}

class _ChatOverviewTickerSuccess extends ChatEvent {
  final ChatResponse chatResponse;

  _ChatOverviewTickerSuccess({this.chatResponse});
}

class ChatOverviewTickerStopped extends ChatEvent {}

class ChatMessageFirstMessages extends ChatEvent {
  final String chatId;

  ChatMessageFirstMessages({
    this.chatId,
  });
}

class ChatMessageTickerStarted extends ChatEvent {
  final String chatId;
  final int lastMessageCount;

  ChatMessageTickerStarted({
    this.chatId,
    this.lastMessageCount,
  });
}

class _ChatMessageTickerSuccess extends ChatEvent {
  final ChatMessageResponse chatMessageResponse;

  _ChatMessageTickerSuccess({this.chatMessageResponse});
}

class ChatMessageTickerStopped extends ChatEvent {}
