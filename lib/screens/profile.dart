import 'package:flutter/material.dart';
import 'package:pole_paris_app/providers/tab_index.dart';
import 'package:pole_paris_app/screens/classes_list.dart';
import 'package:pole_paris_app/screens/edit_profile.dart';

import 'package:pole_paris_app/styles/button.dart';
import 'package:pole_paris_app/styles/color.dart';
import 'package:pole_paris_app/widgets/app_bar.dart';
import 'package:pole_paris_app/widgets/circle_avatar.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  final bool teacher;
  const ProfileScreen({super.key, this.teacher = false});

  @override
  Widget build(BuildContext context) {
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
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Magdalena Kowalska',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 24,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        if (teacher)
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
                            const Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Wrap(
                                alignment: WrapAlignment.center,
                                spacing: 15,
                                children: [
                                  Icon(
                                    Icons.mail_outline,
                                    color: CustomColors.hintText,
                                  ),
                                  Text(
                                    'magdalena@gmail.com',
                                    style: TextStyle(
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
                                    '+48366638794'.replaceAllMapped(
                                        RegExp(r'(\d{2})(\d{3})(\d{3})(\d{3})'),
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
                              Provider.of<TabIndex>(context, listen: false)
                                  .changeIndex(3);
                            },
                            style: CustomButtonStyle.primary,
                            child: const Text('Dodaj zajęcia'),
                          ),
                        ElevatedButton(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ClassesListScreen(
                                      forStudent: true))),
                          style: CustomButtonStyle.whiteProfiles,
                          child: const Text('Twoje zajęcia'),
                        ),
                        if (teacher == false)
                          ElevatedButton(
                            onPressed: () {},
                            style: CustomButtonStyle.whiteProfiles,
                            child: const Text('Twoje karnety'),
                          ),
                        ElevatedButton(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const EditProfileScreen())),
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
                      onPressed: () {},
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
  }
}
