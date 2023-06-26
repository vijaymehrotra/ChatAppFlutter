import 'package:flutter/material.dart';

import '../utils/textfield_styles.dart';

class LoginTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final FormFieldValidator<String>? validator;
  final bool hasAsterics;

  const LoginTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.validator , this.hasAsterics = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: hasAsterics,
      validator: (value) {
        if (validator != null) {
          return validator!(value);
        }
      },
      controller: controller,
      decoration: InputDecoration(
        hintText: '$hintText',
        hintStyle: ThemeTextStyle.loginTextFieldStyle,
        border: OutlineInputBorder(),
      ),
    );
  }
}
