import 'package:equatable/equatable.dart';
import 'package:flexrent/logic/models/models.dart';
import 'package:json_annotation/json_annotation.dart';
part 'chat.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Chat extends Equatable {
  final String chatId;
  final User chatPartner;
  final ChatMessage lastMessage;
  final bool unreadMessages;

  Chat({this.chatId, this.chatPartner, this.lastMessage, this.unreadMessages});

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);
  Map<String, dynamic> toJson() => _$ChatToJson(this);

  @override
  List<Object> get props => [
        chatId,
        chatPartner,
        lastMessage,
        unreadMessages,
      ];
}
