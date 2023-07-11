// ignore_for_file: public_member_api_docs, sort_constructors_first
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

class AddNewCarnet extends CarnetsEvent {
  final UserCarnet newCarnet;
  const AddNewCarnet({
    required this.newCarnet,
  });

  @override
  List<Object> get props => [
        newCarnet,
      ];
}
