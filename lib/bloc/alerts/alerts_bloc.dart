import 'package:pole_paris_app/repositories/alert_repository.dart';

import '../bloc_exports.dart';
import 'package:equatable/equatable.dart';
import 'package:pole_paris_app/models/alert.dart';
import 'package:pole_paris_app/repositories/user_repository.dart';

part 'alerts_event.dart';
part 'alerts_state.dart';

class AlertsBloc extends Bloc<AlertsEvent, AlertsState> {
  AlertsBloc() : super(AlertsInitial()) {
    on<GetAlerts>(_getAlerts);
    on<DeleteAlert>(_deleteAlert);
    on<ReadAlert>(_readAlert);
  }

  void _getAlerts(GetAlerts event, Emitter<AlertsState> emit) async {
    List<Alert> alerts = [];
    await UserRepository.getUserAlerts().then((value) {
      alerts.addAll(value);
      emit(AlertsState(alerts: alerts));
    });
  }

  void _deleteAlert(DeleteAlert event, Emitter<AlertsState> emit) async {
    final id = event.alertId;
    await AlertRepository.deleteAlert(id).then((value) {
      final reducedAlerts = state.alerts
        ..removeWhere((element) => element.id == id);
      emit(AlertsState(alerts: reducedAlerts));
    });
  }

  void _readAlert(ReadAlert event, Emitter<AlertsState> emit) async {
    await AlertRepository.readAlert(event.alert.id).then((value) {
      final updatedAlerts = state.alerts;
      updatedAlerts[updatedAlerts
              .indexWhere((element) => element.id == event.alert.id)] =
          event.alert.copyWith(read: true);
      emit(AlertsState(alerts: updatedAlerts));
    });
  }
}
