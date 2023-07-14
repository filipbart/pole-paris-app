// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
import 'package:pole_paris_app/models/base.dart';
import 'package:pole_paris_app/models/levels.dart';
import 'package:pole_paris_app/models/user.dart';
import 'package:pole_paris_app/models/user_carnet.dart';

// ignore: must_be_immutable
class Class extends BaseModel {
  final String name;
  final ClassType type;
  final DateTime date;
  final String hourSince;
  final String hourTo;
  final Level level;
  final int places;
  final String description;
  String picture;
  final User teacher;
  List<UserCarnet> carnets;
  Class({
    required this.name,
    required this.type,
    required this.date,
    required this.hourSince,
    required this.hourTo,
    required this.level,
    required this.places,
    required this.description,
    required this.picture,
    required this.teacher,
    this.carnets = const <UserCarnet>[],
    required super.id,
    required super.dateCreatedUtc,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'type': _$ClassTypeEnumMap[type],
      'date': date.millisecondsSinceEpoch,
      'hourSince': hourSince,
      'hourTo': hourTo,
      'level': _$LevelEnumMap[level],
      'places': places,
      'description': description,
      'picture': picture,
      'teacher': teacher.toMap(),
      'dateCreatedUtc': dateCreatedUtc.millisecondsSinceEpoch,
      'dateDeletecUtc': null,
    };
  }

  factory Class.fromMap(Map<String, dynamic> map) {
    return Class(
      id: map['id'] as String,
      name: map['name'] as String,
      type: $enumDecode(_$ClassTypeEnumMap, map['type']),
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      hourSince: map['hourSince'] as String,
      hourTo: map['hourTo'] as String,
      level: $enumDecode(_$LevelEnumMap, map['level']),
      places: map['places'] as int,
      description: map['description'] as String,
      picture: map['picture'] as String,
      teacher: User.fromMap(map['teacher'] as Map<String, dynamic>),
      dateCreatedUtc:
          DateTime.fromMillisecondsSinceEpoch(map['dateCreatedUtc'] as int),
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        type,
        date,
        hourSince,
        hourTo,
        level,
        places,
        description,
        picture,
        teacher,
        carnets,
      ];
}

const _$LevelEnumMap = {
  Level.primary: 'primary',
  Level.base: 'base',
  Level.intermediate: 'intermediate',
  Level.all: 'all',
};
const _$ClassTypeEnumMap = {
  ClassType.fitnessStretching: 'fitnessStretching',
  ClassType.pole: 'pole'
};

enum ClassType {
  @JsonValue("pole")
  pole,
  @JsonValue("fitnessStretching")
  fitnessStretching
}
