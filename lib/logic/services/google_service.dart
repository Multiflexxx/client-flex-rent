import 'dart:developer';

import 'package:flexrent/logic/models/models.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

abstract class GoogleService {
  Future<User> signIn();
}

class ApiGoogleService extends GoogleService {
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'profile',
    ],
  );

  @override
  Future<User> signIn() async {
    String _idToken;
    try {
      GoogleSignInAccount account = await _googleSignIn.signIn();
      GoogleSignInAuthentication authentication = await account.authentication;
      _idToken = authentication.idToken;
      Map<String, dynamic> _decodedToken = JwtDecoder.decode(_idToken);

      User googleUser = User(
        firstName: _decodedToken['given_name'],
        lastName: _decodedToken['family_name'],
        email: _decodedToken['email'],
      );
      return googleUser;
    } catch (error) {
      print(error);
      return null;
    }
  }
}
