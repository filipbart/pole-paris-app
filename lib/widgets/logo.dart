import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final double? width;
  const Logo({
    super.key,
    this.width = 250.0,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/img/logo.png',
      width: width,
      fit: BoxFit.fitWidth,
    );
  }
}
