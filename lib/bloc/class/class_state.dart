part of 'class_bloc.dart';

abstract class ClassState extends Equatable {
  const ClassState();
  
  @override
  List<Object> get props => [];
}

class ClassInitial extends ClassState {}
