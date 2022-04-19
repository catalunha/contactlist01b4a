import 'package:contactlist01b4a/app/data/datasources/back4app/auth/auth_repository_exception.dart';
import 'package:contactlist01b4a/app/domain/usecases/auth/auth_usecase.dart';
import 'package:contactlist01b4a/app/presentation/controllers/utils/mixins/loader_mixin.dart';
import 'package:contactlist01b4a/app/presentation/controllers/utils/mixins/message_mixin.dart';
import 'package:get/get.dart';

class LoginController extends GetxController with LoaderMixin, MessageMixin {
  final _loading = false.obs;
  final _message = Rxn<MessageModel>();

  final AuthUseCase _authUseCase;
  LoginController({required AuthUseCase authUseCase})
      : _authUseCase = authUseCase;

  @override
  void onInit() {
    super.onInit();
    loaderListener(_loading);
    messageListener(_message);
  }

  Future<void> loginEmail(String email, String password) async {
    try {
      _loading(true);
      final user =
          await _authUseCase.loginEmail(email: email, password: password);
      if (user != null) {
        //success
      } else {
        _message.value = MessageModel(
          title: 'Erro',
          message: 'Usuário ou senha inválidos.',
          isError: true,
        );
      }
    } on AuthRepositoryException catch (e) {
      _loading(false);
      _message.value = MessageModel(
        title: 'Oops',
        message: e.message,
        isError: true,
      );
    } finally {
      _loading(false);
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      final user = await _authUseCase.forgotPassword(email);
      _message.value = MessageModel(
        title: 'Erro',
        message: 'orientações sobre recuperação de senha ',
      );
    } on AuthRepositoryException {
      _authUseCase.logout();
      _message.value = MessageModel(
        title: 'AuthRepositoryException',
        message: 'Em recuperar senha',
        isError: true,
      );
    }
  }
}