import 'package:contactlist01b4a/app/presentation/controllers/auth/login/login_controller.dart';
import 'package:contactlist01b4a/app/presentation/pages/utils/part/app_text_form_field.dart';
import 'package:contactlist01b4a/app/presentation/pages/utils/part/logo.dart';
import 'package:contactlist01b4a/app/presentation/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:validatorless/validatorless.dart';

class AuthLoginPage extends StatefulWidget {
  final LoginController _loginController = Get.find();

  AuthLoginPage({Key? key}) : super(key: key);

  @override
  State<AuthLoginPage> createState() => _AuthLoginPageState();
}

class _AuthLoginPageState extends State<AuthLoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailTec = TextEditingController();
  final _passwordTec = TextEditingController();
  final _emailFocus = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailTec.dispose();
    _passwordTec.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
                minWidth: constraints.maxWidth,
              ),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 10),
                    const AppLogo(),
                    Text('ContactList - Versão 01',
                        style: context.textTheme.headline6),
                    const Text(
                      '(all in bach4app)',
                      textAlign: TextAlign.center,
                    ),
                    // Text('Todo List', style: Theme.of(context).textTheme.headline6),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 20),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            AppTextFormField(
                              label: 'E-mail',
                              controller: _emailTec,
                              validator: Validatorless.multiple(
                                [
                                  Validatorless.email(
                                      'Informe um email válido aqui.'),
                                  Validatorless.required('Campo obrigatorio'),
                                ],
                              ),
                              focusNode: _emailFocus,
                            ),
                            const SizedBox(height: 20),
                            AppTextFormField(
                              label: 'Senha',
                              obscureText: true,
                              controller: _passwordTec,
                              validator: Validatorless.multiple(
                                [
                                  Validatorless.min(
                                      6, 'Informe mais de 6 caracteres'),
                                  Validatorless.required('Campo obrigatorio'),
                                ],
                              ),
                            ),
                            // SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            child: const Text('Esqueceu sua senha'),
                            onPressed: () {
                              if (_emailTec.text.isNotEmpty) {
                                widget._loginController
                                    .forgotPassword(_emailTec.text.trim());
                              } else {
                                _emailFocus.requestFocus();
                                Get.snackbar(
                                  'Oops',
                                  'Digite email para prosseguir',
                                  backgroundColor: Colors.red,
                                  margin: const EdgeInsets.all(10),
                                );
                              }
                            },
                          ),
                          ElevatedButton(
                            onPressed: () {
                              final formValid =
                                  _formKey.currentState?.validate() ?? false;
                              if (formValid) {
                                widget._loginController.loginEmail(
                                  _emailTec.text.trim(),
                                  _passwordTec.text.trim(),
                                );
                              }
                            },
                            child: const Text('Login'),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Não tem conta ?'),
                        TextButton(
                          onPressed: () {
                            Get.toNamed(Routes.authEmail);
                          },
                          child: const Text('Cadastre-se'),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          // color: context.primaryColor,
                          border: Border(
                            top: BorderSide(
                              width: 2,
                              color: Colors.grey.withAlpha(50),
                            ),
                          ),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            ElevatedButton.icon(
                              onPressed: () {
                                // widget._loginController.loginGoogle();
                              },
                              icon: const Icon(
                                Icons.g_mobiledata,
                                size: 50,
                                color: Colors.red,
                              ),
                              label: const Text('Entre com o Google'),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
