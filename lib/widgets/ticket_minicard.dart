import '../models/booking_model.dart';
import '../models/event_model.dart';
import '../models/ticket_model.dart';
import '../pages/ticket_page.dart';
import '../services/event_service.dart';
import '../services/ticket_service.dart';
import 'package:flutter/material.dart';

class TicketMiniCard extends StatelessWidget {
  final Booking booking;
  const TicketMiniCard({
    super.key,
    required this.booking,
  });

  @override
  Widget build(BuildContext context) {
    const double borderRadius = 12.0;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: FutureBuilder<Ticket>(
        future: TicketService.getTicketById(booking.ticketID),
        builder: (context, ticketSnapshot) {
          if (ticketSnapshot.hasData) {
            final ticket = ticketSnapshot.data;
            if (ticket == null) {
              return const Text("Ticket not found");
            }
            return FutureBuilder<Event>(
              future: EventService.getEventById(ticket.eventId),
              builder: (context, eventSnapshot) {
                if (eventSnapshot.hasData) {
                  final event = eventSnapshot.data;
                  if (event == null) {
                    return const Text("Event not found");
                  }
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => TicketPage(
                              event: event, booking: booking, ticket: ticket),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(borderRadius),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(borderRadius),
                        border: Border.all(
                          color: Theme.of(context)
                              .colorScheme
                              .outlineVariant, // Change the border color as needed
                          width: 1.0, // Adjust the border width as needed
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  event.title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface),
                                ),
                                Text(
                                  ticket.ticketName,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface),
                                ),
                              ],
                            ),
                          ),
                          Image.network(
                            event.imageUrl.isNotEmpty
                                ? event.imageUrl
                                : "https://images.unsplash.com/photo-1492684223066-81342ee5ff30?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                            fit: BoxFit.cover,
                            height: 50,
                            width: 50,
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(borderRadius),
                    color: Theme.of(context).colorScheme.outlineVariant,
                  ),
                );
              },
            );
          }
          return Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
          );
        },
      ),
    );
  }
}
