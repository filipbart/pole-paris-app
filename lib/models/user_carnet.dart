// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:pole_paris_app/models/base.dart';
import 'package:pole_paris_app/models/membership.dart';
import 'package:pole_paris_app/models/user.dart';

// ignore: must_be_immutable
class UserCarnet extends BaseModel {
  final int poleEntries;
  final int fitnessEntries;
  final bool unlimited;
  final bool expired;
  final bool toAccept;
  final DateTime expirationDate;
  DateTime? paymentDateUtc;
  final Membership membership;
  final User user;
  UserCarnet({
    required super.id,
    required this.poleEntries,
    required this.fitnessEntries,
    required this.unlimited,
    required this.expired,
    required this.toAccept,
    this.paymentDateUtc,
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
    bool? toAccept,
    DateTime? expirationDate,
    DateTime? paymentDateUtc,
    Membership? membership,
    User? user,
    DateTime? dateCreatedUtc,
  }) {
    return UserCarnet(
      id: id ?? this.id,
      poleEntries: poleEntries ?? this.poleEntries,
      fitnessEntries: fitnessEntries ?? this.fitnessEntries,
      unlimited: unlimited ?? this.unlimited,
      expired: expired ?? this.expired,
      toAccept: toAccept ?? this.toAccept,
      expirationDate: expirationDate ?? this.expirationDate,
      paymentDateUtc: paymentDateUtc ?? this.paymentDateUtc,
      membership: membership ?? this.membership,
      user: user ?? this.user,
      dateCreatedUtc: dateCreatedUtc ?? this.dateCreatedUtc,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'poleEntries': poleEntries,
      'fitnessEntries': fitnessEntries,
      'unlimited': unlimited,
      'expired': expired,
      'toAccept': toAccept,
      'expirationDate': expirationDate.millisecondsSinceEpoch,
      'paymentDateUtc': paymentDateUtc?.millisecondsSinceEpoch,
      'membership': membership.toMap(),
      'user': user.toMap(),
      'dateCreatedUtc': dateCreatedUtc.millisecondsSinceEpoch,
    };
  }

  factory UserCarnet.fromMap(Map<String, dynamic> map) {
    return UserCarnet(
      id: map['id'] as String,
      poleEntries: map['poleEntries'] as int,
      fitnessEntries: map['fitnessEntries'] as int,
      unlimited: map['unlimited'] as bool,
      expired: map['expired'] as bool,
      toAccept: map['toAccept'] as bool,
      expirationDate:
          DateTime.fromMillisecondsSinceEpoch(map['expirationDate'] as int),
      paymentDateUtc: map['paymentDateUtc'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['paymentDateUtc'] as int)
          : null,
      membership: Membership.fromMap(map['membership'] as Map<String, dynamic>),
      user: User.fromMap(map['user'] as Map<String, dynamic>),
      dateCreatedUtc:
          DateTime.fromMillisecondsSinceEpoch(map['dateCreatedUtc'] as int),
    );
  }
}
