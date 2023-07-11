import 'package:flutter/material.dart';
import 'package:pole_paris_app/bloc/bloc_exports.dart';
import 'package:pole_paris_app/models/membership.dart';
import 'package:pole_paris_app/pages/main_student.dart';
import 'package:pole_paris_app/repositories/user_repository.dart';
import 'package:pole_paris_app/screens/confirm.dart';
import 'package:pole_paris_app/screens/failed.dart';
import 'package:pole_paris_app/screens/student/carnet_list.dart';
import 'package:pole_paris_app/styles/button.dart';
import 'package:pole_paris_app/styles/color.dart';
import 'package:pole_paris_app/utils/membership_helper.dart';
import 'package:pole_paris_app/widgets/base/app_bar.dart';
import 'package:pole_paris_app/widgets/base/loader.dart';

class PaymentStationaryScreen extends StatelessWidget {
  final Membership membership;
  const PaymentStationaryScreen({super.key, required this.membership});

  @override
  Widget build(BuildContext context) {
    submit() async {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) =>
              const LoadingDialog(text: 'Przekazywanie informacji do studio'));

      final user = context.read<UserBloc>().state.user;
      final rootContext = context;
      try {
        await UserRepository.addUserCarnet(
                membership: membership, paid: false, user: user!)
            .then((value) {
          context.read<CarnetsBloc>().add(AddNewCarnet(newCarnet: value));
          Navigator.of(context, rootNavigator: true).pop();
          Navigator.of(rootContext, rootNavigator: true).pushReplacement(
            MaterialPageRoute<void>(
              builder: (BuildContext context) => ConfirmScreen(
                icon: Icons.payment_outlined,
                title: 'Udało się!',
                text: 'Zapraszamy do opłacenia karnetu w studio.',
                widgets: [
                  ElevatedButton(
                    style: CustomButtonStyle.primary,
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => const MainPageStudent()),
                      );

                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const CarnetListScreen()));
                    },
                    child: const Text('TWOJE KARNETY'),
                  ),
                  ElevatedButton(
                    style: CustomButtonStyle.secondary,
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true)
                          .pushReplacementNamed(MainPageStudent.id);
                    },
                    child: const Text('STRONA GŁÓWNA'),
                  ),
                ],
              ),
            ),
          );
        });
      } on FormatException catch (_) {
        Navigator.of(context, rootNavigator: true).push(
          MaterialPageRoute(
            builder: (context) => FailedScreen(
              button: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                style: CustomButtonStyle.primary,
                child: const Text('POWRÓT DO PŁATNOŚCI'),
              ),
              title: 'Posiadasz nieopłacony karnet.',
              desc: 'Opłać karnet w studio.',
            ),
          ),
        );
        return;
      } on Exception catch (_) {
        Navigator.of(context, rootNavigator: true).push(
          MaterialPageRoute(
            builder: (context) => FailedScreen(
              button: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                style: CustomButtonStyle.primary,
                child: const Text('POWRÓT DO PŁATNOŚCI'),
              ),
              title: 'Coś poszło nie tak...',
            ),
          ),
        );
        return;
      }
    }

    return Scaffold(
      appBar: BaseAppBar(
        title: 'Płatność w studio',
        appBar: AppBar(),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
                child: Text(
                  'Podsumowanie',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF404040),
                    fontSize: 16,
                    fontFamily: 'Satoshi',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: Container(
                              width: double.infinity,
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      width: 0.50, color: Color(0xFFD9D9D9)),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      membership.name,
                                      style: const TextStyle(
                                        color: Color(0xFFEE90E4),
                                        fontSize: 16,
                                        fontFamily: 'Satoshi',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      MembershipHelper.entriesText(membership),
                                      style: const TextStyle(
                                        color: Color(0xFF404040),
                                        fontSize: 14,
                                        fontFamily: 'Satoshi',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      'Ważny przez ${membership.validDays} dni od dnia zakupu',
                                      style: const TextStyle(
                                        color: Color(0xFF808080),
                                        fontSize: 14,
                                        fontFamily: 'Satoshi',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const Text(
                            'Akceptacja karnetu nastąpi po potwierdzeniu opłaty w studio.',
                            style: TextStyle(
                              color: Color(0xFF404040),
                              fontSize: 20,
                              fontFamily: 'Satoshi',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Divider(
                            color: CustomColors.hintText,
                            thickness: 0.5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Kwota to zapłaty',
                                style: TextStyle(
                                  color: Color(0xFF404040),
                                  fontSize: 16,
                                  fontFamily: 'Satoshi',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${membership.price} PLN',
                                style: const TextStyle(
                                  color: Color(0xFFEE90E4),
                                  fontSize: 20,
                                  fontFamily: 'Satoshi',
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: ElevatedButton(
                              onPressed: submit,
                              style: CustomButtonStyle.primary,
                              child: const Text('POTWIERDŹ'),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
