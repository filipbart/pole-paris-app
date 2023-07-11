// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
import 'package:pole_paris_app/models/base.dart';
import 'package:pole_paris_app/models/class.dart';
import 'package:pole_paris_app/models/roles.dart';
import 'package:pole_paris_app/models/user_carnet.dart';

//ignore: must_be_immutable
class User extends BaseModel {
  final String fullName;
  final String email;
  final String phoneNumber;
  final Role role;
  String? picture;
  String? description;
  List<Class>? classes;
  List<UserCarnet>? carnets;
  final bool isVerified;
  bool? isAdmin;
  User({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.role,
    this.picture,
    this.description,
    this.classes,
    this.carnets,
    required super.id,
    required super.dateCreatedUtc,
    this.isVerified = false,
    this.isAdmin = false,
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
        carnets,
      ];

  User copyWith({
    String? fullName,
    String? email,
    String? phoneNumber,
    Role? role,
    String? picture,
    String? description,
    List<Class>? classes,
    List<UserCarnet>? carnets,
    DateTime? dateCreatedUtc,
    String? id,
    bool? isVerified,
  }) {
    return User(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
      picture: picture ?? this.picture,
      description: description ?? this.description,
      classes: classes ?? this.classes,
      carnets: carnets ?? this.carnets,
      dateCreatedUtc: dateCreatedUtc ?? this.dateCreatedUtc,
      id: id ?? this.id,
      isVerified: isVerified ?? this.isVerified,
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
      'dateCreatedUtc': dateCreatedUtc.millisecondsSinceEpoch,
      'isVerified': isVerified,
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
      dateCreatedUtc:
          DateTime.fromMillisecondsSinceEpoch(map['dateCreatedUtc'] as int),
      isVerified: map['isVerified'] as bool,
      isAdmin: map['isAdmin'] as bool?,
    );
  }

  String get getFirstName {
    RegExp regExp = RegExp(r"([^\s]+)");
    final result = regExp.firstMatch(fullName)?[0] ?? fullName;
    return result;
  }
}

const _$RoleEnumMap = {
  Role.teacher: 'teacher',
  Role.student: 'student',
};
