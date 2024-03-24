import 'package:green_pass/models/failure.dart';
import 'package:flutter/material.dart';
import '../pages/email_verification_page.dart';
import '../services/user_service.dart';
import '../widgets/custom_filled_button.dart';
import '../widgets/input_dropdown.dart';
import '../widgets/input_textfield.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  List<String> facultyList = [
    "Faculty Of Business",
    "Faculty Of Computing",
    "Faculty Of Engineering"
  ];
  String name = "";
  String email = "";
  String phone = "";
  String faculty = "";
  String password = "";
  String confirmPassword = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            const SizedBox(
              height: 40,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: OverflowBar(
                  overflowAlignment: OverflowBarAlignment.start,
                  overflowSpacing: 15,
                  children: <Widget>[
                    Center(
                      child: Text(
                        'Register',
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.copyWith(
                                color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                    InputTextField(
                      labelText: "Name",
                      hint: "Enter your Name",
                      onChanged: (nameValue) {
                        name = nameValue;
                      },
                      isPassword: false,
                    ),
                    InputTextField(
                      labelText: "Email Address",
                      hint: "Enter your Email Address ",
                      textInputType: TextInputType.emailAddress,
                      onChanged: (emailValue) {
                        email = emailValue;
                      },
                      isPassword: false,
                    ),
                    InputTextField(
                      labelText: "Phone",
                      hint: "Enter your Name",
                      textInputType: TextInputType.phone,
                      onChanged: (phoneValue) {
                        phone = phoneValue;
                      },
                      isPassword: false,
                    ),
                    InputDropDown(
                      onChanged: (facultyValue) {
                        faculty = facultyValue;
                      },
                      itemsList: facultyList,
                      labelText: "Select Faculty",
                    ),
                    InputTextField(
                      labelText: "Password",
                      hint: "Set a new password",
                      onChanged: (passwordValue) {
                        password = passwordValue;
                      },
                      isPassword: true,
                    ),
                    InputTextField(
                      labelText: "Confirm Password",
                      hint: "re type password",
                      onChanged: (confirmPasswordValue) {
                        confirmPassword = confirmPasswordValue;
                      },
                      isPassword: true,
                    ),
                    CustomFilledButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {}
                          await UserService.userRegister(
                            name,
                            email,
                            phone,
                            faculty,
                            password,
                          ).then(
                            (value) {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const EmailVerificationPage(),
                                ),
                              );
                            },
                          ).catchError(
                            (error) {
                              if (error is Failure) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(error.message),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        "Unknown error occurred.try again"),
                                  ),
                                );
                              }
                            },
                          );
                        },
                        buttonText: "Register"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account??",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            " Log in",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
