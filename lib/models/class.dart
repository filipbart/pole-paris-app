// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
import 'package:pole_paris_app/models/base.dart';
import 'package:pole_paris_app/models/levels.dart';
import 'package:pole_paris_app/models/membership.dart';
import 'package:pole_paris_app/models/user.dart';

// ignore: must_be_immutable
class Class extends BaseModel {
  final String name;
  final DateTime date;
  final String hourSince;
  final String hourTo;
  final Level level;
  final int places;
  final String description;
  String picture;
  final User teacher;
  List<Membership>? memberships;
  Class({
    required this.name,
    required this.date,
    required this.hourSince,
    required this.hourTo,
    required this.level,
    required this.places,
    required this.description,
    required this.picture,
    required this.teacher,
    this.memberships,
    required super.id,
    required super.dateCreatedUtc,
  });

  Class copyWith({
    String? name,
    DateTime? date,
    String? hourSince,
    String? hourTo,
    Level? level,
    int? places,
    String? description,
    String? picture,
    User? teacher,
    List<Membership>? memberships,
    DateTime? dateCreatedUtc,
    String? id,
  }) {
    return Class(
      name: name ?? this.name,
      date: date ?? this.date,
      hourSince: hourSince ?? this.hourSince,
      hourTo: hourTo ?? this.hourTo,
      level: level ?? this.level,
      places: places ?? this.places,
      description: description ?? this.description,
      picture: picture ?? this.picture,
      teacher: teacher ?? this.teacher,
      memberships: memberships ?? this.memberships,
      dateCreatedUtc: dateCreatedUtc ?? this.dateCreatedUtc,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'date': date.millisecondsSinceEpoch,
      'hourSince': hourSince,
      'hourTo': hourTo,
      'level': _$LevelEnumMap[level],
      'places': places,
      'description': description,
      'picture': picture,
      'teacher': teacher.toMap(),
      'memberships': memberships?.map((x) => x.toMap()).toList(),
      'dateCreatedUtc': dateCreatedUtc.millisecondsSinceEpoch,
    };
  }

  factory Class.fromMap(Map<String, dynamic> map) {
    return Class(
      id: map['id'] as String,
      name: map['name'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      hourSince: map['hourSince'] as String,
      hourTo: map['hourTo'] as String,
      level: $enumDecode(_$LevelEnumMap, map['level']),
      places: map['places'] as int,
      description: map['description'] as String,
      picture: map['picture'] as String,
      teacher: User.fromMap(map['teacher'] as Map<String, dynamic>),
      memberships: map['memberships'] != null
          ? List<Membership>.from(
              (map['memberships'] as List<dynamic>).map<Membership>(
                (x) => Membership.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      dateCreatedUtc:
          DateTime.fromMillisecondsSinceEpoch(map['dateCreatedUtc'] as int),
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        date,
        hourSince,
        hourTo,
        level,
        places,
        description,
        picture,
        teacher,
        memberships,
      ];
}

const _$LevelEnumMap = {
  Level.primary: 'primary',
  Level.base: 'base',
  Level.intermediate: 'intermediate',
  Level.all: 'all',
};
