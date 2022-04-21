import 'package:contactlist01b4a/app/domain/models/contact/contact_model.dart';
import 'package:contactlist01b4a/app/domain/usecases/auth/auth_usecase.dart';
import 'package:contactlist01b4a/app/domain/usecases/contact/contact_usecase.dart';
import 'package:contactlist01b4a/app/domain/utils/pagination.dart';
import 'package:contactlist01b4a/app/presentation/routes.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final AuthUseCase _authUseCase;
  final ContactUseCase _contactUseCase;
  HomeController(
      {required AuthUseCase authUseCase,
      required ContactUseCase contactUseCase})
      : _authUseCase = authUseCase,
        _contactUseCase = contactUseCase;

  final _contactList = <ContactModel>[].obs;
  List<ContactModel> get contacts => _contactList.toList();
  final _pagination = Pagination().obs;
  final _lastPage = false.obs;
  get lastPage => _lastPage.value;
  Future<void> logout() async {
    print('em home logout ');
    await _authUseCase.logout();
    Get.offAllNamed(Routes.authLogin);
  }

  @override
  void onInit() {
    ever(_pagination, (_) => listContacts());
    _changePagination(1, 2);
    super.onInit();
    // final SplashController _splashController = Get.find();
    // print('home:userModel');
    // print(_splashController.userModel.toString());
    // print('home:parseUser');
    // print(_splashController.parseUser.toString());
    // listContacts();
  }

  Future<void> listContacts() async {
    final list = await _contactUseCase.list(_pagination.value);
    if (list.isEmpty) {
      _lastPage.value = true;
    }
    // _contactList.clear();
    _contactList.addAll(list);
  }

  Future<void> reloadListContacts() async {
    _contactList.clear();
    var paginationtemp = Pagination();
    paginationtemp.page = 1;
    paginationtemp.limit = _pagination.value.page * _pagination.value.limit;
    final list = await _contactUseCase.list(paginationtemp);
    if (list.isEmpty) {
      _lastPage.value = true;
    }
    _contactList.addAll(list);
  }

  void _changePagination(int page, int limit) {
    _pagination.update((val) {
      val!.page = page;
      val.limit = limit;
    });
  }

  void nextPage() {
    _changePagination(_pagination.value.page + 1, _pagination.value.limit);
  }

  void createContact() {
    Get.toNamed(Routes.contactAppend, arguments: null);
  }

  void editContact(String id) {
    print('editando: $id');
    var _taskTemp = contacts.firstWhere((element) => element.id == id);
    Get.toNamed(Routes.contactAppend, arguments: _taskTemp);
  }
}
