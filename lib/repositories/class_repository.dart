import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pole_paris_app/models/class.dart';
import 'package:pole_paris_app/models/user_carnet.dart';

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
    } else {
      final userId = GetStorage().read('token');
      final carnets = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('carnets')
          .get();
      for (var carnet in carnets.docs) {
        final carnetData = UserCarnet.fromMap(carnet.data());
        final carnetClasses = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('carnets')
            .doc(carnetData.id)
            .collection('classes')
            .get();

        if (carnetClasses.docs.isNotEmpty) {
          final userClasses = await FirebaseFirestore.instance
              .collection(collectionPath)
              .where("id",
                  whereIn: carnetClasses.docs.map((e) => e.id).toList())
              .get();
          for (var userClass in userClasses.docs) {
            myClasses.add(Class.fromMap(userClass.data()));
          }
        }
      }
    }
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

    for (var entry in result) {
      final classCarnetsIds = await FirebaseFirestore.instance
          .collection(collectionPath)
          .doc(entry.id)
          .collection('carnets')
          .get();

        final classCarnets = classCarnetsIds.docs.map((e) async =>  await FirebaseFirestore.instance.doc('carnets/${e.id}').get());
        
      for (var carnet in classCarnetsIds.docs) {
        final carnetEntity = await FirebaseFirestore.instance.collectionGroup('carnets')
        .where("")
        entry.carnets.add(UserCarnet.fromMap(carnet.data()));
      }
    }

    return result;
  }
}
