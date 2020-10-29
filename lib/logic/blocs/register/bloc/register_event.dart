part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RegisterSetInital extends RegisterEvent {}

class RegisterWithGoogle extends RegisterEvent {
  final String signUpOption;

  RegisterWithGoogle({
    this.signUpOption,
  });
}

class RegisterWithFacebook extends RegisterEvent {
  final String signUpOption;

  RegisterWithFacebook({
    this.signUpOption,
  });
}

class RegisterPhoneForm extends RegisterEvent {
  final String signUpOption;
  final User thirdPartyUser;

  RegisterPhoneForm({
    this.signUpOption,
    this.thirdPartyUser,
  });
}

class RegisterNextPressed extends RegisterEvent {
  final String signUpOption;
  final String phoneNumber;
  final User thirdPartyUser;

  RegisterNextPressed({
    this.signUpOption,
    @required this.phoneNumber,
    this.thirdPartyUser,
  });
}

class RegisterSubmitPressed extends RegisterEvent {
  final String signUpOption;
  final User user;

  RegisterSubmitPressed({@required this.signUpOption, @required this.user});
}
