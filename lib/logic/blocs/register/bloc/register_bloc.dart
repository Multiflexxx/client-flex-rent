import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flexrent/logic/services/google_service.dart';
import 'package:meta/meta.dart';

import 'package:flexrent/logic/blocs/authentication/authentication.dart';
import 'package:flexrent/logic/exceptions/exceptions.dart';
import 'package:flexrent/logic/models/models.dart';
import 'package:flexrent/logic/services/register_service.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthenticationBloc _authenticationBloc;
  final RegisterService _registerService;
  final GoogleService _googleService;

  RegisterBloc(AuthenticationBloc authenticationBloc,
      RegisterService registerService, GoogleService googleService)
      : assert(authenticationBloc != null),
        assert(registerService != null),
        assert(googleService != null),
        _authenticationBloc = authenticationBloc,
        _registerService = registerService,
        _googleService = googleService,
        super(null);

  RegisterState get initalState => RegisterInitial();

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is RegisterPhoneForm) {
      yield* _mapPhoneFormToState(event);
    }

    if (event is RegisterWithGoogle) {
      yield* _mapRegisterWithGoogleToState(event);
    }

    if (event is RegisterNextPressed) {
      yield* _mapPersonalFormToState(event);
    }

    if (event is RegisterSubmitPressed) {
      yield* _mapRegisterToState(event);
    }
  }

  Stream<RegisterState> _mapPhoneFormToState(RegisterPhoneForm event) async* {
    yield RegisterPhoneLoading(signUpOption: event.signUpOption);
  }

  Stream<RegisterState> _mapRegisterWithGoogleToState(
      RegisterWithGoogle event) async* {
    User googleUser = await _googleService.signIn();
    inspect(googleUser);
    yield RegisterPhoneLoading(
        signUpOption: event.signUpOption, thirdPartyUser: googleUser);
  }

  Stream<RegisterState> _mapPersonalFormToState(
      RegisterNextPressed event) async* {
    yield RegisterPhoneSuccess(
        signUpOption: event.signUpOption, phoneNumber: event.phoneNumber);
  }

  Stream<RegisterState> _mapRegisterToState(
      RegisterSubmitPressed event) async* {
    yield RegisterPersonalLoading(
        signUpOption: event.signUpOption, phoneNumber: event.user.phoneNumber);
    try {
      final user = await _registerService.registerUser(event.user);
      if (user != null) {
        _authenticationBloc.add(UserLoggedIn(user: user));
        yield RegisterSuccess();
        yield RegisterInitial();
      } else {
        yield RegisterPersonalFailure(
            error: 'Das war ein Schuss in den ...',
            signUpOption: event.signUpOption,
            phoneNumber: event.user.phoneNumber);
      }
    } on RegisterException catch (e) {
      yield RegisterPersonalFailure(
          error: e.message,
          phoneNumber: event.user.phoneNumber,
          signUpOption: event.signUpOption);
    } catch (err) {
      yield RegisterPersonalFailure(
          error: err.message ?? 'An unknown error occured',
          signUpOption: event.signUpOption,
          phoneNumber: event.user.phoneNumber);
    }
  }
}
