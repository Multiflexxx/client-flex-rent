part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RegisterPhoneForm extends RegisterEvent {}

class RegisterPersonalForm extends RegisterEvent {}

class RegisterButtonPressed extends RegisterEvent {
  final User user;

  RegisterButtonPressed({@required this.user});
}
