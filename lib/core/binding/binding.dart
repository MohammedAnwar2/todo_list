import 'package:get/get.dart';
import 'package:todo_list/core/controllers/NoteController.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TaskController());
  }
}