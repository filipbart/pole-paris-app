import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pole_paris_app/bloc/bloc_exports.dart';
import 'package:pole_paris_app/models/roles.dart';
import 'package:pole_paris_app/pages/home_unlogged.dart';
import 'package:pole_paris_app/screens/classes_list.dart';
import 'package:pole_paris_app/screens/edit_profile.dart';
import 'package:pole_paris_app/screens/student/carnet_list.dart';
import 'package:pole_paris_app/styles/button.dart';
import 'package:pole_paris_app/styles/color.dart';
import 'package:pole_paris_app/widgets/base/app_bar.dart';
import 'package:pole_paris_app/widgets/circle_avatar.dart';

class ProfileScreen extends StatelessWidget {
  final bool teacher;
  const ProfileScreen({super.key, this.teacher = false});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        final user = state.user!;
        return Scaffold(
          appBar: BaseAppBar(
            title: teacher ? 'Profil instruktora' : 'Profil',
            appBar: AppBar(),
            withDrawer: false,
          ),
          drawer: null,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 25.0,
                              right: 25.0,
                              top: 20.0,
                            ),
                            child: Wrap(
                              children: [
                                Row(
                                  children: [
                                    const UserPicture(radius: 50),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              user.fullName,
                                              textAlign: TextAlign.left,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 24,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            if (user.role == Role.teacher)
                                              const Text(
                                                'instruktor',
                                                style: TextStyle(
                                                  color: CustomColors.text2,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(
                                  color: Color(0xFFCDCDCD),
                                  height: 40,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Wrap(
                                    alignment: WrapAlignment.center,
                                    spacing: 15,
                                    children: [
                                      const Icon(
                                        Icons.mail_outline,
                                        color: CustomColors.hintText,
                                      ),
                                      Text(
                                        user.email,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: CustomColors.hintText,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 8.0,
                                    top: 8.0,
                                    bottom: 25,
                                  ),
                                  child: Wrap(
                                    spacing: 15,
                                    children: [
                                      const Icon(
                                        Icons.phone,
                                        color: CustomColors.hintText,
                                      ),
                                      Text(
                                        user.phoneNumber.replaceAllMapped(
                                            RegExp(
                                                r'(\d{2})(\d{3})(\d{3})(\d{3})'),
                                            (Match m) =>
                                                "${m[1]} ${m[2]} ${m[3]} ${m[4]}"),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: CustomColors.hintText,
                                          fontWeight: FontWeight.w500,
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
                    ),
                    Expanded(
                      flex: 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40.0,
                          vertical: 35,
                        ),
                        child: Wrap(
                          runSpacing: 15,
                          children: [
                            if (teacher)
                              ElevatedButton(
                                onPressed: () {
                                  context
                                      .read<TabIndexBloc>()
                                      .add(const ChangeTab(newIndex: 3));
                                },
                                style: CustomButtonStyle.primary,
                                child: const Text('Dodaj zajęcia'),
                              ),
                            ElevatedButton(
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ClassesListScreen(
                                              forStudent: true))),
                              style: CustomButtonStyle.whiteProfiles,
                              child: const Text('Twoje zajęcia'),
                            ),
                            if (teacher == false)
                              ElevatedButton(
                                onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const CarnetListScreen())),
                                style: CustomButtonStyle.whiteProfiles,
                                child: const Text('Twoje karnety'),
                              ),
                            ElevatedButton(
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          EditProfileScreen(user: user))),
                              style: CustomButtonStyle.whiteProfiles,
                              child: const Text('Edytuj profil'),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              style: CustomButtonStyle.whiteProfiles,
                              child: const Text(
                                'Usuń konto',
                                style: TextStyle(color: CustomColors.error),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
                        child: ElevatedButton(
                          onPressed: () {
                            GetStorage().remove('token');
                            context.read<UserBloc>().close();
                            Navigator.of(context, rootNavigator: true)
                                .pushReplacementNamed(HomeUnloggedPage.id);
                          },
                          style: CustomButtonStyle.secondaryTransparent,
                          child: const Text('WYLOGUJ'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
