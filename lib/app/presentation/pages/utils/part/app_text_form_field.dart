import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  final String label;
  final bool obscureText;
  final IconButton? suffixIconButton;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final FocusNode? focusNode;

  final ValueNotifier<bool> obscureTextVN;
  AppTextFormField({
    Key? key,
    required this.label,
    this.obscureText = false,
    this.suffixIconButton,
    this.controller,
    this.validator,
    this.focusNode,
  })  : assert(obscureText == true ? suffixIconButton == null : true,
            'ObscureText nao pode ser enviado em conjunto com suffixIconButton'),
        obscureTextVN = ValueNotifier(obscureText),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: obscureTextVN,
        builder: (_, obscureTextValue, __) {
          return TextFormField(
            controller: controller,
            validator: validator,
            focusNode: focusNode,
            decoration: InputDecoration(
              labelText: label,
              labelStyle: const TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: Colors.red),
              ),
              isDense: true,
              suffixIcon: suffixIconButton ??
                  (obscureText == true
                      ? IconButton(
                          icon: obscureTextValue
                              ? const Icon(
                                  Icons.sentiment_very_dissatisfied_sharp)
                              : const Icon(
                                  Icons.sentiment_satisfied_alt_outlined),
                          onPressed: () {
                            obscureTextVN.value = !obscureTextValue;
                          },
                        )
                      : null),
            ),
            obscureText: obscureTextValue,
          );
        });
  }
}
