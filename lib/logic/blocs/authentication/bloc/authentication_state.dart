part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationState extends Equatable {
  AuthenticationState({this.loggedIn, this.user});

  final bool loggedIn;
  final User user;

  @override
  List<Object> get props => [loggedIn, user];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationNotAuthenticated extends AuthenticationState {
  final String message;

  AuthenticationNotAuthenticated({this.message});

  @override
  List<Object> get props => [message];
}

class AuthenticationAuthenticated extends AuthenticationState {
  final User user;

  AuthenticationAuthenticated({@required this.user});

  @override
  List<Object> get props => [user];
}

class AuthenticationSignIn extends AuthenticationState {}

class AuthenticationSignUp extends AuthenticationState {}

class AuthenticationCanceld extends AuthenticationState {}

class AuthenticationFailure extends AuthenticationState {
  final String message;

  AuthenticationFailure({@required this.message});

  @override
  List<Object> get props => [message];
}
