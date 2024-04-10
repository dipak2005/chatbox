
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxInt pIndex = 0.obs;

  void changeIndex(int index) {
    pIndex.value = index;
  }


}
