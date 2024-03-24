import 'package:flutter/material.dart';

class TimePickerTextField extends StatefulWidget {
  final String hint;
  final Function(TimeOfDay)? onTimePicked;
  const TimePickerTextField({
    Key? key,
    required this.hint,
    this.onTimePicked,
  }) : super(key: key);

  @override
  State<TimePickerTextField> createState() => _TimePickerTextFieldState();
}

class _TimePickerTextFieldState extends State<TimePickerTextField> {
  final TextEditingController _timeController = TextEditingController();
  TimeOfDay selectedTime = TimeOfDay.now();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 174,
      child: TextFormField(
        controller: _timeController,
        readOnly: true,
        onTap: _selectTime,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please fill this field';
          }
          return null;
        },
        decoration: InputDecoration(
          suffixIcon: const Icon(Icons.access_time),
          border: const OutlineInputBorder(),
          labelText: widget.hint,
        ),
      ),
    );
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null) {
      _timeController.text = picked.format(context);

      if (widget.onTimePicked != null) {
        widget.onTimePicked!(picked);
      }
    }
  }

  @override
  void dispose() {
    _timeController.dispose();
    super.dispose();
  }
}
