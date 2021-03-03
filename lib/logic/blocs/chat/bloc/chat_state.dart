part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  ChatState({
    this.chatResponse,
    this.chatMessageResponse,
  });

  final ChatResponse chatResponse;
  final ChatMessageResponse chatMessageResponse;

  @override
  List<Object> get props => [chatResponse, chatMessageResponse];
}

class ChatInitial extends ChatState {}

class ChatOverviewInitial extends ChatState {}

class ChatOverviewSuccess extends ChatState {
  ChatOverviewSuccess({chatResponse}) : super(chatResponse: chatResponse);
}

class ChatMessageFirstSuccess extends ChatState {
  ChatMessageFirstSuccess({chatMessageResponse})
      : super(
          chatMessageResponse: chatMessageResponse,
        );
}

class ChatMessageSuccess extends ChatState {
  ChatMessageSuccess({chatMessageResponse})
      : super(
          chatMessageResponse: chatMessageResponse,
        );
}

class ChatMessageNewInitial extends ChatState {}

class ChatMessageOldSuccess extends ChatState {
  ChatMessageOldSuccess({chatMessageResponse})
      : super(
          chatMessageResponse: chatMessageResponse,
        );
}

class ChatMessageOldInitial extends ChatState {}
