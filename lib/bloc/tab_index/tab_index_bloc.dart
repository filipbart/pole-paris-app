import '../bloc_exports.dart';
import 'package:equatable/equatable.dart';

part 'tab_index_event.dart';
part 'tab_index_state.dart';

class TabIndexBloc extends HydratedBloc<TabIndexEvent, TabIndexState> {
  TabIndexBloc() : super(const TabIndexState()) {
    on<ChangeTab>(_onChangeIndex);
  }

  void _onChangeIndex(ChangeTab event, Emitter<TabIndexState> emit) {
    emit(TabIndexState(selectedIndex: event.newIndex));
  }

  @override
  TabIndexState? fromJson(Map<String, dynamic> json) {
    return TabIndexState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TabIndexState state) {
    return state.toMap();
  }
}
