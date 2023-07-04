import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pole_paris_app/bloc/bloc_exports.dart';
import 'package:pole_paris_app/models/class.dart';
import 'package:pole_paris_app/models/roles.dart';
import 'package:pole_paris_app/styles/button.dart';
import 'package:pole_paris_app/styles/color.dart';
import 'package:pole_paris_app/widgets/base/app_bar.dart';
import 'package:pole_paris_app/widgets/class_item.dart';

class ClassesListScreen extends StatelessWidget {
  const ClassesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        final isTeacher = state.user!.role == Role.teacher;
        return Scaffold(
          appBar: BaseAppBar(
            title: isTeacher ? 'Zajęcia, które prowadzisz' : 'Twoje zajęcia',
            appBar: AppBar(),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 25.0),
                child: BlocBuilder<ClassesBloc, ClassesState>(
                  builder: (context, state) {
                    final classes = state.classes;
                    return Column(
                      children: [
                        if (isTeacher == false)
                          const Padding(
                            padding: EdgeInsets.all(20),
                            child: Text(
                              'Czas wypisania z zajęć to 10 godzin przed zajęciami, w przypadku późniejszego wypisania zajęcia przepadają.',
                              style: TextStyle(
                                color: CustomColors.hintText,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ...titlesWithClassList(classes),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 40,
                            bottom: 10,
                          ),
                          child: Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(bottom: 15.0),
                                child: Text('Nie masz więcej zajęć.'),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    context
                                        .read<TabIndexBloc>()
                                        .add(const ChangeTab(newIndex: 3));
                                  },
                                  style: CustomButtonStyle.primary,
                                  child: Text(isTeacher
                                      ? 'DODAJ NOWE ZAJĘCIA'
                                      : 'ZAPISZ SIĘ NA ZAJĘCIA'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> titlesWithClassList(List<Class> classes) {
    final dates =
        groupBy(classes, (p0) => DateFormat('dd.MM.yyyy').format(p0.date));
    List<Widget> result = [];

    dates.forEach(
      (key, value) => result.add(
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                key,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Divider(
                  color: Color(0xFF838383),
                  height: 20,
                  thickness: 0.5,
                ),
              ),
              ...value
                  .map((classItem) => Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: ClassItem(classItem: classItem),
                      ))
                  .toList(),
            ],
          ),
        ),
      ),
    );

    return result;
  }
}
