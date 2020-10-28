import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flexrent/logic/exceptions/exceptions.dart';
import 'package:flexrent/logic/models/models.dart';
import 'package:http/http.dart' as http;

abstract class UserService {
  Future<User> updateUser({User user, Password password});
  Future<User> updateProfileImage({String imagePath});
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
        return user;
      } else if (response.statusCode == 401) {
        throw AuthenticationException(
            message: 'Dein altes Passwort war falsch');
      }
      throw AuthenticationException(
          message:
              'Hier ist ein Fehler unterlaufen. Probiere es später noche einmal');
    } else {
      throw AuthenticationException(
          message: 'Deine Session ist abgelaufen. Melde dich neu an.');
    }
  }

  @override
  Future<User> updateProfileImage({String imagePath}) async {
    final String sessionId = await _storage.read(key: 'sessionId');
    final String userId = await _storage.read(key: 'userId');

    var multipartFile = await http.MultipartFile.fromPath('image', imagePath,
        filename: imagePath);

    var uri = Uri.parse('https://flexrent.multiflexxx.de/user/images');
    var request = http.MultipartRequest('POST', uri)
      ..fields['session_id'] = sessionId
      ..fields['user_id'] = userId
      ..files.add(multipartFile);

    http.Response response =
        await http.Response.fromStream(await request.send());

    if (response.statusCode == 201) {
      final dynamic jsonBody = json.decode(response.body);
      // jsonBody['profile_picture'] = jsonBody['profile_picture'] +
      //     '?refresh=' +
      //     DateTime.now().millisecondsSinceEpoch.toString();
      final User user = User.fromJson(jsonBody);
      return user;
    } else {
      return null;
    }
  }
}
