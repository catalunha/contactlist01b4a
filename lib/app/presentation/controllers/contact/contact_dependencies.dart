import 'package:contactlist01b4a/app/presentation/controllers/contact/contact_controller.dart';
import 'package:get/get.dart';

class ContactDependencies implements Bindings {
  @override
  void dependencies() {
    Get.put<ContactController>(ContactController(contactUseCase: Get.find()));
  }
}
