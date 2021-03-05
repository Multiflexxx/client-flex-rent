import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flexrent/logic/exceptions/exceptions.dart';
import '../models/models.dart';
import '../config/config.dart';

import 'package:http/http.dart' as http;

abstract class AuthenticationService {
  Future<User> getCurrentUser();
  Future<User> signInWithEmailAndPassword(String email, String password);
  Future<User> signInWithGoogle(String token);
  Future<User> signInWithFacebook(String token);
  Future<void> requestPasswordReset({String email});
  Future<String> getPasswordResetToken({String email, String code});
  Future<User> resetPassword({String email, String token, String password});
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
    final Auth auth = Auth.login(
      login: Login(email: email, passwordHash: password),
    );

    final response = await http.post('${CONFIG.url}/user',
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

      final response = await http.post('${CONFIG.url}/user',
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(<String, dynamic>{'auth': auth.toJson()}));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonBody = json.decode(response.body);
        final Map<String, dynamic> jsonUser = jsonBody['user'];
        final User user = User.fromJson(jsonUser);
        return user;
      } else {
        throw AuthenticationException(message: 'Session abgelaufen');
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
      '${CONFIG.url}/user/google',
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
  Future<User> signInWithFacebook(String token) async {
    final Auth auth = Auth.idToken(token: token);
    final response = await http.post(
      '${CONFIG.url}/user/facebook',
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
  Future<void> requestPasswordReset({String email}) async {
    final response = await http.post(
      '${CONFIG.url}/user/password-reset/request',
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(
        <String, dynamic>{'email': '$email'},
      ),
    );

    if (response.statusCode != 201) {
      throw AuthenticationException(
          message:
              'Es konnte keine Email versendet werden. Probiere es später noch einmal.');
    }
  }

  @override
  Future<String> getPasswordResetToken({String email, String code}) async {
    final response = await http.post(
      '${CONFIG.url}/user/password-reset/verify-code',
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(
        <String, dynamic>{
          'email': '$email',
          'reset_code': '$code',
        },
      ),
    );

    if (response.statusCode == 201) {
      final dynamic jsonBody = json.decode(response.body);
      return jsonBody['token'];
    } else if (response.statusCode == 404) {
      throw AuthenticationException(message: 'Ungültiger Code.');
    } else if (response.statusCode == 401) {
      throw AuthenticationException(message: 'Ungültiger Code.');
    } else {
      throw AuthenticationException(message: 'Probiere es später noch einmal.');
    }
  }

  @override
  Future<User> resetPassword(
      {String email, String token, String password}) async {
    final response = await http.post(
      '${CONFIG.url}/user/password-reset/reset',
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(
        <String, dynamic>{
          'email': '$email',
          'token': '$token',
          'new_password': '$password',
        },
      ),
    );

    if (response.statusCode == 201) {
      final Map<String, dynamic> jsonBody = json.decode(response.body);
      final Map<String, dynamic> jsonUser = jsonBody['user'];
      final sessionId = jsonBody['session_id'];

      final User user = User.fromJson(jsonUser);
      await _storage.write(key: 'sessionId', value: sessionId);
      await _storage.write(key: 'userId', value: user.userId);
      return user;
    } else {
      throw AuthenticationException(
          message:
              'Hier ist etwas schief gelaufen, probiere es später nocheinmal.');
    }
  }

  @override
  Future<void> signOut() async {
    await _storage.delete(key: 'sessionId');
    await _storage.delete(key: 'userId');
    return null;
  }
}
