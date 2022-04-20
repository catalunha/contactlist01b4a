import 'package:contactlist01b4a/app/data/datasources/back4app/auth/auth_repository_exception.dart';
import 'package:contactlist01b4a/app/data/repositories/auth_repository.dart';
import 'package:contactlist01b4a/app/domain/models/user/user_model.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<UserModel?> registerEmail(
      {required String email, required String password}) async {
    try {
      final user = ParseUser.createUser(email, password, email);
      var response = await user.signUp();
      if (response.success) {
        print('register success');
        String result = response.results![0].toString();
        UserModel userModel = UserModel.fromJson(result);
        print(userModel.toMap());
        return userModel;
      } else {
        print('register error');

        throw AuthRepositoryException(message: response.error!.message);
      }
    } catch (e) {
      print(e);
      throw AuthRepositoryException(message: 'Erro no createUser ou SigUp');
    }
  }

  @override
  Future<UserModel?> loginEmail(
      {required String email, required String password}) async {
    try {
      final user = ParseUser(email, password, null);

      var response = await user.login();
      if (response.success) {
        String result = response.results![0].toString();
        UserModel userModel = UserModel.fromJson(result);
        // print(userModel.toMap());
        return userModel;
      } else {
        throw AuthRepositoryException(message: '${response.error!.code}');
      }
    } on AuthRepositoryException catch (e) {
      if (e.message == '205') {
        throw AuthRepositoryException(
            message: 'Cadastro ainda não confirmado no email do usuário.');
      }
    }
    return null;
  }

  @override
  Future<void> forgotPassword(String email) async {
    final ParseUser user = ParseUser(null, null, email);
    final ParseResponse parseResponse = await user.requestPasswordReset();
    if (!parseResponse.success) {
      throw AuthRepositoryException(message: 'Erro em recuperar senha');
    }
  }

  @override
  Future<bool> logout() async {
    final user = await ParseUser.currentUser() as ParseUser;
    var response = await user.logout();
    if (response.success) {
      return true;
    } else {
      return false;
    }
  }
}
