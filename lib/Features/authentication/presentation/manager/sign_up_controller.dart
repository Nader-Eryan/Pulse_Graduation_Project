import 'package:get/get.dart';

class SignUpController extends GetxController {
  late bool isChecked = false;

  void changeCheckBox() {
    isChecked = !isChecked;
    update();
  }
}
