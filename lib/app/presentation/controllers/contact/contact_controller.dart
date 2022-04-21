import 'package:contactlist01b4a/app/data/datasources/back4app/contact/contact_repository_exception.dart';
import 'package:contactlist01b4a/app/domain/models/contact/contact_model.dart';
import 'package:contactlist01b4a/app/domain/usecases/contact/contact_usecase.dart';
import 'package:contactlist01b4a/app/presentation/controllers/home/home_controller.dart';
import 'package:contactlist01b4a/app/presentation/controllers/utils/mixins/loader_mixin.dart';
import 'package:contactlist01b4a/app/presentation/controllers/utils/mixins/message_mixin.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ContactController extends GetxController with LoaderMixin, MessageMixin {
  final ContactUseCase _contactUseCase;
  ContactController({required ContactUseCase contactUseCase})
      : _contactUseCase = contactUseCase;
  final _loading = false.obs;
  final _message = Rxn<MessageModel>();

  final _contactModel = Rxn<ContactModel>();
  ContactModel? get contactModel => _contactModel.value;

  @override
  void onInit() {
    super.onInit();
    loaderListener(_loading);
    messageListener(_message);
    ContactModel? model = Get.arguments;
    _contactModel(model);
  }

  Future<void> append(String name, XFile? _xfile) async {
    try {
      _loading(true);
      if (_contactModel.value == null) {
        var contactModel = ContactModel(
          id: '',
          name: name,
        );
        await _contactUseCase.create(contactModel, _xfile);
      } else {
        var contactModel = _contactModel.value!.copyWith(name: name);
        await _contactUseCase.update(contactModel, _xfile);
      }
      final HomeController _homeController = Get.find();
      await _homeController.reloadListContacts();
    } on ContactRepositoryException {
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
    await _contactUseCase.delete(id);
    final HomeController _homeController = Get.find();
    await _homeController.reloadListContacts();

    Get.back();
  }
}
