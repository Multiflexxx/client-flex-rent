part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

// Overview
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

// First message
class ChatMessageFirstMessages extends ChatEvent {
  final String chatId;

  ChatMessageFirstMessages({
    this.chatId,
  });
}

// New message
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

// Old message
class ChatMessageOldMessages extends ChatEvent {
  final String chatId;
  final int firstMessageCount;

  ChatMessageOldMessages({this.chatId, this.firstMessageCount});
}

class ChatTickerStopped extends ChatEvent {}
