import 'package:image_picker/image_picker.dart';
import 'package:pole_paris_app/models/levels.dart';

class Class {
  final String name;
  final DateTime date;
  final String hourSince;
  final String hourTo;
  final Level level;
  final String description;
  final String teacher;
  late XFile? image;

  Class({
    required this.name,
    required this.date,
    required this.hourSince,
    required this.hourTo,
    required this.level,
    required this.description,
    required this.teacher,
    this.image,
  });
  //late creator;
}
