import 'package:flutter/material.dart';
import 'package:pole_paris_app/bloc/bloc_exports.dart';
import 'package:pole_paris_app/models/class.dart';
import 'package:pole_paris_app/models/user_carnet.dart';
import 'package:pole_paris_app/pages/main_student.dart';
import 'package:pole_paris_app/repositories/user_carnet_repository.dart';
import 'package:pole_paris_app/screens/classes_list.dart';
import 'package:pole_paris_app/screens/confirm.dart';
import 'package:pole_paris_app/screens/teacher/class_details.dart';
import 'package:pole_paris_app/styles/button.dart';
import 'package:pole_paris_app/styles/color.dart';
import 'package:pole_paris_app/utils/membership_helper.dart';
import 'package:pole_paris_app/widgets/base/loader.dart';
import 'package:pole_paris_app/widgets/base/picture_background_app_bar.dart';
import 'package:pole_paris_app/widgets/teacher/class_base_info.dart';

class SignUpForClassScreen extends StatefulWidget {
  final Class classDetails;
  final UserCarnet carnet;
  const SignUpForClassScreen({
    super.key,
    required this.classDetails,
    required this.carnet,
  });

  @override
  State<SignUpForClassScreen> createState() => _SignUpForClassScreenState();
}

class _SignUpForClassScreenState extends State<SignUpForClassScreen> {
  _submit() async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) =>
            const LoadingDialog(text: 'Zapisywanie'));

    await UserCarnetRepository.useCarnet(widget.carnet, widget.classDetails)
        .then((value) {
      _onSuccess();
      return;
    }).onError((error, stackTrace) {
      print(error.toString());
      Navigator.of(context, rootNavigator: true).pop();
    });
  }

  _onSuccess() {
    final rootContext = context;
    Navigator.of(rootContext, rootNavigator: true).pop();

    Navigator.of(rootContext, rootNavigator: true).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) => ConfirmScreen(
          icon: Icons.celebration_rounded,
          title: 'Gratulacje!',
          text: 'Zapisano pomyślnie :)',
          widgets: [
            ElevatedButton(
              style: CustomButtonStyle.primary,
              onPressed: () {
                context.read<CarnetsBloc>().add(GetAllCarnets());
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const MainPageStudent(),
                ));

                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ClassesListScreen(),
                  ),
                );
              },
              child: const Text('TWOJE ZAJĘCIA'),
            ),
            ElevatedButton(
              style: CustomButtonStyle.secondary,
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MainPageStudent(),
                  ),
                );
              },
              child: const Text('KONTYNUUJ ZAPISY'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final classDetails = widget.classDetails;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PictureBackgroundAppBar(
        title: 'Zapisujesz się na',
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
                flex: 5,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 35),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: const Color(0xFFE1E1E1),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 8.0,
                                  bottom: 8.0,
                                  left: 20,
                                ),
                                child:
                                    ClassBaseInfo(classDetails: classDetails),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, top: 15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(right: 5.0),
                                        child: Icon(
                                          Icons.group_outlined,
                                          color: CustomColors.inputText,
                                        ),
                                      ),
                                      Text(
                                        '${classDetails.places} miejsc',
                                        style: const TextStyle(
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
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10),
                              child: Text(
                                'Korzystasz z karnetu',
                                style: TextStyle(
                                  color: Color(0xFF1A1A1A),
                                  fontSize: 16,
                                  fontFamily: 'Satoshi',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      width: 0.50, color: Color(0xFFE1E1E1)),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.carnet.membership.name,
                                      style: const TextStyle(
                                        color: Color(0xFFEE90E4),
                                        fontSize: 16,
                                        fontFamily: 'Satoshi',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      MembershipHelper.carnetEntriesText(
                                          widget.carnet),
                                      style: const TextStyle(
                                        color: Color(0xFF404040),
                                        fontSize: 14,
                                        fontFamily: 'Satoshi',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: _submit,
                              style: CustomButtonStyle.primary,
                              child: const Text('ZAPISZ SIĘ'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
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
