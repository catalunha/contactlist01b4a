import 'package:contactlist01b4a/app/presentation/routes.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    await Future.delayed(const Duration(seconds: 1), () {
      // deleayed code here
      print('delayed execution');
    });
    Get.offAllNamed(Routes.authLogin);
  }
}
