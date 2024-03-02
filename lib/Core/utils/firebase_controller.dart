import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pulse/Core/utils/service_locator.dart';

class FirebaseController extends GetxController {
  late String uid;
  @override
  void onInit() {
    uid = getIt.get<FirebaseAuth>().currentUser!.uid;
    super.onInit();
  }
}
