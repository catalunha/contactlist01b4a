import 'package:contactlist01b4a/app/domain/models/user/user_model.dart';

abstract class AuthUseCase {
  Future<UserModel?> registerEmail(
      {required String email, required String password});
  Future<UserModel?> loginEmail(
      {required String email, required String password});
  Future<void> forgotPassword(String email);

  Future<bool> logout();
}
