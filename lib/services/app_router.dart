import 'package:flutter/material.dart';
import 'package:pole_paris_app/pages/home_unlogged.dart';
import 'package:pole_paris_app/pages/main_student.dart';
import 'package:pole_paris_app/pages/main_teacher.dart';
import 'package:pole_paris_app/pages/registration.dart';
import 'package:pole_paris_app/screens/forgot_password.dart';
import 'package:pole_paris_app/screens/login.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case HomeUnloggedPage.id:
        return MaterialPageRoute(
          builder: (_) => const HomeUnloggedPage(),
        );
      case RegistrationPage.id:
        return MaterialPageRoute(
          builder: (_) => const RegistrationPage(),
        );
      case ForgotPasswordScreen.id:
        return MaterialPageRoute(
          builder: (_) => const ForgotPasswordScreen(),
        );
      case LoginScreen.id:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
      case MainPageStudent.id:
        return MaterialPageRoute(
          builder: (_) => const MainPageStudent(),
        );
      case MainPageTeacher.id:
        return MaterialPageRoute(
          builder: (_) => const MainPageTeacher(),
        );
      default:
        return null;
    }
  }
}
