part of 'classes_bloc.dart';

class ClassesState extends Equatable {
  final List<Class> classes;
  const ClassesState({
    this.classes = const <Class>[],
  });

  @override
  List<Object> get props => [classes];
}
