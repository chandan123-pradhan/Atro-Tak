import 'package:get/get.dart';

class GetXController extends GetxController {
  bool isAddProfileEnable = false;

  void changeScreen(bool val) {
    isAddProfileEnable = val;
    print(isAddProfileEnable);
    update();
  }
}
