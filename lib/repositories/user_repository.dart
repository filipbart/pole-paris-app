import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pole_paris_app/models/user.dart';

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
}
