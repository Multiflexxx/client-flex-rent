import 'package:json_annotation/json_annotation.dart';
part 'authorization.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Auth {
  Login login;
  Session session;
  String token;

  Auth();

  Auth.login({this.login});
  Auth.session({this.session});
  Auth.idToken({this.token});

  factory Auth.fromJson(Map<String, dynamic> json) => _$AuthFromJson(json);
  Map<String, dynamic> toJson() => _$AuthToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Login {
  final String email;
  final String passwordHash;

  Login({this.email, this.passwordHash});
  factory Login.fromJson(Map<String, dynamic> json) => _$LoginFromJson(json);
  Map<String, dynamic> toJson() => _$LoginToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Session {
  final String userId;
  final String sessionId;

  Session({this.userId, this.sessionId});

  factory Session.fromJson(Map<String, dynamic> json) =>
      _$SessionFromJson(json);
  Map<String, dynamic> toJson() => _$SessionToJson(this);
}
