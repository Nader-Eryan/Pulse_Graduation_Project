import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pulse/core/utils/service_locator.dart';

class FireRepo {
  final String uid = getIt.get<FirebaseAuth>().currentUser!.uid;

  CollectionReference dList = FirebaseFirestore.instance.collection('dList');

  Future<void> addMedToFire(String name) async {
    var a =
        await getIt.get<FirebaseFirestore>().collection('dList').doc(uid).get();
    if (a.exists) {
      dList.doc(uid).update(
        {
          'drugs': FieldValue.arrayUnion([name])
        },
      );
    } else {
      dList.doc(uid).set({
        'drugs': FieldValue.arrayUnion([name])
      });
    }
  }

  Future<void> removeMedFromFire(String name) async {
    dList.doc(uid).update({
      'drugs': FieldValue.arrayRemove([name])
    });
  }
}
