import 'package:flutter/material.dart';

class PictureBackgroundAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final AppBar appBar;
  final bool withDrawer;
  const PictureBackgroundAppBar({
    super.key,
    required this.title,
    required this.appBar,
    this.withDrawer = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      foregroundColor: Colors.white,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      leading: !withDrawer ? Container() : null,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
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
