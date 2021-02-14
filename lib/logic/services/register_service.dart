import 'dart:convert';
import 'dart:core';
import 'package:flexrent/logic/config/config.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flexrent/logic/exceptions/exceptions.dart';

import '../models/models.dart';

import 'package:http/http.dart' as http;

abstract class RegisterService {
  Future<User> registerUser({User user, String signInOption});
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

    final Map<String, dynamic> jsonBody = json.decode(response.body);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonUser = jsonBody['user'];
      final sessionId = jsonBody['session_id'];
      final User user = User.fromJson(jsonUser);
      await _storage.write(key: 'sessionId', value: sessionId);
      await _storage.write(key: 'userId', value: user.userId);
      return user;
    } else {
      throw RegisterException(message: jsonBody['message']);
    }
  }
}
