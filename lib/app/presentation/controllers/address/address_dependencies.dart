import 'package:contactlist01b4a/app/data/datasources/back4app/address/address_repository_b4a.dart';
import 'package:contactlist01b4a/app/data/repositories/address_repository.dart';
import 'package:contactlist01b4a/app/domain/usecases/address/address_usecase.dart';
import 'package:contactlist01b4a/app/domain/usecases/address/address_usecase_impl.dart';
import 'package:contactlist01b4a/app/presentation/controllers/address/address_controller.dart';
import 'package:get/get.dart';

class AddressDependencies implements Bindings {
  @override
  void dependencies() {
    Get.put<AddressRepository>(
      AddressRepositoryB4a(),
    );
    Get.put<AddressUseCase>(
      AddressUseCaseImpl(
        addressRepository: Get.find(),
      ),
    );
    Get.put<AddressController>(
      AddressController(
        addressUseCase: Get.find(),
      ),
    );
  }
}
