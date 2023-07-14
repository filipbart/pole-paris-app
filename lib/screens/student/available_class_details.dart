import 'package:flutter/material.dart';
import 'package:pole_paris_app/bloc/bloc_exports.dart';
import 'package:pole_paris_app/models/class.dart';
import 'package:pole_paris_app/models/membership.dart';
import 'package:pole_paris_app/models/user_carnet.dart';
import 'package:pole_paris_app/screens/student/buy_carnet.dart';
import 'package:pole_paris_app/screens/student/sign_up_for_class.dart';
import 'package:pole_paris_app/screens/teacher/class_details.dart';
import 'package:pole_paris_app/styles/button.dart';
import 'package:pole_paris_app/styles/color.dart';
import 'package:pole_paris_app/widgets/base/picture_background_app_bar.dart';
import 'package:pole_paris_app/widgets/student/carnet.dart';
import 'package:pole_paris_app/widgets/teacher/class_base_info.dart';

class AvailableClassDetails extends StatefulWidget {
  final Class classDetails;
  const AvailableClassDetails({super.key, required this.classDetails});

  @override
  State<AvailableClassDetails> createState() => _AvailableClassDetailsState();
}

class _AvailableClassDetailsState extends State<AvailableClassDetails> {
  _chooseCarnet() {
    showModalBottomSheet<UserCarnet>(
      context: context,
      builder: (context) => BlocBuilder<CarnetsBloc, CarnetsState>(
        builder: (context, state) {
          final carnets = state.userCarnets
            ..where((element) =>
                element.expired == false &&
                (element.unlimited || widget.classDetails.type == ClassType.pole
                    ? (element.membership.type == MembershipType.all ||
                            element.membership.type == MembershipType.pole) &&
                        element.poleEntries > 0
                    : (element.membership.type == MembershipType.all &&
                            element.fitnessEntries > 0) ||
                        element.membership.type ==
                            MembershipType.stretchFitness));
          return Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height *
                (carnets.isNotEmpty ? 0.7 : 0.3),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Center(
                    child: Container(
                      width: 62,
                      height: 4,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFC4C4C4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.50),
                        ),
                      ),
                    ),
                  ),
                ),
                if (carnets.isNotEmpty)
                  Expanded(
                    child: Column(
                      children: [
                        const Padding(
                          padding:
                              EdgeInsets.only(top: 15.0, left: 20, bottom: 10),
                          child: Text(
                            'Wybierz karnet',
                            style: TextStyle(
                              color: Color(0xFF404040),
                              fontSize: 16,
                              fontFamily: 'Satoshi',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: ListView.builder(
                                itemCount: carnets.length,
                                itemBuilder: (context, index) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: const Color(0xFFE1E1E1),
                                        )),
                                    child: UserCarnetWidget(
                                      carnet: carnets[index],
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(carnets[index]);
                                      },
                                    ),
                                  ),
                                ),
                              )),
                        ),
                      ],
                    ),
                  )
                else
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Niestety nie posiadasz jeszcze aktywnych karnetów.',
                          style: TextStyle(
                            color: Color(0xFF404040),
                            fontSize: 22,
                            fontFamily: 'Satoshi',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Text(
                          'Wykup karnet, aby skorzystać z zajęć.',
                          style: TextStyle(
                            color: CustomColors.hintText,
                            fontSize: 16,
                            fontFamily: 'Satoshi',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: ElevatedButton(
                            onPressed: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const BuyMembershipScreen())),
                            style: CustomButtonStyle.primary,
                            child: const Text('WYKUP KARNET TUTAJ'),
                          ),
                        )
                      ],
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    ).then((value) {
      UserCarnet? result = value;
      if (result != null) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SignUpForClassScreen(
                classDetails: widget.classDetails, carnet: result)));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final classDetails = widget.classDetails;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PictureBackgroundAppBar(
        title: 'Szczegóły zajęć',
        appBar: AppBar(),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img/available_background.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.grey,
              BlendMode.saturation,
            ),
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Flexible(flex: 1, child: Container()),
              Flexible(
                flex: 6,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 35),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Container(
                              height: 90,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: const Color(0xFFE1E1E1),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8.0,
                                  horizontal: 20,
                                ),
                                child: ClassBaseInfo(
                                    classDetails: widget.classDetails),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, top: 15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(right: 5.0),
                                        child: Icon(
                                          Icons.group_outlined,
                                          color: CustomColors.inputText,
                                        ),
                                      ),
                                      Text(
                                        '10 miejsc',
                                        style: TextStyle(
                                          color: Color(0xFF404040),
                                          fontFamily: 'Satoshi',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(right: 5.0),
                                        child: Icon(
                                          Icons.person_2_outlined,
                                          color: CustomColors.inputText,
                                        ),
                                      ),
                                      Text(
                                        classDetails.teacher.fullName,
                                        style: dataStyle,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(right: 5.0),
                                        child: Icon(
                                          Icons.place_outlined,
                                          color: CustomColors.inputText,
                                        ),
                                      ),
                                      Text(
                                        classDetails.name
                                                .toLowerCase()
                                                .contains("pole")
                                            ? 'Pole Room'
                                            : 'Stretching & Fitness Room',
                                        style: dataStyle,
                                      ),
                                    ],
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 10.0),
                                    child: Text(
                                      'Opis zajęć',
                                      style: TextStyle(
                                        color: Color(0xFF1A1A1A),
                                        fontSize: 16,
                                        fontFamily: 'Satoshi',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 90,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Text(
                                        classDetails.description,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Divider(
                                    color: Color(0xFFABABAB),
                                    thickness: 0.5,
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(bottom: 10.0),
                              child: Center(
                                child: Text(
                                  'Aby skorzystać z zajęć',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: CustomColors.hintText,
                                    fontSize: 16,
                                    fontFamily: 'Satoshi',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: _chooseCarnet,
                              style: CustomButtonStyle.primary,
                              child: const Text('WYBIERZ KARNET'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: ElevatedButton(
                                onPressed: () => Navigator.of(context).pop(),
                                style: CustomButtonStyle.secondary,
                                child: const Text('ANULUJ'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
