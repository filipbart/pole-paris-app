import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pole_paris_app/models/class.dart';

const collectionPath = 'classes';

class ClassRepository {
  static Future<void> create(Class newClass) async {
    await FirebaseFirestore.instance
        .collection(collectionPath)
        .doc(newClass.id)
        .set(newClass.toMap())
        .onError((error, stackTrace) {
      throw Exception(error.toString());
    });
  }

  static String getNewId() {
    return FirebaseFirestore.instance.collection('classes').doc().id;
  }

  static Future<List<Class>> getMyClasses(bool forTeacher) async {
    List<Class> myClasses = [];
    if (forTeacher) {
      final teacherId = GetStorage().read('token');
      await FirebaseFirestore.instance
          .collection(collectionPath)
          .where("teacher.id", isEqualTo: teacherId)
          .get()
          .then((value) {
        for (var myClass in value.docs) {
          myClasses.add(Class.fromMap(myClass.data()));
        }
      }).onError((error, stackTrace) {
        throw Exception(error.toString());
      });
    } else {}
    return myClasses.sortedBy((element) => element.date);
  }

  static Future<List<Class>> getAvailableClasses() async {
    List<Class> result = [];
    await FirebaseFirestore.instance
        .collection(collectionPath)
        .get()
        .then((value) {
      for (var entry in value.docs) {
        result.add(Class.fromMap(entry.data()));
      }
    }).onError((error, stackTrace) {
      throw Exception(error.toString());
    });

    return result;
  }
}
