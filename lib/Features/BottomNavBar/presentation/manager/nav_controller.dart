import 'package:get/get.dart';

class NavController extends GetxController {
  int index = 0;

  void onItemTapped(int i) {
    index = i;
    update();
  }
}
