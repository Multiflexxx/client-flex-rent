import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:rent/logic/blocs/authentication/authentication.dart';
import 'package:rent/logic/exceptions/exceptions.dart';
import 'package:rent/logic/models/models.dart';
import 'package:rent/logic/services/register_service.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthenticationBloc _authenticationBloc;
  final RegisterService _registerService;

  RegisterBloc(
      AuthenticationBloc authenticationBloc, RegisterService registerService)
      : assert(authenticationBloc != null),
        assert(registerService != null),
        _authenticationBloc = authenticationBloc,
        _registerService = registerService,
        super(null);

  RegisterState get initalState => RegisterInitial();

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is RegisterPhoneForm) {
      yield* _mapPhoneFormToState(event);
    }

    if (event is RegisterPersonalForm) {
      yield* _mapPersonalFormToState(event);
    }

    if (event is RegisterButtonPressed) {
      yield* _mapRegisterToState(event);
    }
  }

  Stream<RegisterState> _mapPhoneFormToState(RegisterPhoneForm event) async* {
    yield RegisterInitial();
  }

  Stream<RegisterState> _mapPersonalFormToState(
      RegisterPersonalForm event) async* {
    yield RegisterPersonal();
  }

  Stream<RegisterState> _mapRegisterToState(
      RegisterButtonPressed event) async* {
    yield RegisterLoading();
    try {
      final user = await _registerService.registerUser(event.user);
      if (user != null) {
        _authenticationBloc.add(UserLoggedIn(user: user));
        yield RegisterSuccess();
        yield RegisterInitial();
      } else {
        yield RegisterFailure(error: 'Das war ein Schuss in den ...');
      }
    } on RegisterException catch (e) {
      yield RegisterFailure(error: e.message);
    } catch (err) {
      yield RegisterFailure(error: err.message ?? 'An unknown error occured');
    }
  }
}
