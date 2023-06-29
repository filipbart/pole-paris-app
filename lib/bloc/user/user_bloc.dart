import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pole_paris_app/models/user.dart';
import 'package:pole_paris_app/repositories/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(const UserState()) {
    on<CreateUserTask>(_onCreateUserTask);
    on<GetMeTask>(_onGetMeTask);
  }

  void _onCreateUserTask(CreateUserTask event, Emitter<UserState> emit) async {
    await UserRepository.create(event.newUser);
  }

  void _onGetMeTask(GetMeTask event, Emitter<UserState> emit) async {
    await UserRepository.getMe().then((value) {
      emit(UserState(user: value));
    });
  }
}
