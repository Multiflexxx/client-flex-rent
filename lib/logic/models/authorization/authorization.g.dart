// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authorization.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Auth _$AuthFromJson(Map<String, dynamic> json) {
  return Auth()
    ..login = json['login'] == null
        ? null
        : Login.fromJson(json['login'] as Map<String, dynamic>)
    ..session = json['session'] == null
        ? null
        : Session.fromJson(json['session'] as Map<String, dynamic>)
    ..token = json['token'] as String;
}

Map<String, dynamic> _$AuthToJson(Auth instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('login', instance.login);
  writeNotNull('session', instance.session);
  writeNotNull('token', instance.token);
  return val;
}

Login _$LoginFromJson(Map<String, dynamic> json) {
  return Login(
    email: json['email'] as String,
    passwordHash: json['password_hash'] as String,
  );
}

Map<String, dynamic> _$LoginToJson(Login instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('email', instance.email);
  writeNotNull('password_hash', instance.passwordHash);
  return val;
}

Session _$SessionFromJson(Map<String, dynamic> json) {
  return Session(
    userId: json['user_id'] as String,
    sessionId: json['session_id'] as String,
  );
}

Map<String, dynamic> _$SessionToJson(Session instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('user_id', instance.userId);
  writeNotNull('session_id', instance.sessionId);
  return val;
}
