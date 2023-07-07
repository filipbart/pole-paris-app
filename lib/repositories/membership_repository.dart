import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pole_paris_app/models/membership.dart';

const collectionPath = 'memberships';

class MembershipRepository {
  static Future<List<Membership>> getAllMemberships() async {
    List<Membership> result = [];
    await FirebaseFirestore.instance
        .collection(collectionPath)
        .where("dateDeletedUtc", isNull: true)
        .orderBy("dateCreatedUtc")
        .get()
        .then((value) {
      for (var membership in value.docs) {
        result.add(Membership.fromMap(membership.data()));
      }
    }).onError((error, stackTrace) {
      throw Exception(error.toString());
    });
    return result;
  }
}
