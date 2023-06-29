import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pole_paris_app/models/class.dart';

part 'class_event.dart';
part 'class_state.dart';

class ClassBloc extends Bloc<ClassEvent, ClassState> {
  ClassBloc() : super(ClassInitial()) {
    on<ClassEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
