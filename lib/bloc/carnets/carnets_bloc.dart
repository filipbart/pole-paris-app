import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pole_paris_app/models/user_carnet.dart';
import 'package:pole_paris_app/repositories/user_repository.dart';

part 'carnets_event.dart';
part 'carnets_state.dart';

class CarnetsBloc extends Bloc<CarnetsEvent, CarnetsState> {
  CarnetsBloc() : super(const CarnetsState()) {
    on<GetAllCarnets>(_getAllCarnets);
    on<AddNewCarnet>(_addNewCarnet);
  }

  void _getAllCarnets(CarnetsEvent event, Emitter<CarnetsState> emit) async {
    List<UserCarnet> result = [];
    await UserRepository.getUserCarnets().then((value) {
      if (value != null) {
        result.addAll(value);
      }

      emit(CarnetsState(userCarnets: result));
    });
  }

  void _addNewCarnet(AddNewCarnet event, Emitter<CarnetsState> emit) async {
    final carnets = state.userCarnets;
    carnets.add(event.newCarnet);
    emit(CarnetsState(userCarnets: carnets));
  }
}
