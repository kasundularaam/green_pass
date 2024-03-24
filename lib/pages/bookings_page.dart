import 'package:green_pass/services/booking_service.dart';
import 'package:green_pass/widgets/list_listener.dart';
import 'package:flutter/material.dart';
import '../widgets/ticket_minicard.dart';

class BookingsPage extends StatelessWidget {
  const BookingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        title: Text(
          "Bookings",
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: ListListener(
          listener: BookingService(),
          itemBuilder: (item) => TicketMiniCard(
            booking: item,
          ),
        ),
      ),
    );
  }
}
