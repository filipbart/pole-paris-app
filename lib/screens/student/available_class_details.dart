import 'package:flutter/material.dart';
import 'package:pole_paris_app/models/class.dart';
import 'package:pole_paris_app/models/membership.dart';
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
  List<Membership> memberships = [
    Membership(
        MembershipType.premium, DateTime.now().add(const Duration(days: 3)), 4),
    Membership(
        MembershipType.premium, DateTime.now().add(const Duration(days: 3)), 4),
    Membership(
        MembershipType.premium, DateTime.now().add(const Duration(days: 3)), 4),
    Membership(
        MembershipType.premium, DateTime.now().add(const Duration(days: 3)), 4),
    Membership(
        MembershipType.premium, DateTime.now().add(const Duration(days: 3)), 4),
  ];

  _chooseCarnet() {
    showModalBottomSheet<Membership>(
      context: context,
      builder: (context) => Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.7,
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
            const Padding(
              padding: EdgeInsets.only(top: 15.0, left: 20, bottom: 10),
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
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: memberships.isNotEmpty
                    ? ListView.builder(
                        itemCount: memberships.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: const Color(0xFFE1E1E1),
                                )),
                            child: UserCarnet(
                              membership: memberships[index],
                              onPressed: () {
                                Navigator.of(context).pop(memberships[index]);
                              },
                            ),
                          ),
                        ),
                      )
                    : const Center(
                        child: Text(
                          'Brak dostępnych karnetów',
                          style: TextStyle(
                            color: CustomColors.hintText,
                            fontSize: 16,
                            fontFamily: 'Satoshi',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    ).then((value) {
      Membership? result = value;
      if (result != null) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SignUpForClassScreen(
                classDetails: widget.classDetails, membership: result)));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
                flex: 8,
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
                                  left: 30,
                                  right: 30,
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
                                        'Anna Kowalska',
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
                                        'Świdnik',
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
                                  const SizedBox(
                                    height: 100,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Text(
                                        '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc congue gravida augue, a sagittis quam dapibus in. Morbi sodales consequat tempor. Nulla nec nisi in metus vehicula condimentum. Cras pretium ex arcu, bibendum efficitur lectus dignissim congue. In sit amet orci ac neque maximus suscipit. Mauris tempus nisi ante, ac eleifend libero aliquet non. Morbi ligula nisl, posuere vitae malesuada quis, rutrum non nisl. Donec dapibus ex velit. Suspendisse suscipit aliquam consequat. Duis vulputate ligula enim, in auctor metus feugiat a. Phasellus sit amet nulla id felis vulputate porta id a nisl. Praesent aliquam vestibulum viverra. In dapibus enim quis tellus aliquam, eget gravida lorem consequat.''',
                                        style: TextStyle(
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
                                  const Center(
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
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: _chooseCarnet,
                                style: CustomButtonStyle.primary,
                                child: const Text('WYBIERZ KARNET'),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: CustomButtonStyle.secondary,
                                  child: const Text('ANULUJ'),
                                ),
                              ),
                            ],
                          ),
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
