import 'package:get/get.dart';

class MedicationTypeController extends GetxController {
  String chosen = '';
  void updateChosen(String selected) {
    chosen = selected;
    update();
  }
}
