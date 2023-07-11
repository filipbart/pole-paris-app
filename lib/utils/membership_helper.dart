import 'package:pole_paris_app/models/membership.dart';

class MembershipHelper {
  static String entriesText(Membership membership) {
    if (membership.poleEntries != null && membership.fitnessEntries != null) {
      return "${membership.poleEntries} ${membership.poleEntries! < 5 ? 'wejścia' : 'wejść'} pole dance oraz ${membership.fitnessEntries} ${membership.fitnessEntries! < 5 ? 'wejścia' : 'wejść'} s+f";
    } else if (membership.poleEntries == null &&
        membership.fitnessEntries == null) {
      return 'Nielimitowane wejścia';
    } else if (membership.fitnessEntries == 0) {
      return 'Jedno wejście dziennie';
    } else {
      var entries = membership.poleEntries ?? membership.fitnessEntries;
      switch (entries!) {
        case > 4:
          return '$entries wejść';
        case > 1:
          return '$entries wejścia';
        default:
          return '$entries wejście';
      }
    }
  }
}
