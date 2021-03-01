import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
part 'chat_message.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ChatMessage extends Equatable {
  final String chatId;
  final String fromUserId;
  final String toUserId;
  final String messageContent;
  final int messageType;
  final int statusId;
  final DateTime createdAt;
  final String messageId;

  ChatMessage(
      {@required this.chatId,
      @required this.fromUserId,
      @required this.toUserId,
      @required this.messageContent,
      @required this.messageType,
      this.statusId,
      this.createdAt,
      this.messageId});

  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);
  Map<String, dynamic> toJson() => _$ChatMessageToJson(this);

  @override
  List<Object> get props => [
        chatId,
        fromUserId,
        toUserId,
        messageContent,
        messageType,
        statusId,
        createdAt,
        messageId,
      ];
}
