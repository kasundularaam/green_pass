import 'package:green_pass/models/booking_model.dart';
import 'package:green_pass/models/event_model.dart';
import 'package:green_pass/models/ticket_model.dart';
import 'package:flutter/material.dart';

import '../widgets/ticket.dart';

class TicketPage extends StatelessWidget {
  final Event event;
  final Booking booking;
  final Ticket ticket;
  const TicketPage({
    Key? key,
    required this.event,
    required this.booking,
    required this.ticket,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        title: Text(
          "Ticket Information",
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(23.0),
        child: TicketWidget(
          event: event,
          booking: booking,
          ticket: ticket,
        ),
      ),
    );
  }
}
