part of 'memberships_bloc.dart';

abstract class MembershipsEvent extends Equatable {
  const MembershipsEvent();

  @override
  List<Object> get props => [];
}

class GetAllMemberships extends MembershipsEvent {
  @override
  List<Object> get props => [];
}
