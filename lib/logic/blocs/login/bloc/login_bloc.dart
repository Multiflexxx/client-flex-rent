import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../exceptions/exceptions.dart';
import '../../../services/services.dart';
import '../../authentication/authentication.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationBloc _authenticationBloc;
  final AuthenticationService _authenticationService;
  final GoogleService _googleService;
  final FacebookService _facebookService;

  LoginBloc(
      AuthenticationBloc authenticationBloc,
      AuthenticationService authenticationService,
      GoogleService googleService,
      FacebookService facebookService)
      : assert(authenticationBloc != null),
        assert(authenticationService != null),
        assert(googleService != null),
        assert(facebookService != null),
        _authenticationBloc = authenticationBloc,
        _authenticationService = authenticationService,
        _googleService = googleService,
        _facebookService = facebookService,
        super(null);

  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginWithEmailButtonPressed) {
      yield* _mapLoginWithEmailToState(event);
    }
    if (event is LoginWithGoogleButtonPressed) {
      yield* _mapLoginWithGoogleToState(event);
    }
    if (event is LoginWithFacebookButtonPressed) {
      yield* _mapLoginWithFacebookToState(event);
    }
  }

  Stream<LoginState> _mapLoginWithEmailToState(
      LoginWithEmailButtonPressed event) async* {
    yield LoginLoading();
    try {
      final user = await _authenticationService.signInWithEmailAndPassword(
          event.email, event.password);
      if (user != null) {
        _authenticationBloc.add(UserLoggedIn(user: user));
        yield LoginSuccess();
        yield LoginInitial();
      } else {
        yield LoginFailure(error: 'Das war ein Schuss in den ...');
      }
    } on AuthenticationException catch (e) {
      yield LoginFailure(error: e.message);
    } catch (err) {
      yield LoginFailure(error: err.message ?? 'An unknown error occured');
    }
  }

  Stream<LoginState> _mapLoginWithGoogleToState(
      LoginWithGoogleButtonPressed event) async* {
    yield LoginLoading();
    try {
      final token = await _googleService.signIn();
      if (token != null) {
        final user = await _authenticationService.signInWithGoogle(token);
        if (user != null) {
          _authenticationBloc.add(UserLoggedIn(user: user));
          yield LoginSuccess();
          yield LoginInitial();
        } else {
          _googleService.signOut();
          yield LoginFailure(error: 'Das war ein Schuss in den ...');
        }
      } else {
        yield LoginFailure(error: 'Google sign in failed');
      }
    } on AuthenticationException catch (e) {
      _googleService.signOut();
      yield LoginFailure(error: e.message);
    } catch (err) {
      _googleService.signOut();
      yield LoginFailure(error: err.message ?? 'An unknown error occured');
    }
  }

  Stream<LoginState> _mapLoginWithFacebookToState(
      LoginWithFacebookButtonPressed event) async* {
    yield LoginLoading();
    try {
      final token = await _facebookService.signIn();
      if (token != null) {
        final user = await _authenticationService.signInWithFacebook(token);
        if (user != null) {
          _authenticationBloc.add(UserLoggedIn(user: user));
          yield LoginSuccess();
          yield LoginInitial();
        } else {
          _googleService.signOut();
          yield LoginFailure(error: 'Das war ein Schuss in den ...');
        }
      } else {
        yield LoginFailure(error: 'Facebook sign in failed');
      }
    } on AuthenticationException catch (e) {
      _googleService.signOut();
      yield LoginFailure(error: e.message);
    } catch (err) {
      _googleService.signOut();
      yield LoginFailure(error: err.message ?? 'An unknown error occured');
    }
  }
}
