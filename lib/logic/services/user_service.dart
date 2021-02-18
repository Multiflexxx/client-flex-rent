import 'dart:convert';
import 'dart:developer';

import 'package:flexrent/logic/config/config.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flexrent/logic/exceptions/exceptions.dart';
import 'package:flexrent/logic/models/models.dart';
import 'package:http/http.dart' as http;

abstract class UserService {
  Future<User> updateUser({User user, Password password});
  Future<User> updateProfileImage({String imagePath});
  Future<List<UserRating>> getUserRatingById({User user});
  Future<UserRating> createUserRating(
      {User user, String ratingType, int rating, String headline, String text});
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
        '${CONFIG.url}/user',
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

    var uri = Uri.parse('${CONFIG.url}/user/images');
    var request = http.MultipartRequest('POST', uri)
      ..fields['session_id'] = sessionId
      ..fields['user_id'] = userId
      ..files.add(multipartFile);

    http.Response response =
        await http.Response.fromStream(await request.send());

    if (response.statusCode == 201) {
      final dynamic jsonBody = json.decode(response.body);
      final User user = User.fromJson(jsonBody);
      return user;
    } else {
      return null;
    }
  }

  @override
  Future<List<UserRating>> getUserRatingById(
      {User user, bool lessorRating}) async {
    String ratingType = 'lessee';
    String userType = 'Mieter';
    if (lessorRating) {
      ratingType = 'lessor';
      userType = 'Vermieter';
    }
    String url =
        '${CONFIG.url}/user/rating/${user.userId}?rating_type=$ratingType';

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonBody = json.decode(response.body);
      if (jsonBody.isNotEmpty) {
        final List<UserRating> userRatingList =
            (jsonBody).map((i) => UserRating.fromJson(i)).toList();
        inspect(userRatingList);
        return userRatingList;
      } else {
        // TODO: Change Exceptions
        throw RatingException(
            message:
                'Der Flexer ${user.firstName} ${user.lastName} hat noch keine Bewertung als $userType.');
      }
    } else {
      throw RatingException(
          message:
              'Hier ist etwas schief gelaufen. Versuche es später nocheinmal.');
    }
  }

  @override
  Future<UserRating> createUserRating(
      {User user,
      String ratingType,
      int rating,
      String headline,
      String text}) async {
    final String sessionId = await _storage.read(key: 'sessionId');
    final String userId = await _storage.read(key: 'userId');

    final Auth auth =
        Auth.session(session: Session(sessionId: sessionId, userId: userId));

    UserRatingRequest _userRatingRequest = UserRatingRequest(
      userId: user.userId,
      ratingType: ratingType,
      rating: rating,
      headline: headline ?? null,
      text: text ?? null,
    );

    Map<String, dynamic> _body = {
      'auth': auth.toJson(),
      'rating': _userRatingRequest.toJson()
    };

    inspect(_body);

    final response = await http.post(
      '${CONFIG.url}/user/rating',
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(_body),
    );

    if (response.statusCode == 201) {
      return null;
    } else {
      inspect(response);
      // TODO: Change Exceptions
      throw RatingException(
          message:
              'Deine Bewertung konnte nicht erstellt werden. Versuche es später noch einmal.');
    }
  }
}
