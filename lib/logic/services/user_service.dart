import 'dart:convert';
import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rent/logic/exceptions/exceptions.dart';
import 'package:rent/logic/models/models.dart';
import 'package:http/http.dart' as http;

abstract class UserService {
  Future<User> updateUser({User user, Password password});
}

class ApiUserService extends UserService {
  final _storage = FlutterSecureStorage();

  @override
  Future<User> updateUser({User user, Password password}) async {
    final String sessionId = await _storage.read(key: 'sessionId');
    final String userId = await _storage.read(key: 'userId');

    if (sessionId != null && userId != null) {
      final Auth auth =
          Auth.session(session: Session(sessionId: sessionId, userId: userId));

      Map<String, dynamic> _body = {
        'auth': auth.toJson(),
        'user': user.toJson()
      };

      if (password != null) {
        _body.putIfAbsent('password', () => password.toJson());
      }

      final response = await http.patch(
        'https://flexrent.multiflexxx.de/user',
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(_body),
      );

      if (response.statusCode == 200) {
        dynamic jsonBody = jsonDecode(response.body);
        final User user = User.fromJson(jsonBody['user']);
        final String sessionId = jsonBody['session_id'];
        await _storage.write(key: 'sessionId', value: sessionId);
        inspect(user);
        inspect(sessionId);
        return user;
      } else if (response.statusCode == 401) {
        inspect(response);
        throw AuthenticationException(
            message: 'Dein altes Passwort war falsch');
      }
      return null;
    } else {
      return null;
    }
  }
}
