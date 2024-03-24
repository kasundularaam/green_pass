import 'package:flutter/material.dart';

class FreeEventRow extends StatelessWidget {
  final VoidCallback onPressed;
  const FreeEventRow({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: TextButton(
            onPressed: () {},
            child: const Text('Free Registration '),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: FilledButton(
            onPressed: onPressed,
            child: const Text('Register'),
          ),
        ),
      ],
    );
  }
}
