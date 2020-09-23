part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

// Loading
class RegisterLoading extends RegisterState {}

class RegisterPhoneLoading extends RegisterState {}

class RegisterPersonalLoading extends RegisterState {
  final String phoneNumber;

  RegisterPersonalLoading({@required this.phoneNumber});

  @override
  List<Object> get props => [phoneNumber];
}

// Success
class RegisterPhoneSuccess extends RegisterState {
  final String phoneNumber;

  RegisterPhoneSuccess({@required this.phoneNumber});

  @override
  List<Object> get props => [phoneNumber];
}

class RegisterSuccess extends RegisterState {}

// Failure
class RegisterPhoneFailure extends RegisterState {
  final String error;

  RegisterPhoneFailure({@required this.error});

  @override
  List<Object> get props => [error];
}

class RegisterPersonalFailure extends RegisterState {
  final String error;
  final String phoneNumber;

  RegisterPersonalFailure({@required this.error, @required this.phoneNumber});

  @override
  List<Object> get props => [error, phoneNumber];
}
