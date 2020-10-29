import 'dart:convert';

import 'package:flexrent/logic/models/models.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

import 'package:http/http.dart' as http;

abstract class FacebookService {
  Future<User> signUp();
  Future<String> signIn();
  void signOut();
}

class ApiFacebookService extends FacebookService {
  final _facebookLogin = FacebookLogin();

  @override
  Future<User> signUp() async {
    final result = await _facebookLogin.logIn(['email', 'phone']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        final graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=$token');
        final _profile = jsonDecode(graphResponse.body);

        User facebookUser = User(
          firstName: _profile['first_name'],
          lastName: _profile['last_name'],
        );
        await _facebookLogin.logOut();
        return facebookUser;
        break;
      case FacebookLoginStatus.cancelledByUser:
        print('Login cancelled by the user.');
        return null;
        break;
      case FacebookLoginStatus.error:
        print('Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${result.errorMessage}');
        return null;
        break;
    }
  }

  @override
  Future<String> signIn() async {
    final result = await _facebookLogin.logIn(['email']);
    final token = result.accessToken.token;
    return token;
  }

  @override
  void signOut() async {
    await _facebookLogin.logOut();
  }
}
