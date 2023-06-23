import 'package:flutter/foundation.dart';

class Membership {
  final MembershipType type;
  final DateTime expirationDate;
  final int leftEntries;

  Membership(this.type, this.expirationDate, this.leftEntries);
}

enum MembershipType {
  base,
  singleUse,
  premium,
}

extension MembershipExtension on MembershipType {
  String get name => describeEnum(this);
  String get description {
    switch (this) {
      case MembershipType.singleUse:
        return 'Karnet jednorazowy';
      case MembershipType.premium:
        return 'Karnet premium';
      case MembershipType.base:
      default:
        return 'Karnet podstawowy';
    }
  }
}
