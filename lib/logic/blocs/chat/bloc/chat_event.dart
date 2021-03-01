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

class ChatMessageTickerStarted extends ChatEvent {
  final String chatId;
  final int page;

  ChatMessageTickerStarted({this.chatId, this.page});
}
