import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ErrorPage extends StatelessWidget {
  final String? errorMessage = Get.arguments;
  ErrorPage({
    Key? key,
  }) : super(key: key);

  // final AuthController _authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Erro no acesso ao sistema.'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Se você esta vendo esta tela.'),
            const Text('Existe um erro no seu acesso.'),
            const Text('Informe o texto a seguir ao administrador.'),
            const SizedBox(height: 20),
            Text(errorMessage ?? 'Descrição do erro não informado.'),
            const SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: () => _authController.logout(),
            //   child: const Text('Sair'),
            // )
          ],
        ),
      ),
    );
  }
}
