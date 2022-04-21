import 'package:contactlist01b4a/app/data/datasources/back4app/auth/auth_repository_exception.dart';
import 'package:contactlist01b4a/app/domain/usecases/auth/auth_usecase.dart';
import 'package:contactlist01b4a/app/presentation/controllers/auth/splash/splash_controller.dart';
import 'package:contactlist01b4a/app/presentation/controllers/utils/mixins/loader_mixin.dart';
import 'package:contactlist01b4a/app/presentation/controllers/utils/mixins/message_mixin.dart';
import 'package:contactlist01b4a/app/presentation/routes.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class LoginController extends GetxController with LoaderMixin, MessageMixin {
  final _loading = false.obs;
  final _message = Rxn<MessageModel>();

  final AuthUseCase _authUseCase;
  final SplashController _splashController;
  LoginController({
    required AuthUseCase authUseCase,
    required SplashController splashController,
  })  : _authUseCase = authUseCase,
        _splashController = splashController;

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
        _splashController.userModel = user;
        final parseUser = await ParseUser.currentUser() as ParseUser;
        _splashController.parseUser = parseUser;

        Get.offAllNamed(Routes.home);
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
        message: '${e.code} ${e.message}',
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
        title: 'Veja seu email',
        message: 'Enviamos instruções de recuperação de senha nele.',
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
