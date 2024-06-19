import 'package:get/get.dart';
import 'package:pulse/Core/utils/edit_database.dart';
import 'package:rxdart/rxdart.dart';

class MedsController extends GetxController {
  BehaviorSubject<List<Map<String, dynamic>>> medsSubject =
      BehaviorSubject<List<Map<String, dynamic>>>();

  @override
  void onInit() {
    super.onInit();
    getMeds();
  }

  @override
  void onClose() {
    medsSubject
        .close();
    super.onClose();
  }

  getMeds() async {
    List<Map<String, dynamic>> result = await USqlDb().read('meds');
    medsSubject
        .add(result);
  }
}
