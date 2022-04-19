import 'package:flutter/material.dart';

class EmailPasswordValidators {
  EmailPasswordValidators._();
  static FormFieldValidator compare(
      TextEditingController? valueEC, String message) {
    return (value) {
      final valueCompare = valueEC?.text ?? '';
      if (value == null || value != null && value != valueCompare) {
        return message;
      }
    };
  }
}
