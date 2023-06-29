import 'package:flutter/material.dart';
import 'package:pole_paris_app/models/membership.dart';
import 'package:pole_paris_app/styles/button.dart';
import 'package:pole_paris_app/styles/color.dart';
import 'package:pole_paris_app/widgets/base/app_bar.dart';
import 'package:pole_paris_app/widgets/input.dart';
import 'package:pole_paris_app/widgets/student/carnet.dart';
import 'package:pole_paris_app/widgets/student/expired_carnet.dart';

class CarnetListScreen extends StatefulWidget {
  const CarnetListScreen({super.key});

  @override
  State<CarnetListScreen> createState() => _CarnetListScreenState();
}

class _CarnetListScreenState extends State<CarnetListScreen> {
  List<Membership> memberships = [];
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
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
                      ...memberships
                          .map(
                            (e) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 5.0),
                              child: UserCarnet(membership: e),
                            ),
                          )
                          .toList(),
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
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.0),
                        child: UserExpiredCarnet(
                            membership: MembershipType.singleUse),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: ElevatedButton(
                    onPressed: () {},
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
