import 'package:contactlist01b4a/app/presentation/controllers/auth/login/login_controller.dart';
import 'package:get/get.dart';

class AuthLoginDependencies implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController(
          authUseCase: Get.find(),
          splashController: Get.find(),
        ));
  }
}
