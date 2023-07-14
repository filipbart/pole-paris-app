import 'package:pole_paris_app/models/membership.dart';
import 'package:pole_paris_app/models/user_carnet.dart';

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
        case 0:
          return '0 wejść';
        case > 4:
          return '$entries wejść';
        case > 1:
          return '$entries wejścia';
        default:
          return '$entries wejście';
      }
    }
  }

  static String carnetEntriesText(UserCarnet carnet) {
    if (carnet.unlimited) {
      return 'Nielimitowane wejścia';
    }

    if (carnet.membership.type == MembershipType.stretchFitness &&
        carnet.fitnessEntries == 0) {
      return 'Jedno wejście dziennie';
    }

    if (carnet.membership.type == MembershipType.all) {
      return '${entries(carnet.poleEntries)} pole dance oraz ${entries(carnet.fitnessEntries)} s+f';
    } else {
      return entries(carnet.poleEntries);
    }
  }

  static String entries(int entries) {
    switch (entries) {
      case 0:
        return '0 wejść';
      case > 4:
        return '$entries wejść';
      case > 1:
        return '$entries wejścia';
      default:
        return '$entries wejście';
    }
  }
}
