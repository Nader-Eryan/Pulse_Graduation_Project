import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pulse/Core/utils/service_locator.dart';

Future<bool> isRoleNull() async {
  CollectionReference users =
      getIt.get<FirebaseFirestore>().collection('users');
  String uid = getIt.get<FirebaseAuth>().currentUser!.uid;
  DocumentSnapshot docSnapshot = await users.doc(uid).get();
  Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
  return data['role'] == null;
}
