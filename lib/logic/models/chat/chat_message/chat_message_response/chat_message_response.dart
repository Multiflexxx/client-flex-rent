import 'package:equatable/equatable.dart';
import 'package:flexrent/logic/models/models.dart';
import 'package:json_annotation/json_annotation.dart';
part 'chat_message_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ChatMessageResponse extends Equatable {
  final List<ChatMessage> messages;
  final int currentPage;
  final int maxPage;
  final int messagesPerPage;
  final User chatPartner;

  ChatMessageResponse({
    this.messages,
    this.currentPage,
    this.maxPage,
    this.messagesPerPage,
    this.chatPartner,
  });

  factory ChatMessageResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ChatMessageResponseToJson(this);

  @override
  List<Object> get props => [
        messages,
        currentPage,
        maxPage,
        messagesPerPage,
        chatPartner,
      ];
}
