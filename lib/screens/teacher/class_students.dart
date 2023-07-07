import 'package:flutter/material.dart';
import 'package:pole_paris_app/models/class.dart';
import 'package:pole_paris_app/models/user.dart';
import 'package:pole_paris_app/styles/button.dart';
import 'package:pole_paris_app/styles/color.dart';
import 'package:pole_paris_app/widgets/base/app_bar.dart';

import 'package:pole_paris_app/widgets/input.dart';
import 'package:pole_paris_app/widgets/teacher/class_base_info.dart';

class ClassStudentsScreen extends StatefulWidget {
  final Class classDetails;
  const ClassStudentsScreen({super.key, required this.classDetails});

  @override
  State<ClassStudentsScreen> createState() => _ClassStudentsScreenState();
}

class _ClassStudentsScreenState extends State<ClassStudentsScreen> {
  late List<User> _filteredList;
  final List<User> students = [];

  final searchController = TextEditingController();

  @override
  void initState() {
    setState(() {
      _filteredList = students;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    precacheImage(
        const AssetImage('assets/img/placeholder-avatar.png'), context);
    return Scaffold(
      appBar: BaseAppBar(
        title: 'Lista kursantów',
        appBar: AppBar(),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15, bottom: 10),
        child: SingleChildScrollView(
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
                  onChanged: (value) {
                    setState(() {
                      if (value != '') {
                        _filteredList = students
                            .where((element) => element.fullName
                                .toLowerCase()
                                .contains(value.toLowerCase()))
                            .toList();
                      } else {
                        _filteredList = students;
                      }
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Container(
                  height: 100,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    border: Border.symmetric(
                      horizontal: BorderSide(
                        color: Color(0xFFE1E1E1),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 30),
                    child: ClassBaseInfo(classDetails: widget.classDetails),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 40.0),
                child: ElevatedButton(
                    onPressed: () {},
                    style: CustomButtonStyle.primary,
                    child: const Text('ZAPISZ KURSANTA')),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [studentInfo(widget.classDetails.teacher)],
                  // .map((student) => studentInfo(student))
                  // .toList(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget studentInfo(User student) => Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Container(
          height: 120,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 40,
                  foregroundImage: student.picture == null
                      ? const AssetImage('assets/img/placeholder-avatar.png')
                      : null,
                  backgroundImage: student.picture == null
                      ? null
                      : NetworkImage(student.picture!),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            student.fullName,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 3.0),
                          child: Divider(
                            height: 1,
                            thickness: 0.5,
                            color: Color(0xFFE1E1E1),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            student.email,
                            style: const TextStyle(
                              color: CustomColors.hintText,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            student.phoneNumber.replaceAllMapped(
                                RegExp(r'(\d{2})(\d{3})(\d{3})(\d{3})'),
                                (Match m) => "${m[1]} ${m[2]} ${m[3]} ${m[4]}"),
                            style: const TextStyle(
                              color: CustomColors.hintText,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 10, top: 8.0),
                          child: Text(
                            'student.membership.description',
                            style: TextStyle(
                              color: CustomColors.inputText,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
