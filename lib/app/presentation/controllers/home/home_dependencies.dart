import 'package:contactlist01b4a/app/data/datasources/back4app/contact/contact_repository_b4a.dart';
import 'package:contactlist01b4a/app/data/datasources/back4app/repositories/contact_repository.dart';
import 'package:contactlist01b4a/app/domain/usecases/contact/contact_usecase.dart';
import 'package:contactlist01b4a/app/domain/usecases/contact/contact_usecase_impl.dart';
import 'package:contactlist01b4a/app/presentation/controllers/home/home_controller.dart';
import 'package:get/get.dart';

class HomeDependencies implements Bindings {
  @override
  void dependencies() {
    Get.put<ContactRepository>(
      ContactRepositoryB4a(),
    );
    Get.put<ContactUseCase>(
      ContactUseCaseImpl(
        contactRepository: Get.find(),
      ),
    );
    Get.put<HomeController>(
      HomeController(authUseCase: Get.find(), contactUseCase: Get.find()),
    );
  }
}
