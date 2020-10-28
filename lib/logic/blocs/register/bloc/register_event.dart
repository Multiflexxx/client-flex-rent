part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RegisterWithGoogle extends RegisterEvent {}

class RegisterPhoneForm extends RegisterEvent {}

class RegisterNextPressed extends RegisterEvent {
  final String phoneNumber;

  RegisterNextPressed({@required this.phoneNumber});
}

class RegisterSubmitPressed extends RegisterEvent {
  final User user;

  RegisterSubmitPressed({@required this.user});
}
