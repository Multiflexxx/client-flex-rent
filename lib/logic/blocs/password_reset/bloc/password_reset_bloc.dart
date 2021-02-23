import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flexrent/logic/exceptions/exceptions.dart';
import 'package:flexrent/logic/models/models.dart';
import 'package:meta/meta.dart';

import 'package:flexrent/logic/blocs/authentication/authentication.dart';
import 'package:flexrent/logic/services/services.dart';

part 'password_reset_event.dart';
part 'password_reset_state.dart';

class PasswordResetBloc extends Bloc<PasswordResetEvent, PasswordResetState> {
  final AuthenticationBloc _authenticationBloc;
  final AuthenticationService _authenticationService;

  PasswordResetBloc(AuthenticationBloc authenticationBloc,
      AuthenticationService authenticationService)
      : assert(authenticationBloc != null),
        assert(authenticationService != null),
        _authenticationBloc = authenticationBloc,
        _authenticationService = authenticationService,
        super(null);

  PasswordResetState get initialState => PasswordResetInitial();

  @override
  Stream<PasswordResetState> mapEventToState(
    PasswordResetEvent event,
  ) async* {
    if (event is PasswordResetSendRequest) {
      yield* _mapPasswordResetSendRequesetToState(event);
    }
    if (event is PasswordResetSendCode) {
      yield* _mapPasswordResetSendCodeToState(event);
    }
    if (event is PasswordResetSendNewPassword) {
      yield* _mapPasswordResetSendNewPasswordToState(event);
    }
  }

  Stream<PasswordResetState> _mapPasswordResetSendRequesetToState(
      PasswordResetSendRequest event) async* {
    yield PasswordResetLoading();
    await Future.delayed(Duration(milliseconds: 1500));
    try {
      await _authenticationService.requestPasswordReset(email: event.email);
      yield PasswordResetRequestSuccess(email: event.email);
    } on AuthenticationException catch (e) {
      yield PasswordResetEmailFailure(error: e.message);
    } catch (err) {
      yield PasswordResetFailure(
          error: err.message ?? 'Hier ist etwas schief gelaufen.');
    }
  }

  Stream<PasswordResetState> _mapPasswordResetSendCodeToState(
      PasswordResetSendCode event) async* {
    yield PasswordResetLoading();
    await Future.delayed(Duration(milliseconds: 1500));
    try {
      String token = await _authenticationService.getPasswordResetToken(
          email: event.email, code: event.code);
      yield PasswordResetCodeSuccess(
        email: event.email,
        token: token,
      );
    } on AuthenticationException catch (e) {
      yield PasswordResetCodeFailure(error: e.message);
    } catch (err) {
      yield PasswordResetFailure(
          error: err.message ?? 'Hier ist etwas schief gelaufen.');
    }
  }

  Stream<PasswordResetState> _mapPasswordResetSendNewPasswordToState(
      PasswordResetSendNewPassword event) async* {
    yield PasswordResetLoading();
    try {
      User user = await _authenticationService.resetPassword(
          email: event.email, token: event.token, password: event.password);
      _authenticationBloc.add(UserLoggedIn(user: user));
      yield PasswordResetCodeSuccess();
      yield PasswordResetInitial();
    } on AuthenticationException catch (e) {
      yield PasswordResetFailure(error: e.message);
    } catch (err) {
      yield PasswordResetFailure(
          error: err.message ?? 'Hier ist etwas schief gelaufen.');
    }
  }
}
