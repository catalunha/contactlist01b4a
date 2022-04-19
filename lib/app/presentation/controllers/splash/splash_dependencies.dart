import 'package:contactlist01b4a/app/presentation/controllers/splash/splash_controller.dart';
import 'package:get/get.dart';

class SplashDependencies implements Bindings {
  @override
  void dependencies() {
    Get.put<SplashController>(
      SplashController(),
      permanent: true,
    );
  }
}
