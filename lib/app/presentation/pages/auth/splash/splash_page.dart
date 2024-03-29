import 'package:contactlist01b4a/app/presentation/pages/utils/part/logo.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          AppLogo(),
          CircularProgressIndicator(),
        ],
      ),
    ));
  }
}
