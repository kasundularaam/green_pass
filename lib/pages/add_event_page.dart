import 'dart:io';

import 'package:green_pass/pages/navigation_page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../pages/add_tickets.dart';
import '../Services/event_service.dart';
import '../Services/user_service.dart';
import '../widgets/custom_filled_button.dart';
import '../widgets/date_picker_textfield.dart';
import '../widgets/input_large_textfield.dart';
import '../widgets/input_textfield.dart';
import '../widgets/time_picker_textfield.dart';

class AddEventPage extends StatefulWidget {
  const AddEventPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final _formKey = GlobalKey<FormState>();
  String eventUrl = "";
  String eventTitle = '';
  late TimeOfDay eventTime;
  late DateTime eventDate;
  String eventVenue = '';
  final TextEditingController _descText = TextEditingController();
  String eventLink = '';
  XFile? _image;

  String buttonText = "Add Event";
  List<bool> isSelected = [false, true]; // Free by default
  bool isPaidEvent = false;

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

  int get combinedDateTime => DateTime(
        eventDate.year,
        eventDate.month,
        eventDate.day,
        eventTime.hour,
        eventTime.minute,
      ).millisecondsSinceEpoch;

  String _getImagePath(XFile? image) {
    if (image != null) {
      return image.path;
    }
    return "";
  }

  @override
  void dispose() {
    _descText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        title: Text(
          "Add Event",
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            InkWell(
              onTap: _getImageFromGallery,
              child: _image == null
                  ? Image.asset(
                      'lib/assets/Group 9.png',
                      width: 412,
                      height: 150,
                    )
                  : Image.file(
                      File(_image!.path),
                      width: 412,
                      height: 149,
                      fit: BoxFit.cover,
                    ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: OverflowBar(
                  overflowSpacing: 15,
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: ToggleButtons(
                          borderRadius: BorderRadius.circular(24),
                          borderWidth: 2,
                          borderColor:
                              Theme.of(context).colorScheme.outlineVariant,
                          isSelected: isSelected,
                          onPressed: (int index) {
                            setState(() {
                              for (int buttonIndex = 0;
                                  buttonIndex < isSelected.length;
                                  buttonIndex++) {
                                if (buttonIndex == index) {
                                  isSelected[buttonIndex] = true;
                                } else {
                                  isSelected[buttonIndex] = false;
                                }
                              }

                              isPaidEvent = isSelected[1];
                              if (isPaidEvent) {}
                            });
                          },
                          children: const [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 50),
                              child: Text('Free'),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 50),
                              child: Text('Paid'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InputTextField(
                      labelText: "Event Title",
                      hint: "Give a title to the event",
                      isPassword: false,
                      onChanged: (text) {
                        eventTitle = text;
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TimePickerTextField(
                          hint: "TIme",
                          onTimePicked: (pickedTime) {
                            eventTime = pickedTime;
                          },
                        ),
                        const Spacer(),
                        DatePickerTextField(
                          hint: "Date",
                          onDatePicked: (pickedDate) {
                            eventDate = pickedDate;
                          },
                        )
                      ],
                    ),
                    InputTextField(
                      labelText: "Venue",
                      hint: "Enter the location ",
                      suffixIcon: Icons.location_on_outlined,
                      onChanged: (value) {
                        eventVenue = value;
                      },
                    ),
                    InputLargeTextField(
                      hint: "Give a short description about the event",
                      label: "Description",
                      controller: _descText,
                      maxLength: 250,
                    ),
                    InputTextField(
                      isEnabled: !isPaidEvent,
                      isOptional: true,
                      labelText: "Registration Link",
                      hint: "Paste Registration Link.",
                      suffixIcon: Icons.link,
                      onChanged: (value) {
                        eventLink = value;
                      },
                    ),
                    OverflowBar(
                      overflowSpacing: 7,
                      children: [
                        CustomFilledButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                final eventId = await EventService.addEvent(
                                  UserService.getUserId(),
                                  eventTitle,
                                  combinedDateTime,
                                  eventVenue,
                                  _descText.text,
                                  true,
                                  eventLink,
                                  _getImagePath(_image),
                                );
                                if (isPaidEvent) {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          AddTicket(eventId: eventId),
                                    ),
                                  );
                                } else {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const NavigationPage(),
                                    ),
                                  );
                                }
                              }
                            },
                            buttonText: buttonText),
                        const SizedBox(
                          height: 50,
                        )
                      ],
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
