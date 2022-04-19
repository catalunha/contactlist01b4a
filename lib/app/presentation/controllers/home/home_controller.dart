import 'package:contactlist01b4a/app/domain/usecases/auth/auth_usecase.dart';
import 'package:contactlist01b4a/app/presentation/routes.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final AuthUseCase _authUseCase;
  HomeController({required AuthUseCase authUseCase})
      : _authUseCase = authUseCase;

  Future<void> logout() async {
    await _authUseCase.logout();
    Get.offAllNamed(Routes.authLogin);
  }
}
