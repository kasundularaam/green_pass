import 'package:green_pass/pages/navigation_page.dart';
import 'package:green_pass/services/ticket_service.dart';
import 'package:flutter/material.dart';

import '../models/ticket_model.dart';
import '../sources/ticket_data.dart';
import '../widgets/add_tickets_dialog.dart';
import '../widgets/ticket_card.dart';

class AddTicket extends StatefulWidget {
  // final Event event;
  final String eventId;
  const AddTicket({
    super.key,
    required this.eventId,
    // required this.event,
  });

  @override
  State<AddTicket> createState() => _AddTicketState();
}

class _AddTicketState extends State<AddTicket> {
  void _addTicket(Ticket newTicket) {
    setState(() {
      ticketsList.add(newTicket); // Add the ticket to the ticketsList
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        title: Text(
          "Add tickets",
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NavigationPage()),
              );
            },
            child: Text(
              "Publish",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Theme.of(context).colorScheme.primary),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: StreamBuilder<List<Ticket>>(
          stream: TicketService.getTicketsByEventId(eventId: widget.eventId),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            print(snapshot);
            if (snapshot.hasData) {
              final List<Ticket> tickets = snapshot.data!;

              return ListView.builder(
                  itemCount: tickets.length,
                  itemBuilder: (context, index) {
                    return TicketCard(
                      ticket: tickets[index],
                      eventId: widget.eventId,
                    );
                  });
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AddTicketDialog(
                onTicketAdded: _addTicket,
                eventId: widget.eventId,
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
