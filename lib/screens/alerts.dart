import 'package:flutter/material.dart';
import 'package:pole_paris_app/styles/color.dart';
import 'package:pole_paris_app/widgets/alert_item.dart';
import 'package:pole_paris_app/widgets/base/app_bar.dart';

class AlertsScreen extends StatefulWidget {
  const AlertsScreen({super.key});

  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class Alert {
  final String title;
  final String content;
  final String htmlContent;

  Alert(
    this.title,
    this.content,
    this.htmlContent,
  );
}

class _AlertsScreenState extends State<AlertsScreen> {
  static List<Alert> alerts = [
    Alert(
        'Potwierdzenie zapisu na zajęcia',
        'Witamy! Potwierdzamy zapis na zajęcia Pole Dance w dniu 26.05.2023 w godzinach 9:30 - 10:30. Dziękujemy za skorzystanie z naszych usług. Liczymy na dobrze spędzony czas! Grupa Pole Paris Studio',
        """<div>
Witamy! Potwierdzamy zapis na zajęcia <b>Pole Dance</b> w dniu <b>26.05.2023</b> w&nbsp;godzinach <b>9:30&nbsp;-&nbsp;10:30.</b> <br />
Dziękujemy za skorzystanie z naszych usług. Liczymy na dobrze spędzony czas! <br />
Grupa <b>Pole Paris Studio</b>
</div>"""),
    Alert(
        'Potwierdzenie zapisu na zajęcia',
        'Witamy! Potwierdzamy zapis na zajęcia Pole Dance w dniu 26.05.2023 w godzinach 9:30 - 10:30. Dziękujemy za skorzystanie z naszych usług. Liczymy na dobrze spędzony czas! Grupa Pole Paris Studio',
        """<div>
Witamy! Potwierdzamy zapis na zajęcia <b>Pole Dance</b> w dniu <b>26.05.2023</b> w&nbsp;godzinach <b>9:30&nbsp;-&nbsp;10:30.</b> <br />
Dziękujemy za skorzystanie z naszych usług. Liczymy na dobrze spędzony czas! <br />
Grupa <b>Pole Paris Studio</b>
</div>"""),
  ];

  @override
  Widget build(BuildContext context) {
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
                padding:
                    const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
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
                  separatorBuilder: (context, index) => Container(height: 10),
                ),
              )
            : const Center(child: Text('Brak powiadomień')),
      ),
    );
  }
}
