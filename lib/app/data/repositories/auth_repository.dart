import 'package:contactlist01b4a/app/domain/models/user/user_model.dart';

abstract class AuthRepository {
  Future<UserModel?> register(
      {required String email, required String password});
  Future<UserModel?> loginEmail(
      {required String email, required String password});
  Future<void> logout();
  Future<void> forgotPassword(String email);
}
