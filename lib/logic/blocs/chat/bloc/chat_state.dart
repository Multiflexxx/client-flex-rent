part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  ChatState({this.chatResponse, this.chatMessageResponse});

  final Stream<ChatResponse> chatResponse;
  final Stream<ChatMessageResponse> chatMessageResponse;

  @override
  List<Object> get props => [chatResponse, chatMessageResponse];
}

class ChatInitial extends ChatState {}

class ChatOverviewSuccess extends ChatState {
  ChatOverviewSuccess({chatResponse}) : super(chatResponse: chatResponse);
}

class ChatMessageSuccess extends ChatState {
  ChatMessageSuccess({chatMessageResponse})
      : super(chatMessageResponse: chatMessageResponse);
}
