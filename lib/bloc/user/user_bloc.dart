import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:pole_paris_app/bloc/bloc_exports.dart';
import 'package:pole_paris_app/models/user.dart';
import 'package:pole_paris_app/models/user_carnet.dart';
import 'package:pole_paris_app/repositories/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final CarnetsBloc carnetsBloc;
  late StreamSubscription carnetsSubscription;
  UserBloc({required this.carnetsBloc}) : super(const UserState()) {
    carnetsSubscription = carnetsBloc.stream.listen((event) {
      if (state.user != null) {
        add(UpdateUserMemberships(state.user!, event.userCarnets));
      }
    });

    on<CreateUser>(_onCreateUserTask);
    on<GetMe>(_onGetMeTask);
    on<UpdateUser>(_onUpdateUser);
    on<UpdateUserMemberships>(_onUpdateUserMemberships);
  }

  void _onCreateUserTask(CreateUser event, Emitter<UserState> emit) async {
    await UserRepository.create(event.newUser);
  }

  void _onGetMeTask(GetMe event, Emitter<UserState> emit) async {
    await UserRepository.getMe().then((value) {
      emit(UserState(user: value));
    }).onError((error, stackTrace) {});
  }

  void _onUpdateUser(UpdateUser event, Emitter<UserState> emit) async {
    await UserRepository.update(
      fullName: event.fullName,
      email: event.email,
      phoneNumber: event.phoneNumber,
      pictureUrl: event.pictureUrl,
    );
  }

  void _onUpdateUserMemberships(
      UpdateUserMemberships event, Emitter<UserState> emit) {
    event.user.carnets = event.carnets;
    emit(UserState(user: event.user));
  }
}
