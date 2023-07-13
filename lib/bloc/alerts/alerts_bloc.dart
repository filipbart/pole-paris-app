import '../bloc_exports.dart';
import 'package:equatable/equatable.dart';
import 'package:pole_paris_app/models/alert.dart';
import 'package:pole_paris_app/repositories/user_repository.dart';

part 'alerts_event.dart';
part 'alerts_state.dart';

class AlertsBloc extends Bloc<AlertsEvent, AlertsState> {
  AlertsBloc() : super(AlertsInitial()) {
    on<GetAlerts>(_getAlerts);
  }

  void _getAlerts(AlertsEvent event, Emitter<AlertsState> emit) async {
    List<Alert> alerts = [];
    await UserRepository.getUserAlerts().then((value) {
      alerts.addAll(value);
      emit(AlertsState(alerts: alerts));
    });
  }
}
