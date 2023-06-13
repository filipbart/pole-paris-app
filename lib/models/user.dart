import 'package:pole_paris_app/models/membership.dart';

class User {
  final String fullName;
  final String email;
  final String phone;
  final Membership membership;
  late String? picture;

  User({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.membership,
    this.picture,
  });
}
