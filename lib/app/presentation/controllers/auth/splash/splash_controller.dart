import 'package:contactlist01b4a/app/data/datasources/back4app/init_back4app.dart';
import 'package:contactlist01b4a/app/domain/models/user/user_model.dart';
import 'package:contactlist01b4a/app/domain/usecases/auth/auth_usecase.dart';
import 'package:contactlist01b4a/app/presentation/routes.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class SplashController extends GetxController {
  final AuthUseCase _authUseCase;
  SplashController({required AuthUseCase authUseCase})
      : _authUseCase = authUseCase;

  final Rxn<ParseUser> _parseUser = Rxn<ParseUser>();
  ParseUser? get parseUser => _parseUser.value;
  set parseUser(ParseUser? parseUser) {
    _parseUser(parseUser);
  }

  final _userModel = Rxn<UserModel>();
  UserModel? get userModel => _userModel.value;
  set userModel(UserModel? userModel) {
    _userModel(userModel);
  }

  @override
  void onInit() async {
    super.onInit();
    await Future.delayed(const Duration(seconds: 1), () {
      // deleayed code here
      print('delayed execution');
    });

    print('+++ initParse');
    InitBack4app initBack4app = InitBack4app();
    bool initParse = await initBack4app.init();
    print('initParse: $initParse');
    print('--- initParse');

    final isLogged = await _hasUserLogged();
    if (isLogged) {
      print('tem user indo para home');
      Get.offAllNamed(Routes.home);
    } else {
      print('NAO tem user indo para LOGIN');
      Get.offAllNamed(Routes.authLogin);
    }
  }

  Future<bool> _hasUserLogged() async {
    parseUser = await ParseUser.currentUser() as ParseUser?;
    // ParseUser? currentUser = await ParseUser.currentUser() as ParseUser?;
    if (parseUser == null) {
      return false;
    }
    //Checks whether the user's session token is valid
    final ParseResponse? parseResponse =
        await ParseUser.getCurrentUserFromServer(parseUser!.sessionToken!);

    if (parseResponse?.success == null || !parseResponse!.success) {
      //Invalid session. Logout
      await parseUser!.logout();
      return false;
    } else {
      userModel = UserModel(
          objectId: parseUser!.objectId!,
          email: parseUser!.emailAddress!,
          username: parseUser!.emailAddress!,
          sessionToken: parseUser!.sessionToken!,
          createdAt: parseUser!.createdAt,
          updatedAt: parseUser!.updatedAt);
      return true;
    }
  }

  // Future<void> logout() async => await _authUseCase.logout();

  //   Future<bool> hasUserLogged() async {
  //   ParseUser? currentUser = await ParseUser.currentUser() as ParseUser?;
  //   if (currentUser == null) {
  //     return false;
  //   }
  //   //Checks whether the user's session token is valid
  //   final ParseResponse? parseResponse =
  //       await ParseUser.getCurrentUserFromServer(currentUser.sessionToken!);

  //   if (parseResponse?.success == null || !parseResponse!.success) {
  //     //Invalid session. Logout
  //     await currentUser.logout();
  //     return false;
  //   } else {
  //     return true;
  //   }
  // }
}
