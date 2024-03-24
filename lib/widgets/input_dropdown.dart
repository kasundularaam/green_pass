import 'package:flutter/material.dart';

class InputDropDown extends StatelessWidget {
  final String? selectedValue;
  final List<String> itemsList;
  final String labelText;
  final Function(String) onChanged;
  const InputDropDown({
    Key? key,
    this.selectedValue,
    required this.itemsList,
    required this.labelText,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please fill this field';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
      ),
      items: itemsList.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (value) => onChanged(value ?? itemsList.first),
    );
  }
}
