import 'dart:convert';
import 'dart:core';
import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:rent/logic/services/authentication_service.dart';

import '../models/models.dart';

import 'package:http/http.dart' as http;

abstract class RegisterService {
  registerUser(User user);
}

class ApiRegisterService extends RegisterService {
  String url = 'https://flexrent.multiflexxx.de/user';
  final _storage = FlutterSecureStorage();
  final f = new DateFormat('yyyy-MM-dd');

  @override
  registerUser(User user) async {
    User logUser = User(
      userId: '',
      firstName: 'Test',
      lastName: 'Test',
      email: 'test6@test.com',
      phoneNumber: '01234567895',
      passwordHash: 'test',
      verified: 0,
      postCode: '68165',
      city: 'Mannheim',
      street: 'Wasserturm',
      houseNumber: '4',
      lesseeRating: 0,
      numberOfLesseeRatings: 0,
      lessorRating: 0,
      numberOfLessorRatings: 0,
      dateOfBirth: f.format(DateTime.now().subtract(Duration(days: 100))),
    );

    final response = await http.put(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(
        <String, dynamic>{'user': logUser.toJson()},
      ),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonBody = json.decode(response.body);
      final Map<String, dynamic> jsonUser = jsonBody['user'];
      final sessionId = jsonBody['session_id'];
      final User user = User.fromJson(jsonUser);
      await _storage.write(key: 'sessionId', value: sessionId);
      await _storage.write(key: 'userId', value: user.userId);
      final res = ApiAuthenticationService().getCurrentUser();
      inspect(res);
    } else {
      inspect(response);
    }
  }
}
