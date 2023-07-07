import 'package:flutter/material.dart';
import 'package:pole_paris_app/models/user_carnet.dart';
import 'package:pole_paris_app/screens/student/buy_carnet.dart';
import 'package:pole_paris_app/styles/button.dart';
import 'package:pole_paris_app/styles/color.dart';
import 'package:pole_paris_app/widgets/base/app_bar.dart';
import 'package:pole_paris_app/widgets/input.dart';
import 'package:pole_paris_app/widgets/student/carnet.dart';

class CarnetListScreen extends StatefulWidget {
  const CarnetListScreen({super.key});

  @override
  State<CarnetListScreen> createState() => _CarnetListScreenState();
}

class _CarnetListScreenState extends State<CarnetListScreen> {
  List<UserCarnet> carnets = [];
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: 'Twoje karnety',
        appBar: AppBar(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                  ),
                  child: Input(
                    controller: searchController,
                    hint: 'Szukaj ...',
                    suffixIcon: const Icon(
                      Icons.search_outlined,
                      color: CustomColors.hintText,
                      size: 30,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20, horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Aktywne karnety',
                          style: TextStyle(
                            color: Color(0xFF404040),
                            fontSize: 16,
                            fontFamily: 'Satoshi',
                            fontWeight: FontWeight.w700,
                          ),
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
                        ...carnets
                            .map(
                              (e) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                child: UserCarnetWidget(carnet: e),
                              ),
                            )
                            .toList(),
                      ],
                      const Padding(
                        padding:
                            EdgeInsets.only(top: 10, left: 8.0, bottom: 10),
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
                      if (carnets.isEmpty)
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
                      else
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                          // child: UserExpiredCarnet(
                          //     membership: MembershipType.singleUse),
                        ),
                      const Padding(
                        padding:
                            EdgeInsets.only(top: 10, left: 8.0, bottom: 10),
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
                      if (carnets.isEmpty)
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
                      else
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                          // child: UserExpiredCarnet(
                          //     membership: MembershipType.singleUse),
                        ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const BuyMembershipScreen())),
                    style: CustomButtonStyle.primary,
                    child: const Text('WYKUP NOWY KARNET'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
