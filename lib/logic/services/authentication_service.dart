import 'dart:convert';
import 'dart:developer';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flexrent/logic/exceptions/exceptions.dart';
import '../models/models.dart';

import 'package:http/http.dart' as http;

abstract class AuthenticationService {
  Future<User> getCurrentUser();
  Future<User> signInWithEmailAndPassword(String email, String password);
  Future<User> signInWithGoogle(String idToken);
  Future<void> signOut();
}

class ApiAuthenticationService extends AuthenticationService {
  final _storage = FlutterSecureStorage();

  @override
  Future<User> getCurrentUser() async {
    return signInWithSession();
  }

  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    final Auth auth =
        Auth.login(login: Login(email: email, passwordHash: password));

    final response = await http.post('https://flexrent.multiflexxx.de/user',
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(<String, dynamic>{'auth': auth.toJson()}));

    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> jsonBody = json.decode(response.body);
      final Map<String, dynamic> jsonUser = jsonBody['user'];
      final sessionId = jsonBody['session_id'];

      final User user = User.fromJson(jsonUser);
      await _storage.write(key: 'sessionId', value: sessionId);
      await _storage.write(key: 'userId', value: user.userId);
      return user;
    } else {
      throw AuthenticationException(message: 'Wrong username or password');
    }
  }

  Future<User> signInWithSession() async {
    final String sessionId = await _storage.read(key: 'sessionId');
    final String userId = await _storage.read(key: 'userId');

    if (sessionId != null && userId != null) {
      final Auth auth =
          Auth.session(session: Session(sessionId: sessionId, userId: userId));

      final response = await http.post('https://flexrent.multiflexxx.de/user',
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(<String, dynamic>{'auth': auth.toJson()}));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonBody = json.decode(response.body);
        final Map<String, dynamic> jsonUser = jsonBody['user'];
        final User user = User.fromJson(jsonUser);
        return user;
      } else {
        // sessionid outdated
        return null;
      }
    } else {
      // no userid in storage
      return null;
    }
  }

  @override
  Future<User> signInWithGoogle(String token) async {
    final Auth auth = Auth.idToken(token: token);
    final response = await http.post(
      'https://flexrent.multiflexxx.de/user/google',
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(
        <String, dynamic>{'auth': auth.toJson()},
      ),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> jsonBody = json.decode(response.body);
      final Map<String, dynamic> jsonUser = jsonBody['user'];
      final sessionId = jsonBody['session_id'];

      final User user = User.fromJson(jsonUser);
      await _storage.write(key: 'sessionId', value: sessionId);
      await _storage.write(key: 'userId', value: user.userId);
      return user;
    } else {
      return null;
    }
  }

  @override
  Future<void> signOut() async {
    await _storage.delete(key: 'sessionId');
    await _storage.delete(key: 'userId');
    return null;
  }
}
