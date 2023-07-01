import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pole_paris_app/models/user.dart';
import 'package:pole_paris_app/repositories/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(const UserState()) {
    on<CreateUser>(_onCreateUserTask);
    on<GetMe>(_onGetMeTask);
    on<UpdateUser>(_onUpdateUser);
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
}
