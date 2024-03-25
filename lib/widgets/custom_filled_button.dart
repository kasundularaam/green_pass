import 'package:flutter/material.dart';

class CustomFilledButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonText;
  final Color? buttonColor;
  final Color? buttonTextColor;
  final double? width;
  final bool? isDisabled;
  const CustomFilledButton({
    super.key,
    this.onPressed,
    required this.buttonText,
    this.buttonColor,
    this.buttonTextColor,
    this.width,
    this.isDisabled,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: 50,
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: buttonColor,
        ),
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: TextStyle(color: buttonTextColor),
        ),
      ),
    );
  }
}
