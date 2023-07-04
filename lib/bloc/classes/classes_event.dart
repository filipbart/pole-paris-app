part of 'classes_bloc.dart';

abstract class ClassesEvent extends Equatable {
  const ClassesEvent();

  @override
  List<Object> get props => [];
}

class GetClasses extends ClassesEvent {
  final bool forTeacher;

  const GetClasses({required this.forTeacher});
  @override
  List<Object> get props => [forTeacher];
}
