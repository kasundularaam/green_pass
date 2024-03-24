import 'package:flutter/material.dart';
// import 'package:flutter_month_picker/flutter_month_picker.dart';

class MonthPickerTextfield extends StatefulWidget {
  final String hint;
  final Function(DateTime)? onDatePicked;
  const MonthPickerTextfield({
    Key? key,
    required this.hint,
    this.onDatePicked,
  }) : super(key: key);

  @override
  State<MonthPickerTextfield> createState() => _DatePickerTextFieldState();
}

class _DatePickerTextFieldState extends State<MonthPickerTextfield> {
  final TextEditingController _dateController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 174,
      child: TextFormField(
        controller: _dateController,
        readOnly: true,
        // onTap: _selectDate,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please fill this field';
          }
          return null;
        },
        decoration: InputDecoration(
          suffixIcon: const Icon(Icons.today),
          border: const OutlineInputBorder(),
          labelText: widget.hint,
        ),
      ),
    );
  }

  // Future<void> _selectDate() async {
  //   final DateTime? picked = await showMonthPicker(
  //       context: context,
  //       initialDate: selectedDate,
  //       firstDate: DateTime(2020),
  //       lastDate: DateTime(2025));
  //   if (picked != null) {
  //     _dateController.text = picked.toLocal().toString().split(' ')[0];

  //     if (widget.onDatePicked != null) {
  //       widget.onDatePicked!(picked);
  //     }
  //   }
  // }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }
}
