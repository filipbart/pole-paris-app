part of 'alerts_bloc.dart';

abstract class AlertsEvent extends Equatable {
  const AlertsEvent();

  @override
  List<Object> get props => [];
}

class GetAlerts extends AlertsEvent {}
