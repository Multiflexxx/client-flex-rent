part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class UserUpdate extends UserEvent {
  final User user;
  final Password password;

  UserUpdate({@required this.user, this.password});

  @override
  List<Object> get props => [user, password];
}

class ProfileImageUpload extends UserEvent {
  final String path;

  ProfileImageUpload({@required this.path});

  @override
  List<Object> get props => [path];
}
