import 'package:flutter/material.dart';

class InputLargeTextField extends StatefulWidget {
  final TextEditingController? controller;
  final int maxLength;
  final String hint;
  final String label;
  const InputLargeTextField({
    super.key,
    this.controller,
    required this.maxLength,
    required this.hint,
    required this.label,
  });

  @override
  State<InputLargeTextField> createState() => _InputLargeTextFieldState();
}

class _InputLargeTextFieldState extends State<InputLargeTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) {
        setState(() {});
      },
      controller: widget.controller,
      maxLength: widget.maxLength,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      decoration: InputDecoration(
        suffixText: '${widget.controller?.text.length}/${widget.maxLength}',
        suffixStyle: TextStyle(
          color: widget.controller?.text.length == widget.maxLength
              ? Theme.of(context).colorScheme.error
              : Theme.of(context).colorScheme.outlineVariant,
        ),
        border: const OutlineInputBorder(),
        counterText: '',
        hintText: widget.hint,
        labelText: widget.label,
      ),
    );
  }
}
