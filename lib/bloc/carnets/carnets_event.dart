part of 'carnets_bloc.dart';

abstract class CarnetsEvent extends Equatable {
  const CarnetsEvent();

  @override
  List<Object> get props => [];
}

class GetAllCarnets extends CarnetsEvent {
  @override
  List<Object> get props => [];
}
