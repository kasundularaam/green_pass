import 'package:green_pass/models/failure.dart';
import 'package:green_pass/services/event_service.dart';
import 'package:flutter/material.dart';

import '../models/event_model.dart';
import '../models/ticket_model.dart';

class TicketCard extends StatelessWidget {
  // final Event event;
  final String eventId;
  final Ticket ticket;
  const TicketCard({
    Key? key,
    // required this.event,
    required this.ticket,
    required this.eventId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context)
              .colorScheme
              .outlineVariant, // Change the border color as needed
          width: 1.0,
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 11.0),
                  child: FutureBuilder<Event>(
                      future: EventService.getEventById(eventId),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          final err = snapshot.error;
                          if (err is Failure) {
                            return Text(err.message);
                          }
                        }
                        if (snapshot.hasData) {
                          return Text(
                            snapshot.data!.title,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface),
                          );
                        }
                        return const Text("Loading..");
                      }),
                ),
                Text(
                  "Ticket Count : ${ticket.ticketCount}",
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17.0),
            child: Container(
              height: 1,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context)
                      .colorScheme
                      .outlineVariant, // Change the border color as needed
                  width: 1.0,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(
                    ticket.ticketName,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface),
                  ),
                ),
                Text(
                  "LKR ${ticket.ticketPrice.toString()}",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
