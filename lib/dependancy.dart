import 'package:get/get.dart';
import 'package:task_manager/ui/controllers/TaskController.dart';
import 'package:task_manager/ui/controllers/auth_controller.dart';

init() async {
  Get.lazyPut(() => AuthController());
  Get.lazyPut(() => TaskController());
}