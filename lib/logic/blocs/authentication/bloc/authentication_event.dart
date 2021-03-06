part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppLoaded extends AuthenticationEvent {}

class UserLoggedIn extends AuthenticationEvent {
  final User user;

  UserLoggedIn({@required this.user});

  @override
  List<Object> get props => [user];
}

class UserSignUp extends AuthenticationEvent {}

class UserSignIn extends AuthenticationEvent {}

class UserCanceld extends AuthenticationEvent {}

class UserSignOut extends AuthenticationEvent {}
