part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class CreateUser extends UserEvent {
  final User newUser;
  const CreateUser({required this.newUser});

  @override
  List<Object> get props => [newUser];
}

class GetMe extends UserEvent {
  @override
  List<Object> get props => [];
}

class UpdateUser extends UserEvent {
  final String fullName;
  final String email;
  final String phoneNumber;
  final String? pictureUrl;

  const UpdateUser(
      this.fullName, this.email, this.phoneNumber, this.pictureUrl);

  @override
  List<Object> get props => [
        fullName,
        email,
        phoneNumber,
      ];
}

class UpdateUserMemberships extends UserEvent {
  final User user;
  final List<UserCarnet> carnets;
  const UpdateUserMemberships(this.user, this.carnets);

  @override
  List<Object> get props => [
        carnets,
      ];
}

class UpdateUserAlerts extends UserEvent {
  final User user;
  final List<Alert> alerts;

  const UpdateUserAlerts(this.user, this.alerts);

  @override
  List<Object> get props => [
        alerts,
      ];
}
