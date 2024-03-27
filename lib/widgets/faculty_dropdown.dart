import 'package:flutter/material.dart';
import 'package:green_pass/widgets/input_dropdown.dart';

class FacultyDropdown extends StatelessWidget {
  final String? selectedValue;
  final Function(String) onChanged;
  const FacultyDropdown(
      {super.key, this.selectedValue, required this.onChanged});

  static const List<String> _facultyList = [
    "Faculty Of Business",
    "Faculty Of Computing",
    "Faculty Of Engineering"
  ];

  @override
  Widget build(BuildContext context) {
    return InputDropDown(
        itemsList: _facultyList,
        labelText: "Your Faculty",
        selectedValue: selectedValue,
        onChanged: onChanged);
  }
}
