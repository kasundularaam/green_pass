import 'package:green_pass/models/ticket_model.dart';
import 'package:flutter/material.dart';

class PaidEventRow extends StatelessWidget {
  final VoidCallback onPressed;
  final Ticket ticket;

  const PaidEventRow(
      {super.key, required this.onPressed, required this.ticket});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: TextButton(
            onPressed: () {},
            child: Text("LKR ${ticket.ticketPrice.toInt().toString()} +"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: FilledButton(
            onPressed: onPressed,
            child: const Text('Buy Ticket'),
          ),
        ),
      ],
    );
  }
}
