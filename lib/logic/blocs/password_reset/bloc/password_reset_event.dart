part of 'password_reset_bloc.dart';

abstract class PasswordResetEvent extends Equatable {
  const PasswordResetEvent();

  @override
  List<Object> get props => [];
}

class PasswordResetSendRequest extends PasswordResetEvent {
  final String email;

  PasswordResetSendRequest({@required this.email});

  @override
  List<Object> get props => [email];
}

class PasswordResetSendCode extends PasswordResetEvent {
  final String email;
  final String code;

  PasswordResetSendCode({@required this.email, @required this.code});

  @override
  List<Object> get props => [email, code];
}

class PasswordResetSendNewPassword extends PasswordResetEvent {
  final String email;
  final String token;
  final String password;

  PasswordResetSendNewPassword(
      {@required this.email, @required this.token, @required this.password});

  @override
  List<Object> get props => [email, token, password];
}
