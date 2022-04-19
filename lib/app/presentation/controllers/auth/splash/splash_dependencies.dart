import 'package:contactlist01b4a/app/data/datasources/back4app/auth/auth_repository_impl.dart';
import 'package:contactlist01b4a/app/data/repositories/auth_repository.dart';
import 'package:contactlist01b4a/app/domain/usecases/auth/auth_usecase.dart';
import 'package:contactlist01b4a/app/domain/usecases/auth/auth_usecase_impl.dart';
import 'package:contactlist01b4a/app/presentation/controllers/auth/splash/splash_controller.dart';
import 'package:get/get.dart';

class SplashDependencies implements Bindings {
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
    Get.put<SplashController>(
      SplashController(
        authUseCase: Get.find(),
      ),
      permanent: true,
    );
  }
}
