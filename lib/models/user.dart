// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:json_annotation/json_annotation.dart';
import 'package:pole_paris_app/models/base.dart';
import 'package:pole_paris_app/models/class.dart';
import 'package:pole_paris_app/models/membership.dart';
import 'package:pole_paris_app/models/roles.dart';

//ignore: must_be_immutable
class User extends BaseModel {
  final String fullName;
  final String email;
  final String phoneNumber;
  final Role role;
  String? picture;
  String? description;
  final List<Class>? classes;
  final List<Membership>? memberships;
  User({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.role,
    this.picture,
    this.description,
    this.classes,
    this.memberships,
    required super.id,
    required super.dateCreatedUtc,
  });

  @override
  List<Object?> get props => [
        id,
        dateCreatedUtc,
        fullName,
        email,
        phoneNumber,
        role,
        picture,
        description,
        classes,
        memberships,
      ];

  User copyWith({
    String? fullName,
    String? email,
    String? phoneNumber,
    Role? role,
    String? picture,
    String? description,
    List<Class>? classes,
    List<Membership>? memberships,
    DateTime? dateCreatedUtc,
    String? id,
  }) {
    return User(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
      picture: picture ?? this.picture,
      description: description ?? this.description,
      classes: classes ?? this.classes,
      memberships: memberships ?? this.memberships,
      dateCreatedUtc: dateCreatedUtc ?? this.dateCreatedUtc,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'role': _$RoleEnumMap[role],
      'picture': picture,
      'description': description,
      'classes': classes?.map((x) => x.toMap()).toList(),
      'memberships': memberships?.map((x) => x.toMap()).toList(),
      'dateCreatedUtc': dateCreatedUtc.millisecondsSinceEpoch,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      fullName: map['fullName'] as String,
      email: map['email'] as String,
      phoneNumber: map['phoneNumber'] as String,
      role: $enumDecode(_$RoleEnumMap, map['role']),
      picture: map['picture'] != null ? map['picture'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      classes: map['classes'] != null
          ? List<Class>.from(
              (map['classes'] as List<int>).map<Class>(
                (x) => Class.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      memberships: map['memberships'] != null
          ? List<Membership>.from(
              (map['memberships'] as List<int>).map<Membership>(
                (x) => Membership.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      dateCreatedUtc:
          DateTime.fromMillisecondsSinceEpoch(map['dateCreatedUtc'] as int),
    );
  }

  String get getFirstName {
    RegExp regExp = RegExp(r"([^\s]+)");
    final result = regExp.firstMatch(fullName)?[0] ?? fullName;
    return result;
  }
}

const _$RoleEnumMap = {
  Role.teacher: 'instructor',
  Role.student: 'student',
};
