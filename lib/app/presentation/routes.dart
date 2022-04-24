import 'package:contactlist01b4a/app/presentation/controllers/address/address_dependencies.dart';
import 'package:contactlist01b4a/app/presentation/controllers/auth/login/login_dependencies.dart';
import 'package:contactlist01b4a/app/presentation/controllers/auth/register/email/email_dependencies.dart';
import 'package:contactlist01b4a/app/presentation/controllers/auth/splash/splash_dependencies.dart';
import 'package:contactlist01b4a/app/presentation/controllers/contact/contact_dependencies.dart';
import 'package:contactlist01b4a/app/presentation/controllers/home/home_dependencies.dart';
import 'package:contactlist01b4a/app/presentation/pages/address/address_append_page.dart';
import 'package:contactlist01b4a/app/presentation/pages/auth/login/login_page.dart';
import 'package:contactlist01b4a/app/presentation/pages/auth/register/email/email_page.dart';
import 'package:contactlist01b4a/app/presentation/pages/auth/splash/splash_page.dart';
import 'package:contactlist01b4a/app/presentation/pages/contact/contact_append_page.dart';
import 'package:contactlist01b4a/app/presentation/pages/error/error_page.dart';
import 'package:contactlist01b4a/app/presentation/pages/home/home_page.dart';
import 'package:get/get.dart';

class Routes {
  static const splash = '/';

  static const authLogin = '/auth/login';
  static const authEmail = '/auth/email_password';

  static const home = '/home';
  static const contactAppend = '/contact_append';
  static const addressAppend = '/address_append';

  static const errorPage = '/error';

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
      page: () => HomePage(),
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
    GetPage(
      name: Routes.contactAppend,
      binding: ContactDependencies(),
      page: () => ContactAppendPage(),
    ),
    GetPage(
      name: Routes.addressAppend,
      binding: AddressDependencies(),
      page: () => AddressAppendPage(),
    ),
  ];
}
