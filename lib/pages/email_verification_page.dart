import 'package:flutter/material.dart';
import '../auth/auth_page.dart';

import '../services/user_service.dart';
import '../widgets/custom_filled_button.dart';

class EmailVerificationPage extends StatefulWidget {
  const EmailVerificationPage({super.key});

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  String? email;

  int countDown = 0;

  _navToAuthPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const AuthPage(),
      ),
    );
  }

  _listenEmailVerification() {
    UserService.checkEmailVerificationStatus(
        onWaiting: (time) {
          setState(() {
            countDown = time;
          });
        },
        onSucceed: () {
          _navToAuthPage();
        },
        onWaitingEnd: () {
          setState(() {
            countDown = 0;
          });
        },
        onFailed: (failure) {});
  }

  @override
  void initState() {
    email = UserService.getEmail();
    UserService.sendEmailVerification();
    _listenEmailVerification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify email"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Icon(Icons.mail,
                    size: 60, color: Theme.of(context).colorScheme.primary),
              ),
              Text(countDown.toString()),
              Text(
                "A verification email has been sent to",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
              Text(
                email ?? "",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
              Text(
                "Please check your email to verify your account",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: CustomFilledButton(
                    onPressed: () => UserService.sendEmailVerification(),
                    buttonText: "Resend email"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
