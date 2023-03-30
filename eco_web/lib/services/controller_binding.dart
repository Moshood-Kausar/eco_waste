import 'package:eco_web/controller/auth_controller.dart';
import 'package:eco_web/controller/recycle.controller.dart';
import 'package:eco_web/controller/waste_controller.dart';
import 'package:get/get.dart';

class ControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => WasteController());
    Get.lazyPut(() => RecycleController());
  }
}
