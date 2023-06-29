part of 'tab_index_bloc.dart';

class TabIndexState extends Equatable {
  final int selectedIndex;
  const TabIndexState({this.selectedIndex = 0});

  @override
  List<Object> get props => [selectedIndex];

  Map<String, dynamic> toMap() {
    return {
      'selectedIndex': selectedIndex,
    };
  }

  factory TabIndexState.fromMap(Map<String, dynamic> map) {
    return TabIndexState(
      selectedIndex: map['selectedIndex'] ?? 0,
    );
  }
}
