import 'package:flutter/material.dart';
import '../services/user_service.dart';
import '../widgets/custom_filled_button.dart';
import '../widgets/input_textfield.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  String email = "";
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Enter your email address and we will send you a password reset link.",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: InputTextField(
                    labelText: "Email Address",
                    onChanged: (value) {
                      email = value;
                    },
                  ),
                ),
                CustomFilledButton(
                  width: 300,
                  onPressed: () {
                    UserService.resetPassword(email, context);
                  },
                  buttonText: "Reset password",
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
