import 'package:flutter/material.dart';
import 'package:pole_paris_app/bloc/bloc_exports.dart';
import 'package:pole_paris_app/styles/color.dart';
import 'package:pole_paris_app/widgets/alert_item.dart';
import 'package:pole_paris_app/widgets/base/app_bar.dart';

class AlertsScreen extends StatelessWidget {
  const AlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlertsBloc, AlertsState>(
      builder: (context, state) {
        final alerts = state.alerts;

        return Scaffold(
          appBar: BaseAppBar(
            title: 'Powiadomienia',
            appBar: AppBar(),
            withDrawer: false,
          ),
          drawer: null,
          body: SafeArea(
            child: alerts.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 20),
                    child: ListView.separated(
                      itemCount:
                          alerts.isNotEmpty ? alerts.length + 1 : alerts.length,
                      itemBuilder: (context, index) {
                        if (index == alerts.length) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 15),
                              child: Text(
                                'Nie masz więcej powiadomień.',
                                style: TextStyle(
                                  color: CustomColors.hintText,
                                  fontSize: 16,
                                  fontFamily: 'Satoshi',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          );
                        } else {
                          return AlertItem(alert: alerts[index]);
                        }
                      },
                      separatorBuilder: (context, index) =>
                          Container(height: 10),
                    ),
                  )
                : const Center(child: Text('Brak powiadomień')),
          ),
        );
      },
    );
  }
}
