part of 'password_reset_bloc.dart';

abstract class PasswordResetState extends Equatable {
  const PasswordResetState({this.email, this.token, this.error});

  final String email;
  final String token;
  final String error;

  @override
  List<Object> get props => [token, token];
}

class PasswordResetInitial extends PasswordResetState {}

class PasswordResetLoading extends PasswordResetState {}

class PasswordResetRequestSuccess extends PasswordResetState {
  PasswordResetRequestSuccess({email}) : super(email: email);

  @override
  List<Object> get props => [email];
}

class PasswordResetCodeSuccess extends PasswordResetState {
  PasswordResetCodeSuccess({email, token}) : super(email: email, token: token);

  @override
  List<Object> get props => [email, token];
}

class PasswordResetSuccess extends PasswordResetState {}

class PasswordResetFailure extends PasswordResetState {
  PasswordResetFailure({error}) : super(error: error);

  @override
  List<Object> get props => [error];
}

class PasswordResetEmailFailure extends PasswordResetState {
  PasswordResetEmailFailure({error}) : super(error: error);

  @override
  List<Object> get props => [error];
}

class PasswordResetCodeFailure extends PasswordResetState {
  PasswordResetCodeFailure({error}) : super(error: error);

  @override
  List<Object> get props => [error];
}
