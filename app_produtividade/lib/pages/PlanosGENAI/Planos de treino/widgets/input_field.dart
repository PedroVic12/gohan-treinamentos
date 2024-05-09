import 'package:flutter/material.dart';


class InputField extends StatelessWidget {
  final String labelText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  const InputField({
    Key? key,
    required this.labelText,
    this.validator,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(labelText: labelText),
      validator: validator,
      keyboardType: keyboardType,
    );
  }
}
