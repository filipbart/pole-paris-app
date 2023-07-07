// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'carnets_bloc.dart';

class CarnetsState {
  final List<UserCarnet> userCarnets;
  const CarnetsState({
    this.userCarnets = const <UserCarnet>[],
  });
}

class CarnetsInitial extends CarnetsState {}
