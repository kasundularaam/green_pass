// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:green_pass/models/user_model.dart';
import 'package:green_pass/widgets/faculty_dropdown.dart';
import 'package:green_pass/widgets/input_textfield.dart';

import '../Services/user_service.dart';
import '../pages/login_page.dart';

class MutableObject<T> {
  T value;
  MutableObject(this.value);
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final mUser = MutableObject(User.empty());

  bool isLoading = false;

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
      body: StreamBuilder<User>(
          stream: UserService.listenCurrentUser(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text("An error occurred"),
              );
            }
            if (snapshot.hasData) {
              final user = snapshot.data;
              if (user == null) {
                return const Center(
                  child: Text("User not found"),
                );
              }
              mUser.value = user;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Edit Account",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                    const SizedBox(height: 20),
                    InputTextField(
                      labelText: "Name",
                      onChanged: (value) =>
                          mUser.value = mUser.value.copyWith(name: value),
                      initialValue: mUser.value.name,
                    ),
                    const SizedBox(height: 20),
                    FacultyDropdown(
                        onChanged: (value) =>
                            mUser.value = mUser.value.copyWith(faculty: value),
                        selectedValue: mUser.value.faculty),
                    const SizedBox(height: 20),
                    InputTextField(
                        labelText: "Phone",
                        onChanged: (value) =>
                            mUser.value = mUser.value.copyWith(phone: value),
                        initialValue: mUser.value.phone,
                        textInputType: TextInputType.phone),
                    const SizedBox(height: 20),
                    _UpdateButton(
                      isLoading: isLoading,
                      onPressed: () async {
                        if (isLoading) return;
                        setState(() {
                          isLoading = true;
                        });
                        UserService.updateUser(mUser.value).then((value) {
                          setState(() {
                            isLoading = false;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text("User updated successfully"),
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                            ),
                          );
                        }).catchError((error) {
                          setState(() {
                            isLoading = false;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(error.toString()),
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer,
                            ),
                          );
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    const Spacer(),
                    const Center(child: _LogOutButton()),
                    const SizedBox(height: 20),
                  ],
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}

class _UpdateButton extends StatelessWidget {
  final Function() onPressed;
  final bool isLoading;

  const _UpdateButton({
    required this.onPressed,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
        onPressed: onPressed,
        child: Text(isLoading ? "Updating..." : "Update"));
  }
}

class _LogOutButton extends StatelessWidget {
  const _LogOutButton();

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: () {
        UserService.userLogOut().then(
          (value) => Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const LoginPage()),
              (route) => false),
        );
      },
      style: FilledButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          textStyle: TextStyle(
              color: Theme.of(context).colorScheme.secondaryContainer)),
      icon: Icon(
        Icons.logout,
        size: 24.0,
        color: Theme.of(context).colorScheme.onSecondaryContainer,
      ),
      label: Text(
        'Logout',
        style: TextStyle(
            color: Theme.of(context).colorScheme.onSecondaryContainer),
      ),
    );
  }
}
