import 'package:contactlist01b4a/app/domain/models/contact/contact_model.dart';
import 'package:contactlist01b4a/app/domain/usecases/auth/auth_usecase.dart';
import 'package:contactlist01b4a/app/domain/usecases/contact/contact_usecase.dart';
import 'package:contactlist01b4a/app/domain/utils/pagination.dart';
import 'package:contactlist01b4a/app/presentation/controllers/utils/mixins/loader_mixin.dart';
import 'package:contactlist01b4a/app/presentation/routes.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class HomeController extends GetxController with LoaderMixin {
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

  final _loading = false.obs;

  Future<void> logout() async {
    print('em home logout ');
    await _authUseCase.logout();
    Get.offAllNamed(Routes.authLogin);
  }

  @override
  void onInit() {
    ever(_pagination, (_) => listContacts());
    _changePagination(1, 10);
    loaderListener(_loading);

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

  Future<int> countContacts() async {
    _loading(true);

    final ParseCloudFunction function = ParseCloudFunction('contact-count');
    final ParseResponse parseResponse = await function.execute();
    print('parseResponse.result: ${parseResponse.result}');
    print('parseResponse.results: ${parseResponse.results}');
    var map;
    if (parseResponse.success && parseResponse.result != null) {
      print(parseResponse.result);
      map = parseResponse.result;
    }
    _loading(false);

    return map['count'];
  }

  Future<void> updateAddress(String contactId, String addressId) async {
    await _contactUseCase.updateAddress(contactId, addressId);
    await reloadListContacts();
  }

  void editAddress(String id) async {
    print('editando address: $id');
    var _taskTemp = contacts.firstWhere((element) => element.id == id);
    Get.toNamed(Routes.addressAppend,
        arguments: {'model': _taskTemp.address, 'contactId': id});
  }
}
