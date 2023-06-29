part of 'tab_index_bloc.dart';

abstract class TabIndexEvent extends Equatable {
  const TabIndexEvent();

  @override
  List<Object> get props => [];
}

class ChangeTab extends TabIndexEvent {
  final int newIndex;
  const ChangeTab({
    required this.newIndex,
  });

  @override
  List<Object> get props => [newIndex];
}
