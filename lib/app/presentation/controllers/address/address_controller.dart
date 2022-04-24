import 'package:contactlist01b4a/app/data/datasources/back4app/address/address_repository_exception.dart';
import 'package:contactlist01b4a/app/domain/models/address_model.dart';
import 'package:contactlist01b4a/app/domain/usecases/address/address_usecase.dart';
import 'package:contactlist01b4a/app/presentation/controllers/home/home_controller.dart';
import 'package:contactlist01b4a/app/presentation/controllers/utils/mixins/loader_mixin.dart';
import 'package:contactlist01b4a/app/presentation/controllers/utils/mixins/message_mixin.dart';
import 'package:get/get.dart';

class AddressController extends GetxController with LoaderMixin, MessageMixin {
  final AddressUseCase _addressUseCase;
  AddressController({required AddressUseCase addressUseCase})
      : _addressUseCase = addressUseCase;
  final _loading = false.obs;
  final _message = Rxn<MessageModel>();

  final _addressModel = Rxn<AddressModel>();
  AddressModel? get addressModel => _addressModel.value;
  String contactId = '';

  @override
  void onInit() {
    loaderListener(_loading);
    messageListener(_message);
    Map<String, dynamic> args = Get.arguments;
    AddressModel? model = args['model'];
    contactId = args['contactId'];
    print('Get.arguments = ${Get.arguments}');

    _addressModel(model);

    super.onInit();
  }

  Future<void> append({
    required String cep,
    required String description,
    String? city,
    String? state,
  }) async {
    try {
      _loading(true);
      String addressId;
      final HomeController _homeController = Get.find();

      if (_addressModel.value == null) {
        var addressModel = AddressModel(
          cep: cep,
          description: description,
          city: city,
          state: state,
        );
        addressId = await _addressUseCase.create(addressModel);
      } else {
        var addressModel = _addressModel.value!.copyWith(
          cep: cep,
          description: description,
          city: city,
          state: state,
        );
        await _addressUseCase.update(addressModel);
        addressId = addressModel.id!;
        print('update address');
      }
      await _homeController.updateAddress(contactId, addressId);
      Get.back<String>(result: 'voltando');
    } on AddressRepositoryException {
      _message.value = MessageModel(
        title: 'Erro em Repository',
        message: 'Nao foi possivel salvar o contato',
        isError: true,
      );
    } finally {
      _loading(false);
    }
  }

  Future<void> delete(String id) async {
    await _addressUseCase.delete(id);
    final HomeController _homeController = Get.find();
    await _homeController.reloadListContacts();

    Get.back();
  }
}
