import 'package:flutter/material.dart';
import '../pages/login_page.dart';
import '../Services/user_service.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  // final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        title: Text(
          "Settings",
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 40),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: double.infinity,
                height: 50,
                child: FilledButton(
                  onPressed: () {},
                  child: const Text('Edit Profile'),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: FilledButton.icon(
                  onPressed: () {
                    UserService.userLogOut().then(
                      (value) => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      ),
                    );
                  },
                  style: FilledButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).colorScheme.secondaryContainer,
                      textStyle: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .secondaryContainer)),
                  icon: Icon(
                    Icons.logout,
                    size: 24.0,
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                  label: Text(
                    'Logout',
                    style: TextStyle(
                        color:
                            Theme.of(context).colorScheme.onSecondaryContainer),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
