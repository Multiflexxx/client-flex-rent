import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../exceptions/exceptions.dart';
import '../models/models.dart';

abstract class AuthenticationService {
  Future<User> getCurrentUser();
  Future<User> signInWithEmailAndPassword(String email, String password);
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
    await Future.delayed(Duration(seconds: 1)); // simulate a network delay

    if (email.toLowerCase() != 'test@test.com' || password != 'test') {
      throw AuthenticationException(message: 'Wrong username or password');
    }

    await _storage.write(key: 'session', value: '123456789');
    return User(name: 'Test User', email: email);
  }

  Future<User> signInWithSession() async {
    // TODO: API Call
    final sessionLoginResponse = await _storage.read(key: 'session');
    if (sessionLoginResponse == '123456789') {
      return User(name: 'Test User', email: 'email');
    } else {
      return null;
    }
  }

  @override
  Future<void> signOut() async {
    await _storage.delete(key: 'session');
    return null;
  }
}
