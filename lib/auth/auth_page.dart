import 'package:flutter/material.dart';
import '../pages/email_verification_page.dart';
import '../pages/login_page.dart';
import '../pages/navigation_page.dart';
import '../services/user_service.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  _navigate() {
    if (UserService.isSignedIn) {
      final emailVerified = UserService.isVerified();
      if (emailVerified) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const NavigationPage(),
          ),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const EmailVerificationPage(),
          ),
        );
      }
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
    }
  }

  _waitAndNavigate() async {
    await Future.delayed(const Duration(seconds: 2));
    _navigate();
  }

  @override
  void initState() {
    _waitAndNavigate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: CircularProgressIndicator(),
    ));
  }
}
