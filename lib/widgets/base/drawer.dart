import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pole_paris_app/pages/home_unlogged.dart';
import 'package:pole_paris_app/styles/button.dart';
import 'package:pole_paris_app/styles/color.dart';
import 'package:pole_paris_app/widgets/circle_avatar.dart';

class DrawerListTileItem {
  final String title;
  final Function()? onTap;

  DrawerListTileItem(this.title, this.onTap);
}

class BaseDrawer extends StatelessWidget {
  final bool? teacher;
  final List<DrawerListTileItem> drawerListTileItems;
  const BaseDrawer({
    super.key,
    this.teacher = false,
    required this.drawerListTileItems,
  });

  static TextStyle titleStyle = const TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontFamily: 'Satoshi',
    fontWeight: FontWeight.w500,
  );

  @override
  Widget build(BuildContext context) {
    return Drawer(
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 25,
            left: 30.0,
            right: 30.0,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFFD6D6D6),
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const UserPicture(radius: 30),
                      FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Wrap(
                          direction: Axis.vertical,
                          children: [
                            const Text(
                              'Magdalena Kowalska',
                              style: TextStyle(
                                fontFamily: 'Satoshi',
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Text(
                              'magdalena@gmail.com',
                              style: TextStyle(
                                fontFamily: 'Satoshi',
                                color: CustomColors.hintText,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            if (teacher ?? false)
                              const Text(
                                'instruktor',
                                style: TextStyle(
                                  fontFamily: 'Satoshi',
                                  color: CustomColors.text2,
                                  fontSize: 14,
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
              Expanded(
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: drawerListTileItems
                      .map(
                        (e) => Container(
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                            color: Color(0xFFD6D6D6),
                            width: 1,
                          ))),
                          child: ListTile(
                            title: Text(e.title),
                            titleTextStyle: titleStyle,
                            splashColor: CustomColors.text2,
                            onTap: e.onTap,
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: ElevatedButton(
                    onPressed: () {
                      GetStorage().remove('token');
                      Navigator.of(context, rootNavigator: true)
                          .pushReplacementNamed(HomeUnloggedPage.id);
                    },
                    style: CustomButtonStyle.secondaryWithoutSize,
                    child: const Text('WYLOGUJ'),
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
