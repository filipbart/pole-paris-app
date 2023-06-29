part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class CreateUserTask extends UserEvent {
  final User newUser;
  const CreateUserTask({required this.newUser});

  @override
  List<Object> get props => [newUser];
}

class GetMeTask extends UserEvent {
  @override
  List<Object> get props => [];
}
