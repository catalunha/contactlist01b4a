import 'package:contactlist01b4a/app/presentation/controllers/auth/splash/splash_controller.dart';
import 'package:contactlist01b4a/app/presentation/controllers/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  final HomeController _homeController = Get.find();
  final SplashController _splashController = Get.find();
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text('Home'),
        title: Obx(() => Text(
              // 'Olá, ${widget._homeController.userService.userModel.displayName ?? "Sem nome"}',
              'Olá, ${_splashController.userModel?.username ?? "Sem nome"}',
              // 'Oi, ${widget._userService.userModel.uuid}',

              style: const TextStyle(color: Colors.black),
            )),
        actions: [
          IconButton(
              onPressed: () => _homeController.logout(),
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
    );
  }
}
