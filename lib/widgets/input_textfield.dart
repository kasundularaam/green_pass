import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
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
    this.hint,
    required this.labelText,
    this.isPassword,
    this.suffixIcon,
    this.width,
    this.helperText,
    this.textInputType,
    required this.onChanged,
    this.isOptional,
    this.isEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextFormField(
        keyboardType: textInputType,
        onChanged: onChanged,
        validator: (value) {
          if (value == null || value.isEmpty) {
            if (isOptional == true) {
              return null;
            }
            return 'Please fill this field';
          } else if (textInputType == TextInputType.emailAddress &&
              !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(value)) {
            return 'Please enter a valid email address';
          } else if (isPassword == true && value.length < 6) {
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
