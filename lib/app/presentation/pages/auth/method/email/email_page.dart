import 'package:contactlist01b4a/app/presentation/controllers/auth/register/email_password/email_controller.dart';
import 'package:contactlist01b4a/app/presentation/pages/utils/part/app_text_form_field.dart';
import 'package:contactlist01b4a/app/presentation/pages/utils/part/logo.dart';
import 'package:contactlist01b4a/app/presentation/pages/utils/validators/validators.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:validatorless/validatorless.dart';

class AuthEmailPage extends StatefulWidget {
  final EmailController _emailPasswordController = Get.find();

  AuthEmailPage({Key? key}) : super(key: key);

  @override
  State<AuthEmailPage> createState() => _AuthEmailPageState();
}

class _AuthEmailPageState extends State<AuthEmailPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailTec = TextEditingController();
  final _passwordTec = TextEditingController();
  final _confirmPasswordTec = TextEditingController();

  @override
  void dispose() {
    _emailTec.dispose();
    _passwordTec.dispose();
    _confirmPasswordTec.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              // Text(
              //   'Todo List',
              //   style: TextStyle(fontSize: 10, color: context.primaryColor),
              // ),
              Text(
                'Cadastro',
                // style: TextStyle(fontSize: 25, color: context.primaryColor),
              )
            ]),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: ClipOval(
            child: Container(
              // color: context.primaryColor.withAlpha(20),
              padding: const EdgeInsets.all(8),
              child: const Icon(
                Icons.arrow_back,
                size: 20,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.width * .5,
            child: const FittedBox(
              child: AppLogo(),
              fit: BoxFit.fitHeight,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 20,
            ),
            child: Form(
              key: _formKey,
              child: Column(children: [
                AppTextFormField(
                  label: 'E-mail',
                  controller: _emailTec,
                  validator: Validatorless.multiple(
                    [
                      Validatorless.email('Informe um email válido aqui.'),
                      Validatorless.required('Campo obrigatorio'),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                AppTextFormField(
                  label: 'Senha',
                  obscureText: true,
                  controller: _passwordTec,
                  validator: Validatorless.multiple([
                    Validatorless.min(6, 'Informe mais de 6 caracteres'),
                    Validatorless.required('Campo obrigatorio'),
                  ]),
                ),
                const SizedBox(height: 10),
                AppTextFormField(
                  label: 'Repita sua senha',
                  obscureText: true,
                  controller: _confirmPasswordTec,
                  validator: Validatorless.multiple([
                    Validatorless.min(6, 'Informe mais de 6 caracteres'),
                    Validatorless.required('Campo obrigatorio'),
                    EmailPasswordValidators.compare(
                        _passwordTec, 'Senhas diferentes'),
                  ]),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      final formValid =
                          _formKey.currentState?.validate() ?? false;
                      if (formValid) {
                        widget._emailPasswordController.registerUser(
                          email: _emailTec.text.trim(),
                          password: _passwordTec.text.trim(),
                        );
                      }
                    },
                    child: const Text('Registrar-me'),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          )
        ],
      ),
    );
  }
}
