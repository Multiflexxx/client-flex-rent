import 'dart:convert';
import 'dart:core';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rent/logic/exceptions/exceptions.dart';

import '../models/models.dart';

import 'package:http/http.dart' as http;

abstract class RegisterService {
  Future<User> registerUser(User user);
}

class ApiRegisterService extends RegisterService {
  String url = 'https://flexrent.multiflexxx.de/user';
  final _storage = FlutterSecureStorage();

  @override
  Future<User> registerUser(User user) async {
    final response = await http.put(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(
        <String, dynamic>{'user': user.toJson()},
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
