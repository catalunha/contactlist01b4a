import 'package:contactlist01b4a/app/presentation/controllers/auth/login/login_dependencies.dart';
import 'package:contactlist01b4a/app/presentation/controllers/auth/register/email_password/email_dependencies.dart';
import 'package:contactlist01b4a/app/presentation/controllers/home/home_dependencies.dart';
import 'package:contactlist01b4a/app/presentation/controllers/splash/splash_dependencies.dart';
import 'package:contactlist01b4a/app/presentation/pages/auth/login/login_page.dart';
import 'package:contactlist01b4a/app/presentation/pages/auth/method/email/email_page.dart';
import 'package:contactlist01b4a/app/presentation/pages/error/error_page.dart';
import 'package:contactlist01b4a/app/presentation/pages/home/home_page.dart';
import 'package:contactlist01b4a/app/presentation/pages/splash/splash_page.dart';
import 'package:get/get.dart';

class Routes {
  static const splash = '/';
  static const errorPage = '/error';
  static const home = '/home';
  static const authLogin = '/auth/login';
  static const authEmail = '/auth/email_password';

  static final pageList = [
    GetPage(
      name: Routes.splash,
      binding: SplashDependencies(),
      page: () => const SplashPage(),
    ),
    GetPage(
      name: Routes.errorPage,
      page: () => ErrorPage(),
    ),
    GetPage(
      name: Routes.home,
      binding: HomeDependencies(),
      page: () => const HomePage(),
    ),
    GetPage(
      name: Routes.authLogin,
      binding: AuthLoginDependencies(),
      page: () => AuthLoginPage(),
    ),
    GetPage(
      name: Routes.authEmail,
      binding: AuthEmailDependencies(),
      page: () => AuthEmailPage(),
    ),
  ];
}
