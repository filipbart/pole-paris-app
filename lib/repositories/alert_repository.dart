import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';

const collectionPathParent = 'users';
const collectionPath = 'alerts';

class AlertRepository {
  static Future<void> deleteAlert(String id) async {
    final userId = GetStorage().read('token');

    await FirebaseFirestore.instance
        .collection(collectionPathParent)
        .doc(userId)
        .collection(collectionPath)
        .doc(id)
        .update({
      'dateDeletedUtc': DateTime.now().toUtc().millisecondsSinceEpoch
    }).onError((error, stackTrace) => throw Exception(error.toString()));
  }

  static Future<void> readAlert(String id) async {
    final userId = GetStorage().read('token');

    await FirebaseFirestore.instance
        .collection(collectionPathParent)
        .doc(userId)
        .collection(collectionPath)
        .doc(id)
        .update({'read': true}).onError(
            (error, stackTrace) => throw Exception(error.toString()));
  }
}
