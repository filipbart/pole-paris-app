// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:pole_paris_app/models/membership.dart';
import 'package:pole_paris_app/screens/student/buy_carnet.dart';
import 'package:pole_paris_app/screens/student/payment_type/payment_stationary.dart';
import 'package:pole_paris_app/styles/button.dart';
import 'package:pole_paris_app/styles/color.dart';
import 'package:pole_paris_app/widgets/base/app_bar.dart';

enum PaymentType {
  card,
  blik,
  applePay,
  googlePay,
  stationary,
}

class PaymentOption {
  final String name;
  final PaymentType type;
  final Widget logos;
  PaymentOption({
    required this.name,
    required this.type,
    required this.logos,
  });
}

class PaymentScreen extends StatefulWidget {
  final Membership membership;
  const PaymentScreen({super.key, required this.membership});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  PaymentType? _selectedPayment = PaymentType.card;

  List<PaymentOption> paymentOptions = [
    PaymentOption(
      name: 'Płatność kartą',
      type: PaymentType.card,
      logos: Wrap(
        spacing: 10,
        direction: Axis.horizontal,
        children: [
          Image.asset(
            'assets/img/payments/master_card.png',
            height: 18,
          ),
          Image.asset(
            'assets/img/payments/visa.png',
            height: 18,
            isAntiAlias: true,
          ),
        ],
      ),
    ),
    PaymentOption(
      name: 'Płatność BLIK',
      type: PaymentType.blik,
      logos: Image.asset(
        'assets/img/payments/blik.png',
        height: 22,
      ),
    ),
    PaymentOption(
      name: 'Apple Pay',
      type: PaymentType.applePay,
      logos: Image.asset(
        'assets/img/payments/apple_pay.png',
        height: 25,
      ),
    ),
    PaymentOption(
      name: 'Google Pay',
      type: PaymentType.googlePay,
      logos: Image.asset(
        'assets/img/payments/google_pay.png',
        height: 25,
      ),
    ),
    PaymentOption(
        name: 'Płatność w studio',
        type: PaymentType.stationary,
        logos: const Wrap(
          spacing: 5,
          children: [
            Icon(Icons.credit_card_outlined),
            Icon(Icons.payments_outlined),
          ],
        )),
  ];

  @override
  Widget build(BuildContext context) {
    precacheImage(
        const AssetImage('assets/img/payments/master_card.png'), context);
    precacheImage(const AssetImage('assets/img/payments/visa.png'), context);
    precacheImage(const AssetImage('assets/img/payments/blik.png'), context);
    precacheImage(
        const AssetImage('assets/img/payments/apple_pay.png'), context);
    return Scaffold(
      appBar: BaseAppBar(
        title: 'Płatność',
        appBar: AppBar(),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Wybrany karnet',
                          style: TextStyle(
                            color: Color(0xFF404040),
                            fontSize: 16,
                            fontFamily: 'Satoshi',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
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
                                  widget.membership.name,
                                  style: const TextStyle(
                                    color: Color(0xFFEE90E4),
                                    fontSize: 16,
                                    fontFamily: 'Satoshi',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  entriesText(widget.membership),
                                  style: const TextStyle(
                                    color: Color(0xFF404040),
                                    fontSize: 14,
                                    fontFamily: 'Satoshi',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  'Ważny przez ${widget.membership.validDays} dni od dnia zakupu',
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
                    ],
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 3,
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Wybierz rodzaj płatności',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF404040),
                                fontSize: 16,
                                fontFamily: 'Satoshi',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            ...paymentOptions
                                .map((e) => _buildPaymentOptionTile(e)),
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
                                  '${widget.membership.price} PLN',
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
                                onPressed: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    switch (_selectedPayment) {
                                      default:
                                        //case PaymentType.stationary:
                                        return PaymentStationaryScreen(
                                            membership: widget.membership);
                                      //return Placeholder();
                                    }
                                  }));
                                },
                                style: CustomButtonStyle.primary,
                                child: const Text('DALEJ'),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOptionTile(PaymentOption paymentOption) => ListTile(
        contentPadding: EdgeInsets.zero,
        onTap: () {
          setState(() {
            _selectedPayment = paymentOption.type;
          });
        },
        title: Text(
          paymentOption.name,
          style: TextStyle(
            color: const Color(0xFF404040),
            fontSize: 16,
            fontFamily: 'Satoshi',
            fontWeight: _selectedPayment == paymentOption.type
                ? FontWeight.bold
                : FontWeight.w500,
          ),
        ),
        leading: Radio(
          fillColor: const MaterialStatePropertyAll<Color>(CustomColors.text2),
          activeColor: CustomColors.text2,
          value: paymentOption.type,
          groupValue: _selectedPayment,
          onChanged: (value) {
            setState(() {
              _selectedPayment = value;
            });
          },
        ),
        trailing: paymentOption.logos,
      );
}
