import 'dart:convert';
import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rent/logic/models/models.dart';
import 'package:http/http.dart' as http;

abstract class UserService {
  Future<User> updateUser();
}

class ApiUserService extends UserService {
  final _storage = FlutterSecureStorage();

  @override
  Future<User> updateUser({User user}) async {
    final String sessionId = await _storage.read(key: 'sessionId');
    final String userId = await _storage.read(key: 'userId');

    if (sessionId != null && userId != null) {
      final Auth auth =
          Auth.session(session: Session(sessionId: sessionId, userId: userId));

      print(jsonEncode(
              <String, dynamic>{'auth': auth.toJson(), 'user': user.toJson()})
          .toString());

      final response = await http.patch('https://flexrent.multiflexxx.de/user',
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(
              <String, dynamic>{'auth': auth.toJson(), 'user': user.toJson()}));

      inspect(response);
      return null;
    } else {
      return null;
    }
  }
}
