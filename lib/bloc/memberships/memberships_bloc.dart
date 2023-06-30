import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pole_paris_app/models/membership.dart';
import 'package:pole_paris_app/repositories/user_repository.dart';

part 'memberships_event.dart';
part 'memberships_state.dart';

class MembershipsBloc extends Bloc<MembershipsEvent, MembershipsState> {
  MembershipsBloc() : super(const MembershipsState()) {
    on<GetAllMemberships>(_getAllMemberships);
  }

  void _getAllMemberships(
      MembershipsEvent event, Emitter<MembershipsState> emit) async {
    List<Membership> result = [];
    await UserRepository.getUserMemberships().then((value) {
      if (value != null) {
        result.addAll(value);
      }

      emit(MembershipsState(userMemberships: result));
    });
  }
}
