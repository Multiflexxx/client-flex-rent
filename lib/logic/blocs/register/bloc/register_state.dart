part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

// Loading
class RegisterLoading extends RegisterState {}

class RegisterPhoneLoading extends RegisterState {
  final String signUpOption;
  final User thirdPartyUser;

  RegisterPhoneLoading({@required this.signUpOption, this.thirdPartyUser});

  @override
  List<Object> get props => [signUpOption, thirdPartyUser];
}

class RegisterPersonalLoading extends RegisterState {
  final String signUpOption;
  final String phoneNumber;
  final User thirdPartyUser;

  RegisterPersonalLoading(
      {@required this.signUpOption,
      @required this.phoneNumber,
      this.thirdPartyUser});

  @override
  List<Object> get props => [signUpOption, phoneNumber, thirdPartyUser];
}

// Success
class RegisterPhoneSuccess extends RegisterState {
  final String signUpOption;
  final String phoneNumber;
  final User thirdPartyUser;

  RegisterPhoneSuccess(
      {@required this.signUpOption,
      @required this.phoneNumber,
      this.thirdPartyUser});

  @override
  List<Object> get props => [signUpOption, phoneNumber, thirdPartyUser];
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
  final String signUpOption;
  final String phoneNumber;
  final User thirdPartyUser;

  RegisterPersonalFailure(
      {@required this.error,
      @required this.signUpOption,
      @required this.phoneNumber,
      this.thirdPartyUser});

  @override
  List<Object> get props => [error, phoneNumber];
}
