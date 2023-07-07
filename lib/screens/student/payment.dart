import 'package:flutter/material.dart';
import 'package:pole_paris_app/models/membership.dart';
import 'package:pole_paris_app/widgets/base/app_bar.dart';

class PaymentScreen extends StatelessWidget {
  final Membership membership;
  const PaymentScreen({super.key, required this.membership});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: 'Wykup karnet',
        appBar: AppBar(),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(flex: 2, child: Container()), //TODO
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
