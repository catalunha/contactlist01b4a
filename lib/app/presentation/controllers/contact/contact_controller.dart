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

  final Rxn<DateTime> _selectedDate = Rxn<DateTime>();
  DateTime? get selectedDate => _selectedDate.value;
  set selectedDate(DateTime? selectedDate1) {
    _selectedDate.value = selectedDate1;
    print('set selectedDate: $selectedDate');

    // if (selectedDate != null) {
    //   _selectedDate.value = selectedDate;
    // } else {
    //   _selectedDate.value = DateTime.now();
    // }
  }

  XFile? _xfile;
  set xfile(XFile? xfile) {
    _xfile = xfile;
  }

  @override
  void onInit() {
    loaderListener(_loading);
    messageListener(_message);
    ContactModel? model = Get.arguments;
    print('Get.arguments = ${Get.arguments}');
    if (model != null) {
      selectedDate = model.birthday;
    } else {
      selectedDate = null;
    }
    print('selectedDate: $selectedDate');
    _contactModel(model);
    super.onInit();
  }

  Future<void> append({required String name}) async {
    try {
      _loading(true);
      // DateTime date =
      //     DateTime(selectedDate!.year, selectedDate!.month, selectedDate!.day);

      if (_contactModel.value == null) {
        var contactModel = ContactModel(
          id: '',
          name: name,
          birthday: selectedDate,
        );
        await _contactUseCase.create(contactModel, _xfile);
      } else {
        var contactModel =
            _contactModel.value!.copyWith(name: name, birthday: selectedDate);
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
