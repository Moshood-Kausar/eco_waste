import 'package:eco_waste/controller/auth_controller.dart';
import 'package:get/get.dart';

import '../controller/home_controller.dart';

class ControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => HomeController());
  }
}
