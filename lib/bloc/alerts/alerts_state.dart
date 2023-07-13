part of 'alerts_bloc.dart';

class AlertsState extends Equatable {
  final List<Alert> alerts;
  const AlertsState({
    this.alerts = const <Alert>[],
  });

  @override
  List<Object> get props => [
        alerts,
      ];
}

class AlertsInitial extends AlertsState {}
