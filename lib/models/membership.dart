import 'package:flutter/foundation.dart';

enum Membership {
  base,
  singleUse,
  premium,
}

extension MembershipExtension on Membership {
  String get name => describeEnum(this);
  String get description {
    switch (this) {
      case Membership.singleUse:
        return 'Karnet jednorazowy';
      case Membership.premium:
        return 'Karnet premium';
      case Membership.base:
      default:
        return 'Karnet podstawowy';
    }
  }
}
