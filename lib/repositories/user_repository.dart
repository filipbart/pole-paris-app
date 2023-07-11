import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pole_paris_app/models/membership.dart';
import 'package:pole_paris_app/models/user.dart';
import 'package:pole_paris_app/models/user_carnet.dart';

const collectionPath = 'users';

class UserRepository {
  static Future<void> create(User newUser) async {
    try {
      await FirebaseFirestore.instance
          .collection(collectionPath)
          .doc(newUser.id)
          .set(newUser.toMap());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<User?> getMe() async {
    User? result;
    await FirebaseFirestore.instance
        .collection(collectionPath)
        .doc(GetStorage().read('token'))
        .get()
        .then((DocumentSnapshot doc) {
      final data = doc.data() as Map<String, dynamic>?;
      if (data == null) {
        return null;
      }

      result = User.fromMap(data);
    }, onError: (e) => throw Exception(e.toString()));

    return result;
  }

  static Future<List<UserCarnet>?> getUserCarnets() async {
    List<UserCarnet> result = [];
    final userId = GetStorage().read('token');

    if (userId == null || userId == '') {
      return result;
    }

    await FirebaseFirestore.instance
        .collection(collectionPath)
        .doc(userId)
        .collection('carnets')
        .get()
        .then((values) {
      for (var carnet in values.docs) {
        final carnetEntity = UserCarnet.fromMap(carnet.data());
        result.add(carnetEntity);
      }
    }, onError: (e) => throw Exception(e.toString()));

    return result;
  }

  static Future<void> update({
    required String fullName,
    required String email,
    required String phoneNumber,
    String? pictureUrl,
  }) async {
    await FirebaseFirestore.instance
        .collection(collectionPath)
        .doc(GetStorage().read('token'))
        .update({
      "fullName": fullName,
      "email": email,
      "phoneNumber": phoneNumber,
      "picture": pictureUrl,
    }).onError((error, stackTrace) {
      throw Exception(error.toString());
    });
  }

  static Future<UserCarnet> addUserCarnet({
    required Membership membership,
    required bool paid,
    required User user,
  }) async {
    UserCarnet? result;
    final userId = GetStorage().read('token');

    final carnetsRef = FirebaseFirestore.instance
        .collection(collectionPath)
        .doc(userId)
        .collection("carnets");

    final existingUnpaid =
        await carnetsRef.where("paid", isEqualTo: false).get();
    if (existingUnpaid.docs.isNotEmpty) {
      throw const FormatException("unpaid-carnet-exists");
    }

    final carnetId = carnetsRef.doc().id;

    final userCarnet = UserCarnet(
      id: carnetId,
      paid: paid,
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
}
