import 'dart:convert';
import 'dart:core';
import 'dart:developer';
import 'package:flexrent/logic/config/config.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flexrent/logic/exceptions/exceptions.dart';

import '../models/models.dart';

import 'package:http/http.dart' as http;

abstract class RegisterService {
  Future<User> registerUser({User user, String signInOption});
  Future<User> validatePhoneAndRegisterUser({String userId, String token});
}

class ApiRegisterService extends RegisterService {
  String url = '${CONFIG.url}/user';
  final _storage = FlutterSecureStorage();

  @override
  Future<User> registerUser({User user, String signInOption}) async {
    final response = await http.put(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(
        <String, dynamic>{
          'user': user.toJson(),
          'sign_in_method': signInOption,
        },
      ),
    );

    inspect(response);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonBody = json.decode(response.body);
      final User user = User.fromJson(jsonBody);

      return user;
    } else {
      throw RegisterException(
          message: 'Dein Account konnte nicht festgelegt werden.');
    }
  }

  @override
  Future<User> validatePhoneAndRegisterUser(
      {String userId, String token}) async {
    final response = await http.post(
      '$url/validate-phone',
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(
        <String, dynamic>{
          'user_id': userId,
          'token': token,
        },
      ),
    );

    inspect(response);

    // 404 invallid token / userId

    final Map<String, dynamic> jsonBody = json.decode(response.body);

    if (response.statusCode == 201) {
      final Map<String, dynamic> jsonUser = jsonBody['user'];
      final sessionId = jsonBody['session_id'];
      final User user = User.fromJson(jsonUser);
      await _storage.write(key: 'sessionId', value: sessionId);
      await _storage.write(key: 'userId', value: user.userId);
      return user;
    } else if (response.statusCode == 404) {
      throw RegisterException(message: 'Der Code ist falsch.');
    } else {
      inspect(response);
      throw RegisterException(message: 'Hier ist etwas schief gelaufen');
    }
  }
}
