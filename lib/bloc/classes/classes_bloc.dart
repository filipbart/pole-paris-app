import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pole_paris_app/models/class.dart';

part 'classes_event.dart';
part 'classes_state.dart';

class ClassesBloc extends Bloc<ClassesEvent, ClassesState> {
  ClassesBloc() : super(const ClassesState()) {
    on<ClassesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
