import 'package:get/get.dart';



class BaseController extends GetxController {
  var isNotification = false.obs;
  RxInt currentIndex = 0.obs;


  @override
  void onInit() {
    // TODO: implement onInit

    super.onInit();
  }

  updateIsNotification() {
    isNotification(true);
  }


  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
