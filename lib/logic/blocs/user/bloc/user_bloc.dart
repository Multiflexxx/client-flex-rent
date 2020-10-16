import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rent/logic/blocs/authentication/authentication.dart';
import 'package:rent/logic/exceptions/exceptions.dart';
import 'package:rent/logic/models/models.dart';
import 'package:meta/meta.dart';
import 'package:rent/logic/services/services.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final AuthenticationBloc _authenticationBloc;
  final UserService _userService;

  UserBloc(AuthenticationBloc authenticationBloc, UserService userService)
      : assert(authenticationBloc != null),
        assert(userService != null),
        _authenticationBloc = authenticationBloc,
        _userService = userService,
        super(null);

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is UserUpdate) {
      yield* _mapUserUpdateToState(event);
    }
    if (event is ProfileImageUpload) {
      yield* _mapProfileImageUploadToState(event);
    }
  }

  Stream<UserState> _mapUserUpdateToState(UserUpdate event) async* {
    yield UserLoading();
    try {
      var user;
      if (event.password == null) {
        user = await _userService.updateUser(user: event.user);
      } else {
        user = await _userService.updateUser(
            user: event.user, password: event.password);
      }

      if (user != null) {
        _authenticationBloc.add(UserLoggedIn(user: user));
        yield UserSuccess();
        yield UserInitial();
      } else {
        yield UserFailure(error: 'Fehler bei Api Call');
      }
    } on AuthenticationException catch (e) {
      yield UserFailure(error: e.message ?? 'An unknown error occurred');
    }
  }

  Stream<UserState> _mapProfileImageUploadToState(
      ProfileImageUpload event) async* {
    yield UserLoading();
    try {
      final user = await _userService.updateProfileImage(imagePath: event.path);
      if (user != null) {
        _authenticationBloc.add(UserLoggedIn(user: user));
        yield UserImageSuccess();
        yield UserInitial();
      } else {
        yield UserFailure(error: 'Fehler bei Api Call');
      }
    } on AuthenticationException catch (e) {
      yield UserFailure(error: e.message ?? 'An unknown error occurred');
    }
  }
}
