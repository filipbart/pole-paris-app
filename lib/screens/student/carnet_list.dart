import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pole_paris_app/bloc/bloc_exports.dart';
import 'package:pole_paris_app/extensions/dateTime.dart';
import 'package:pole_paris_app/models/user_carnet.dart';
import 'package:pole_paris_app/screens/student/buy_carnet.dart';
import 'package:pole_paris_app/styles/button.dart';
import 'package:pole_paris_app/styles/color.dart';
import 'package:pole_paris_app/widgets/base/app_bar.dart';
import 'package:pole_paris_app/widgets/student/carnet.dart';
import 'package:pole_paris_app/widgets/student/expired_carnet.dart';
import 'package:pole_paris_app/widgets/student/pending_carnet.dart';

enum WidgetCarnetType { active, expired, pending }

class CarnetListScreen extends StatelessWidget {
  const CarnetListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: 'Twoje karnety',
        appBar: AppBar(),
      ),
      body: SafeArea(
        child: BlocBuilder<CarnetsBloc, CarnetsState>(
          builder: (context, state) {
            final carnets = state.userCarnets
                .where((element) =>
                    element.paid == true && element.expired == false)
                .toList();
            final pendingCarnets = state.userCarnets
                .where((element) => element.paid == false)
                .toList();
            final expiredCarnets = state.userCarnets
                .where((element) => element.expired == true)
                .toList();
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Aktywne karnety',
                                style: TextStyle(
                                  color: Color(0xFF404040),
                                  fontSize: 16,
                                  fontFamily: 'Satoshi',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                'Data zakupu',
                                style: TextStyle(
                                  color: Color(0xFF808080),
                                  fontSize: 16,
                                  fontFamily: 'Satoshi',
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            ],
                          ),
                        ),
                        if (carnets.isEmpty)
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 15.0),
                            child: Center(
                                child: Text(
                              'Brak karnetów.',
                              style: TextStyle(
                                color: CustomColors.hintText,
                                fontSize: 16,
                                fontFamily: 'Satoshi',
                                fontWeight: FontWeight.w500,
                              ),
                            )),
                          )
                        else ...[
                          ..._userCarnetsWithDates(
                              carnets, WidgetCarnetType.active),
                        ],
                        const Padding(
                          padding: EdgeInsets.only(top: 20, left: 8.0),
                          child: Text(
                            'Karnety do opłacenia',
                            style: TextStyle(
                              color: Color(0xFF404040),
                              fontSize: 16,
                              fontFamily: 'Satoshi',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        if (pendingCarnets.isEmpty)
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 15.0),
                            child: Center(
                                child: Text(
                              'Brak karnetów do opłacenia karnetów.',
                              style: TextStyle(
                                color: CustomColors.hintText,
                                fontSize: 16,
                                fontFamily: 'Satoshi',
                                fontWeight: FontWeight.w500,
                              ),
                            )),
                          )
                        else ...[
                          ..._userCarnetsWithDates(
                              pendingCarnets, WidgetCarnetType.pending),
                        ],
                        const Padding(
                          padding: EdgeInsets.only(top: 20, left: 8.0),
                          child: Text(
                            'Wygasłe karnety',
                            style: TextStyle(
                              color: Color(0xFF404040),
                              fontSize: 16,
                              fontFamily: 'Satoshi',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        if (expiredCarnets.isEmpty)
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 15.0),
                            child: Center(
                                child: Text(
                              'Brak wygasłych karnetów.',
                              style: TextStyle(
                                color: CustomColors.hintText,
                                fontSize: 16,
                                fontFamily: 'Satoshi',
                                fontWeight: FontWeight.w500,
                              ),
                            )),
                          )
                        else ...[
                          ..._userCarnetsWithDates(
                              expiredCarnets, WidgetCarnetType.expired),
                        ],
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) =>
                                  const BuyMembershipScreen())),
                      style: CustomButtonStyle.primary,
                      child: const Text('WYKUP NOWY KARNET'),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  List<Widget> _userCarnetsWithDates(
      List<UserCarnet> carnets, WidgetCarnetType type) {
    DateTime? previousDate;
    List<Widget> result = [];

    for (var e in carnets) {
      if (previousDate != null && previousDate.isSameDate(e.dateCreatedUtc) ||
          previousDate == null) {
        result.add(
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 5, bottom: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  DateFormat('dd.MM.yyyy').format(e.dateCreatedUtc),
                  style: const TextStyle(
                    color: CustomColors.hintText,
                    fontSize: 14,
                    fontFamily: 'Satoshi',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Divider(
                  color: CustomColors.hintText,
                  thickness: 0.25,
                  height: 0,
                ),
              ],
            ),
          ),
        );
      }
      result.add(
        Container(
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFE1E1E1)),
              borderRadius: BorderRadius.circular(20),
            ),
            child: switch (type) {
              WidgetCarnetType.expired => UserExpiredCarnet(expiredCarnet: e),
              WidgetCarnetType.pending => UserPendingCarnet(pendingCarnet: e),
              _ => UserCarnetWidget(
                  carnet: e,
                ),
            }),
      );

      previousDate = e.dateCreatedUtc;
    }

    return result;
  }
}
