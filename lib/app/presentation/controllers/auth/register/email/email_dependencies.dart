import 'package:contactlist01b4a/app/presentation/controllers/auth/register/email/email_controller.dart';
import 'package:get/get.dart';

class AuthEmailDependencies implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EmailController>(
        () => EmailController(authUseCase: Get.find()));
  }
}
