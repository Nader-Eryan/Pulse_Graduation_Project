import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pulse/Core/utils/service_locator.dart';

Future<String> getUserRole() async {
  var firebaseUser = getIt.get<FirebaseAuth>().currentUser;
  if (firebaseUser != null) {
    var snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseUser.uid)
        .get();
    return snapshot.data()?['role'];
  }
  return '';
}
