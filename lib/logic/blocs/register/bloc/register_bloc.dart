import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flexrent/logic/services/services.dart';
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
  final FacebookService _facebookService;

  RegisterBloc(
      AuthenticationBloc authenticationBloc,
      RegisterService registerService,
      GoogleService googleService,
      FacebookService facebookService)
      : assert(authenticationBloc != null),
        assert(registerService != null),
        assert(googleService != null),
        assert(facebookService != null),
        _authenticationBloc = authenticationBloc,
        _registerService = registerService,
        _googleService = googleService,
        _facebookService = facebookService,
        super(null);

  RegisterState get initalState => RegisterInitial();

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is RegisterSetInital) {
      yield* _mapRegisterSetInitalToState(event);
    }

    if (event is RegisterPhoneForm) {
      yield* _mapPhoneFormToState(event);
    }

    if (event is RegisterWithGoogle) {
      yield* _mapRegisterWithGoogleToState(event);
    }

    if (event is RegisterWithFacebook) {
      yield* _mapRegisterWithFacebookToState(event);
    }

    if (event is RegisterNextPressed) {
      yield* _mapPersonalFormToState(event);
    }

    if (event is RegisterSubmitPressed) {
      yield* _mapRegisterToState(event);
    }
  }

  Stream<RegisterState> _mapRegisterSetInitalToState(
      RegisterSetInital event) async* {
    yield RegisterInitial();
  }

  Stream<RegisterState> _mapRegisterWithGoogleToState(
      RegisterWithGoogle event) async* {
    User googleUser = await _googleService.signUp();
    if (googleUser != null) {
      yield RegisterPhoneLoading(
          signUpOption: event.signUpOption, thirdPartyUser: googleUser);
    } else {
      yield RegisterInitial();
    }
  }

  Stream<RegisterState> _mapRegisterWithFacebookToState(
      RegisterWithFacebook event) async* {
    User facebookUser = await _facebookService.signUp();
    if (facebookUser != null) {
      yield RegisterPhoneLoading(
          signUpOption: event.signUpOption, thirdPartyUser: facebookUser);
    } else {
      yield RegisterInitial();
    }
  }

  Stream<RegisterState> _mapPhoneFormToState(RegisterPhoneForm event) async* {
    yield RegisterPhoneLoading(signUpOption: event.signUpOption);
  }

  Stream<RegisterState> _mapPersonalFormToState(
      RegisterNextPressed event) async* {
    yield RegisterPhoneSuccess(
      signUpOption: event.signUpOption,
      phoneNumber: event.phoneNumber,
      thirdPartyUser: event.thirdPartyUser,
    );
  }

  Stream<RegisterState> _mapRegisterToState(
      RegisterSubmitPressed event) async* {
    // yield RegisterPersonalLoading(
    //   phoneNumber: event.user.phoneNumber,
    //   signUpOption: event.signUpOption,
    //   thirdPartyUser: event.user,
    // );
    try {
      final user = await _registerService.registerUser(
          user: event.user, signInOption: event.signUpOption);
      if (user != null) {
        _authenticationBloc.add(UserLoggedIn(user: user));
        yield RegisterSuccess();
        yield RegisterInitial();
      } else {
        _googleService.signOut();
        yield RegisterFailure(
          error: 'Das war ein Schuss in den ...',
        );
      }
    } on RegisterException catch (e) {
      _googleService.signOut();
      yield RegisterFailure(
        error: e.message,
      );
    } catch (err) {
      _googleService.signOut();
      yield RegisterFailure(
        error: err.message ?? 'An unknown error occured',
      );
    }
  }
}
