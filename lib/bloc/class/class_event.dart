// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'class_bloc.dart';

abstract class ClassEvent extends Equatable {
  const ClassEvent();

  @override
  List<Object> get props => [];
}

class AddClass extends ClassEvent {
  final Class newClass;
  const AddClass({
    required this.newClass,
  });

  @override
  List<Object> get props => [newClass];
}

class UpdateClass extends ClassEvent {
  final Class modifiedClass;
  const UpdateClass({
    required this.modifiedClass,
  });

  @override
  List<Object> get props => [modifiedClass];
}

class CancelClass extends ClassEvent {
  final Class classToCancel;
  const CancelClass({
    required this.classToCancel,
  });

  @override
  List<Object> get props => [classToCancel];
}
