import 'package:flutter/material.dart';
import 'package:pole_paris_app/screens/student/about.dart';
import 'package:pole_paris_app/styles/button.dart';
import 'package:pole_paris_app/styles/color.dart';
import 'package:pole_paris_app/widgets/base/app_bar.dart';
import 'package:pole_paris_app/widgets/base/logo.dart';

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.2733123, size.height * 0.1177104);
    path_0.cubicTo(
        size.width * 0.2981306,
        size.height * 0.1177104,
        size.width * 0.3200323,
        size.height * 0.1021801,
        size.width * 0.3354065,
        size.height * 0.08184411);
    path_0.cubicTo(size.width * 0.3728742, size.height * 0.03228306,
        size.width * 0.4340806, 0, size.width * 0.5032258, 0);
    path_0.cubicTo(
        size.width * 0.5723710,
        0,
        size.width * 0.6335774,
        size.height * 0.03228306,
        size.width * 0.6710452,
        size.height * 0.08184411);
    path_0.cubicTo(
        size.width * 0.6864194,
        size.height * 0.1021801,
        size.width * 0.7083226,
        size.height * 0.1177104,
        size.width * 0.7331387,
        size.height * 0.1177104);
    path_0.lineTo(size.width * 0.9354839, size.height * 0.1177104);
    path_0.cubicTo(size.width * 0.9711161, size.height * 0.1177104, size.width,
        size.height * 0.1478596, size.width, size.height * 0.1850505);
    path_0.lineTo(size.width, size.height * 0.9326599);
    path_0.cubicTo(size.width, size.height * 0.9698519, size.width * 0.9711161,
        size.height, size.width * 0.9354839, size.height);
    path_0.lineTo(size.width * 0.06451613, size.height);
    path_0.cubicTo(size.width * 0.02888484, size.height, 0,
        size.height * 0.9698519, 0, size.height * 0.9326599);
    path_0.lineTo(0, size.height * 0.1850505);
    path_0.cubicTo(
        0,
        size.height * 0.1478596,
        size.width * 0.02888487,
        size.height * 0.1177104,
        size.width * 0.06451613,
        size.height * 0.1177104);
    path_0.lineTo(size.width * 0.2733123, size.height * 0.1177104);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = Colors.white.withOpacity(1.0);
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(title: 'Kontakt', appBar: AppBar()),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 20,
            left: 15,
            right: 15,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 350,
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          colorFilter: ColorFilter.mode(
                            Colors.grey,
                            BlendMode.saturation,
                          ),
                          image: AssetImage(
                            'assets/img/contact-background.jpg',
                          ),
                          fit: BoxFit.fitWidth,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(left: 20.0, bottom: 100),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 10.0),
                              child: Text(
                                'Masz kłopot?',
                                style: TextStyle(
                                  color: CustomColors.text2,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Text(
                              'Napisz lub zadzwoń!',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'Odpowiemy na każde pytanie.',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 200,
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width - 30,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: CustomPaint(
                          painter: RPSCustomPainter(),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child: Logo(
                                  width: 100,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.0),
                                child: FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 8.0),
                                        child: Text(
                                          'Adres',
                                          style: TextStyle(
                                            color: CustomColors.inputText,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.place_outlined,
                                            color: CustomColors.hintText,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 8.0),
                                            child: Text(
                                              'Świdnik, Al. Lotników Polskich 56',
                                              style: TextStyle(
                                                color: CustomColors.hintText,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 10, bottom: 8.0),
                                        child: Text(
                                          'Dane kontaktowe',
                                          style: TextStyle(
                                            color: CustomColors.inputText,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.mail_outline,
                                            color: CustomColors.hintText,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 8.0),
                                            child: Text(
                                              'studiopoleparis@gmail.com',
                                              style: TextStyle(
                                                color: CustomColors.hintText,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 8.0),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.phone_outlined,
                                              color: CustomColors.hintText,
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 8.0),
                                              child: Text(
                                                '+48 111 222 333',
                                                style: TextStyle(
                                                  color: CustomColors.hintText,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
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
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: SizedBox(
                  width: 180,
                  child: ElevatedButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AboutUsScreen())),
                    style: CustomButtonStyle.whiteProfilesWithoutSize,
                    child: const Text('O STUDIO'),
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
