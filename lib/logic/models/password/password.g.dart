// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Password _$PasswordFromJson(Map<String, dynamic> json) {
  return Password(
    oldPasswordHash: json['old_password_hash'] as String,
    newPasswordHash: json['new_password_hash'] as String,
  );
}

Map<String, dynamic> _$PasswordToJson(Password instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('old_password_hash', instance.oldPasswordHash);
  writeNotNull('new_password_hash', instance.newPasswordHash);
  return val;
}
