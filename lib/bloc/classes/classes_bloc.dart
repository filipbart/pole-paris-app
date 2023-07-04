import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pole_paris_app/models/class.dart';
import 'package:pole_paris_app/repositories/class_repository.dart';

part 'classes_event.dart';
part 'classes_state.dart';

class ClassesBloc extends Bloc<ClassesEvent, ClassesState> {
  ClassesBloc() : super(const ClassesState()) {
    on<GetClasses>(_onGetClasses);
  }

  void _onGetClasses(GetClasses event, Emitter<ClassesState> emit) async {
    final classes = await ClassRepository.getMyClasses();
    emit(ClassesState(classes: classes));
  }
}
