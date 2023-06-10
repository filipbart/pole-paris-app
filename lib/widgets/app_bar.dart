import 'package:flutter/material.dart';
import 'package:pole_paris_app/styles/color.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final AppBar appBar;
  const BaseAppBar({super.key, required this.title, required this.appBar});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      title: Text(
        title,
        style: const TextStyle(
          color: CustomColors.buttonAdditional,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
      shape: const Border(
        bottom: BorderSide(
          width: 0.4,
          color: Color(0xFF838383),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
