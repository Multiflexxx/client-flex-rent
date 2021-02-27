import 'package:equatable/equatable.dart';
import 'package:flexrent/logic/models/models.dart';
import 'package:json_annotation/json_annotation.dart';
part 'chat_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ChatResponse extends Equatable {
  final List<Chat> chats;
  final int currentPage;
  final int maxPage;
  final int chatsPerPage;

  ChatResponse({this.chats, this.currentPage, this.maxPage, this.chatsPerPage});

  factory ChatResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ChatResponseToJson(this);

  @override
  List<Object> get props => [
        chats,
        currentPage,
        maxPage,
        chatsPerPage,
      ];
}
