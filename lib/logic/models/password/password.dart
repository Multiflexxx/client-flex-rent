import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'password.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Password extends Equatable {
  final String oldPasswordHash;
  final String newPasswordHash;

  Password({
    this.oldPasswordHash,
    this.newPasswordHash,
  });

  factory Password.fromJson(Map<String, dynamic> json) =>
      _$PasswordFromJson(json);
  Map<String, dynamic> toJson() => _$PasswordToJson(this);

  @override
  List<Object> get props => [oldPasswordHash, newPasswordHash];
}
