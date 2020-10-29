import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../models/models.dart';
import '../../../services/services.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationService _authenticationService;
  final GoogleService _googleService;

  AuthenticationBloc(
      AuthenticationService authenticationService, GoogleService googleService)
      : assert(authenticationService != null),
        assert(googleService != null),
        _authenticationService = authenticationService,
        _googleService = googleService,
        super(
          null,
        );

  AuthenticationState get initialState => AuthenticationInitial();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AppLoaded) {
      yield* _mapAppLoadedToState(event);
    }

    if (event is UserLoggedIn) {
      yield* _mapUserLoggedInToState(event);
    }

    if (event is UserSignUp) {
      yield* _mapUserSignUpToState(event);
    }

    if (event is UserSignIn) {
      yield* _mapUserSignInToState(event);
    }

    if (event is UserLoggedOut) {
      yield* _mapUserLoggedOutToState(event);
    }
  }

  Stream<AuthenticationState> _mapAppLoadedToState(AppLoaded event) async* {
    yield AuthenticationLoading();
    try {
      final currentUser = await _authenticationService.getCurrentUser();

      if (currentUser != null) {
        yield AuthenticationAuthenticated(user: currentUser);
      } else {
        yield AuthenticationNotAuthenticated();
      }
    } catch (e) {
      yield AuthenticationFailure(
          message: e.message ?? 'An unknown error occurred');
    }
  }

  Stream<AuthenticationState> _mapUserLoggedInToState(
      UserLoggedIn event) async* {
    yield AuthenticationAuthenticated(user: event.user);
  }

  Stream<AuthenticationState> _mapUserSignUpToState(UserSignUp event) async* {
    yield AuthenticationSignUp();
  }

  Stream<AuthenticationState> _mapUserSignInToState(UserSignIn event) async* {
    yield AuthenticationSignIn();
  }

  Stream<AuthenticationState> _mapUserLoggedOutToState(
      UserLoggedOut event) async* {
    await _googleService.signOut();
    await _authenticationService.signOut();
    yield AuthenticationNotAuthenticated();
  }
}
