import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pole_paris_app/models/membership.dart';
import 'package:pole_paris_app/models/user.dart';
import 'package:pole_paris_app/models/user_carnet.dart';

const collectionPathParent = 'users';
const collectionPath = 'carnets';

class UserCarnetRepository {
  static Future<UserCarnet> addUserCarnetToAccept({
    required Membership membership,
    required bool paid,
    required User user,
  }) async {
    UserCarnet? result;
    final userId = GetStorage().read('token');

    final carnetsRef = FirebaseFirestore.instance
        .collection(collectionPathParent)
        .doc(userId)
        .collection(collectionPath);

    final existingUnpaid =
        await carnetsRef.where("paid", isEqualTo: false).get();
    if (existingUnpaid.docs.isNotEmpty) {
      throw const FormatException("unpaid-carnet-exists");
    }

    final carnetId = carnetsRef.doc().id;

    final userCarnet = UserCarnet(
      id: carnetId,
      toAccept: true,
      poleEntries: membership.poleEntries ?? 0,
      fitnessEntries: membership.fitnessEntries ?? 0,
      unlimited:
          membership.fitnessEntries == null && membership.poleEntries == null,
      expired: false,
      expirationDate: DateTime.now().add(Duration(days: membership.validDays)),
      membership: membership,
      user: user,
      dateCreatedUtc: DateTime.now().toUtc(),
    );

    await carnetsRef.doc(userCarnet.id).set(userCarnet.toMap()).then((value) {
      result = userCarnet;
    }).onError((error, stackTrace) {
      throw Exception(error.toString());
    });

    if (result == null) {
      throw Exception("Null user carnet");
    }

    return result!;
  }

  static Future<List<UserCarnet>> getCarnetsToAccept() async {
    List<UserCarnet> result = [];

    await FirebaseFirestore.instance
        .collectionGroup(collectionPath)
        .where('toAccept', isEqualTo: true)
        .where('paymentDateUtc', isNull: true)
        .where('expired', isEqualTo: false)
        .get()
        .then((values) {
      for (var carnet in values.docs) {
        final carnetEntity = UserCarnet.fromMap(carnet.data());
        result.add(carnetEntity);
      }
    }, onError: (e) => throw Exception(e.toString()));

    return result;
  }

  static Future<List<UserCarnet>> getAcceptedCarnets() async {
    List<UserCarnet> result = [];

    await FirebaseFirestore.instance
        .collectionGroup(collectionPath)
        .where('toAccept', isEqualTo: true)
        .where('paymentDateUtc', isNull: false)
        .get()
        .then((values) {
      for (var carnet in values.docs) {
        final carnetEntity = UserCarnet.fromMap(carnet.data());
        result.add(carnetEntity);
      }
    }, onError: (e) => throw Exception(e.toString()));

    return result;
  }

  static Future<void> acceptUserCarnet(UserCarnet carnet) async {
    await FirebaseFirestore.instance
        .collection(collectionPathParent)
        .doc(carnet.user.id)
        .collection(collectionPath)
        .doc(carnet.id)
        .update({
      "paymentDateUtc": DateTime.now().toUtc().millisecondsSinceEpoch
    }).onError((error, stackTrace) {
      throw Exception(error);
    });
  }
}
