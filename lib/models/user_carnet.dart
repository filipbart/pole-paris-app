// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:pole_paris_app/models/base.dart';
import 'package:pole_paris_app/models/membership.dart';
import 'package:pole_paris_app/models/user.dart';

class UserCarnet extends BaseModel {
  final bool paid;
  final int poleEntries;
  final int fitnessEntries;
  final bool unlimited;
  final bool expired;
  final DateTime expirationDate;
  final Membership membership;
  final User user;
  UserCarnet({
    required super.id,
    required this.paid,
    required this.poleEntries,
    required this.fitnessEntries,
    required this.unlimited,
    required this.expired,
    required this.expirationDate,
    required this.membership,
    required this.user,
    required super.dateCreatedUtc,
  });

  UserCarnet copyWith({
    String? id,
    bool? paid,
    int? poleEntries,
    int? fitnessEntries,
    bool? unlimited,
    bool? expired,
    DateTime? expirationDate,
    Membership? membership,
    User? user,
    DateTime? dateCreatedUtc,
  }) {
    return UserCarnet(
      id: id ?? this.id,
      paid: paid ?? this.paid,
      poleEntries: poleEntries ?? this.poleEntries,
      fitnessEntries: fitnessEntries ?? this.fitnessEntries,
      unlimited: unlimited ?? this.unlimited,
      expired: expired ?? this.expired,
      expirationDate: expirationDate ?? this.expirationDate,
      membership: membership ?? this.membership,
      user: user ?? this.user,
      dateCreatedUtc: dateCreatedUtc ?? this.dateCreatedUtc,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'paid': paid,
      'poleEntries': poleEntries,
      'fitnessEntries': fitnessEntries,
      'unlimited': unlimited,
      'expired': expired,
      'expirationDate': expirationDate.millisecondsSinceEpoch,
      'membership': membership.toMap(),
      'user': user.toMap(),
      'dateCreatedUtc': dateCreatedUtc.millisecondsSinceEpoch,
    };
  }

  factory UserCarnet.fromMap(Map<String, dynamic> map) {
    return UserCarnet(
      id: map['id'] as String,
      paid: map['paid'] as bool,
      poleEntries: map['poleEntries'] as int,
      fitnessEntries: map['fitnessEntries'] as int,
      unlimited: map['unlimited'] as bool,
      expired: map['expired'] as bool,
      expirationDate:
          DateTime.fromMillisecondsSinceEpoch(map['expirationDate'] as int),
      membership: Membership.fromMap(map['membership'] as Map<String, dynamic>),
      user: User.fromMap(map['user'] as Map<String, dynamic>),
      dateCreatedUtc:
          DateTime.fromMillisecondsSinceEpoch(map['dateCreatedUtc'] as int),
    );
  }
}
