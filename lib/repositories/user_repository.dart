import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';
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
}
