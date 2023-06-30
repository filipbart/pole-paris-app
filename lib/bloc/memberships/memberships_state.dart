// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'memberships_bloc.dart';

class MembershipsState extends Equatable {
  final List<Membership> userMemberships;
  const MembershipsState({
    this.userMemberships = const <Membership>[],
  });

  @override
  List<Object> get props => [
        userMemberships,
      ];
}

class MembershipsInitial extends MembershipsState {}
