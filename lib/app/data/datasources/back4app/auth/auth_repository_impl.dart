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
        String result = response.results![0].toString();
        UserModel userModel = UserModel.fromJson(result);
        print(userModel.toMap());
        return userModel;
      } else {
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
        print(userModel.toMap());
        return userModel;
      } else {
        throw AuthRepositoryException(message: response.error!.message);
      }
    } catch (e) {
      throw AuthRepositoryException(message: 'Erro ao realizar login');
    }
  }

  @override
  Future<void> forgotPassword(String email) async {}

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
