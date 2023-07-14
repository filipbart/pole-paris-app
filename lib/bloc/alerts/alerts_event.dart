part of 'alerts_bloc.dart';

abstract class AlertsEvent extends Equatable {
  const AlertsEvent();

  @override
  List<Object> get props => [];
}

class GetAlerts extends AlertsEvent {}

class ReadAlert extends AlertsEvent {
  final Alert alert;

  const ReadAlert(this.alert);

  @override
  List<Object> get props => [alert];
}

class DeleteAlert extends AlertsEvent {
  final String alertId;

  const DeleteAlert(this.alertId);

  @override
  List<Object> get props => [alertId];
}
