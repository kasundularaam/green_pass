import '../models/booking_model.dart';
import '../models/event_model.dart';
import '../models/ticket_model.dart';
import '../pages/ticket_page.dart';
import '../services/event_service.dart';
import '../services/ticket_service.dart';
import 'package:flutter/material.dart';

class TicketMiniCard extends StatefulWidget {
  final Booking booking;
  const TicketMiniCard({
    Key? key,
    required this.booking,
  }) : super(key: key);

  @override
  State<TicketMiniCard> createState() => _TicketMiniCardState();
}

class _TicketMiniCardState extends State<TicketMiniCard> {
  Event? event;
  Ticket? ticket;
  @override
  Widget build(BuildContext context) {
    const double borderRadius = 12.0;
    return GestureDetector(
      onTap: () {
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) => TicketPage(event: event),
        //   ),
        // );
      },
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => TicketPage(
                  event: event!, booking: widget.booking, ticket: ticket!),
            ),
          );
        },
        child: Container(
          height: 80,
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
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FutureBuilder<Ticket>(
                          future: TicketService.getTicketById(
                              widget.booking.ticketID),
                          builder: (context, ticketSnapshot) {
                            if (ticketSnapshot.hasData) {
                              ticket = ticketSnapshot.data;
                              return FutureBuilder<Event>(
                                future: EventService.getEventById(
                                    ticketSnapshot.data!.eventId),
                                builder: (context, eventSnapshot) {
                                  if (eventSnapshot.hasData) {
                                    event = eventSnapshot.data;
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 180),
                                          child: Column(
                                            children: [
                                              Text(
                                                eventSnapshot.data!.title,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium
                                                    ?.copyWith(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .onSurface),
                                              ),
                                              Text(
                                                ticketSnapshot.data!.ticketName,
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
                                          eventSnapshot.data!.imageUrl,
                                          fit: BoxFit.cover,
                                          height: 50,
                                          width: 50,
                                        ),
                                      ],
                                    );
                                  }
                                  return const Text("Loading");
                                },
                              );
                            }
                            return const Text("Loading");
                          },
                        ),
                      ],
                    ),
                  ),

                  // ClipRRect(
                  // borderRadius: const BorderRadius.only(
                  //     topRight: Radius.circular(borderRadius),
                  //     bottomRight: Radius.circular(borderRadius)),
                  // child: Image.network(
                  //   event!.imageUrl,
                  //   fit: BoxFit.cover,
                  //   height: 80,
                  //   width: 80,
                  // )),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
