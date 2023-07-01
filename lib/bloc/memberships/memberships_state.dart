// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'memberships_bloc.dart';

class MembershipsState {
  final List<Membership> userMemberships;
  const MembershipsState({
    this.userMemberships = const <Membership>[],
  });
}

class MembershipsInitial extends MembershipsState {}
