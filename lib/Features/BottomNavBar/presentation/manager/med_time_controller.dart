import 'package:get/get.dart';

class MedTimeController extends GetxController {
  List<int> selectedIndexes = [];
  void add(int selected) {
    selectedIndexes.add(selected);
    update();
  }

  void remove(int selected) {
    selectedIndexes.remove(selected);
    update();
  }
}
