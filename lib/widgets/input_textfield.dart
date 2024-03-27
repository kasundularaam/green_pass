// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  final String? initialValue;
  final String? hint;
  final String labelText;
  final bool? isPassword;
  final IconData? suffixIcon;
  final double? width;
  final String? helperText;
  final TextInputType? textInputType;
  final bool? isOptional;
  final bool? isEnabled;
  final Function(String) onChanged;
  const InputTextField({
    super.key,
    this.initialValue,
    this.hint,
    required this.labelText,
    this.isPassword,
    this.suffixIcon,
    this.width,
    this.helperText,
    this.textInputType,
    this.isOptional,
    this.isEnabled,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextFormField(
        keyboardType: textInputType,
        initialValue: initialValue,
        onChanged: onChanged,
        validator: (value) {
          if (value == null || value.isEmpty) {
            if (isOptional == true) {
              return null;
            }
            return 'Please fill this field';
          }
          if (textInputType == TextInputType.emailAddress &&
              !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(value)) {
            return 'Please enter a valid email address';
          }
          if (isPassword == true && value.length < 6) {
            return 'Password must be at least 6 characters';
          }
          return null;
        },
        enabled: isEnabled,
        obscureText: isPassword ?? false,
        decoration: InputDecoration(
          suffixIcon: Icon(suffixIcon),
          border: const OutlineInputBorder(),
          labelText: labelText,
          hintText: hint,
          helperText: helperText,
        ),
      ),
    );
  }
}
