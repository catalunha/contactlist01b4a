import 'package:contactlist01b4a/app/data/datasources/back4app/auth/auth_repository_impl.dart';
import 'package:contactlist01b4a/app/data/repositories/auth_repository.dart';
import 'package:contactlist01b4a/app/domain/usecases/auth/auth_usecase.dart';
import 'package:contactlist01b4a/app/domain/usecases/auth/auth_usecase_impl.dart';
import 'package:contactlist01b4a/app/presentation/controllers/auth/login/login_controller.dart';
import 'package:get/get.dart';

class AuthLoginDependencies implements Bindings {
  @override
  void dependencies() {
    Get.put<AuthRepository>(
      AuthRepositoryImpl(),
      permanent: true,
    );
    Get.put<AuthUseCase>(
      AuthUseCaseImpl(
        authRepository: Get.find(),
      ),
      permanent: true,
    );
    Get.lazyPut<LoginController>(
        () => LoginController(authUseCase: Get.find()));
  }
}
