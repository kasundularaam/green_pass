import 'dart:io';

import 'package:green_pass/models/failure.dart';
import 'package:green_pass/services/organization_service.dart';
import 'package:green_pass/widgets/input_large_textfield.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/input_textfield.dart';

class AddOrganizationPage extends StatefulWidget {
  const AddOrganizationPage({super.key});

  @override
  State<AddOrganizationPage> createState() => _AddOrganizationPageState();
}

class _AddOrganizationPageState extends State<AddOrganizationPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _deskText = TextEditingController();
  String orgName = '';
  String orgEmail = '';
  XFile? _image;
  bool isLoading = false;

  Future<void> _getImageFromGallery() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = pickedImage;
      });
    }
  }

  String _getImagePath(XFile? image) {
    if (image != null) {
      return image.path;
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        title: Text(
          "Add an Organization",
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
        ),
        actions: [
          isLoading
              ? const CircularProgressIndicator()
              : TextButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });
                      await OrganizationService.addOrganization(
                        orgEmail,
                        orgName,
                        _deskText.text,
                        _getImagePath(_image),
                      ).then(
                        (value) {
                          setState(() {
                            isLoading = false;
                          });
                          Navigator.pop(context);
                        },
                      ).catchError(
                        (error) {
                          setState(() {
                            isLoading = false;
                          });
                          if (error is Failure) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(error.message),
                              ),
                            );
                          }
                        },
                      );
                    }
                  },
                  child: const Text("Add"))
        ],
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(23.0),
          child: ListView(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OverflowBar(
                  overflowAlignment: OverflowBarAlignment.center,
                  overflowSpacing: 22,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(94),
                      child: InkWell(
                        onTap: _getImageFromGallery,
                        child: _image == null
                            ? Image.asset('lib/assets/Group 9.png',
                                width: 94, height: 94, fit: BoxFit.cover)
                            : Image.file(
                                File(_image!.path),
                                width: 94,
                                height: 94,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    InputTextField(
                      labelText: "Name",
                      hint: "Set a name for the Organization",
                      onChanged: (onChanged) {
                        orgName = onChanged;
                      },
                    ),
                    InputTextField(
                      labelText: "Email",
                      hint: "Organization Email address",
                      textInputType: TextInputType.emailAddress,
                      onChanged: (onChanged) {
                        orgEmail = onChanged;
                      },
                    ),
                    InputLargeTextField(
                        hint: "Write about the Organization",
                        label: "Description",
                        controller: _deskText,
                        maxLength: 200)
                  ],
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
