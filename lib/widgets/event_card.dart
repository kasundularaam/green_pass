import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:green_pass/models/organization_model.dart';
import 'package:green_pass/models/ticket_model.dart';
import 'package:green_pass/models/user_model.dart';
import 'package:green_pass/pages/buy%20Ticket_page.dart';
import 'package:green_pass/pages/organization_info_page.dart';
import 'package:green_pass/services/favorites_service.dart';
import 'package:green_pass/services/organization_service.dart';
import 'package:green_pass/services/ticket_service.dart';
import 'package:green_pass/services/user_service.dart';
import 'package:green_pass/widgets/free_event_row.dart';
import 'package:green_pass/widgets/paid_event_row.dart';

import '../models/event_model.dart';

class EventCard extends StatefulWidget {
  final Event event;
  const EventCard({
    super.key,
    required this.event,
  });

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  Organization? organization;
  bool isFavorite = false;
  DateTime get dateTime =>
      DateTime.fromMillisecondsSinceEpoch(widget.event.time);
  String get formattedDate => formatTimestampDate(widget.event.time);
  String get formattedTime => formatTimestampTime(widget.event.time);

  String formatTimestampDate(int timestamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    String formattedDate = DateFormat('d MMMM yyyy').format(dateTime);
    return ' $formattedDate';
  }

  String formatTimestampTime(int timestamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    String formattedTime = DateFormat('hh:mm a').format(dateTime);
    return formattedTime;
  }

  Ticket getMinimumTicket(List<Ticket> tickets) {
    Ticket min = tickets[0];
    for (Ticket ticket in tickets) {
      if (ticket.ticketPrice < min.ticketPrice) {
        min = ticket;
      }
    }
    return min;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Theme.of(context).colorScheme.outline,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: Column(
          children: [
            ListTile(
              trailing: FavoriteIcon(
                eventID: widget.event.id,
                isFavorite: isFavorite, // Replace with your actual condition
                onToggle: (isFav) {
                  setState(() {
                    isFavorite =
                        isFav; // Update the condition when the icon is toggled
                  });
                },
              ),
              leading: FutureBuilder<Organization?>(
                  future: OrganizationService.getOrganizationByUserId(
                      widget.event.userId),
                  builder: (context, orgSnapshot) {
                    if (orgSnapshot.hasError) {
                      return Text(orgSnapshot.error.toString());
                    }
                    if (orgSnapshot.hasData) {
                      organization = orgSnapshot.data!;
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OrganizationInfoPage(
                                      organization: orgSnapshot.data!,
                                    )),
                          );
                        },
                        child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(25)),
                            child: Image.network(
                              orgSnapshot.data!.imageUrl.isEmpty
                                  ? "https://cdn-icons-png.flaticon.com/512/3985/3985166.png"
                                  : orgSnapshot.data!.imageUrl,
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover,
                            )),
                      );
                    }
                    return const CircularProgressIndicator();
                  }),
              title: FutureBuilder<Organization?>(
                  future: OrganizationService.getOrganizationByUserId(
                      widget.event.userId),
                  builder: (context, orgSnapshot) {
                    if (orgSnapshot.hasData) {
                      return Text(
                        orgSnapshot.data!.orgName,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface),
                      );
                    }
                    return const Text("Loading...");
                  }),
              subtitle: Row(
                children: [
                  FutureBuilder<User>(
                    future: UserService.getUserById(widget.event.userId),
                    builder: (context, snapshot) {
                      log(snapshot.toString());
                      if (snapshot.hasData) {
                        return Text(
                          snapshot.data!.name,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant),
                        );
                      }
                      return const Text("Loading");
                    },
                  ),
                  Text(
                    ' | $formattedTime',
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Image.network(
                  widget.event.imageUrl.isNotEmpty
                      ? widget.event.imageUrl
                      : "https://images.unsplash.com/photo-1492684223066-81342ee5ff30?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                  height: 152,
                  width: 356,
                  fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(widget.event.title,
                      style: Theme.of(context).textTheme.headlineMedium),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "📅 Date : $formattedDate",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant),
                      ),
                      Text(
                        "⏰ Time : $formattedTime",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant),
                      ),
                      Text(
                        "📍 Venue : ${widget.event.venue}",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                widget.event.desc,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant),
              ),
            ),
            FutureBuilder(
                future: TicketService.getAllTicketsByEventID(widget.event.id),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isEmpty) {
                      return FreeEventRow(onPressed: () {});
                    }
                    return PaidEventRow(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BuyTicketPage(
                                    event: widget.event,
                                    tickets: snapshot.data!,
                                  )),
                        );
                      },
                      ticket: getMinimumTicket(snapshot.data!),
                    );
                  }
                  return const Text("Loading");
                })
          ],
        ),
      ),
    );
  }
}

class FavoriteIcon extends StatefulWidget {
  final bool isFavorite;
  final Function(bool) onToggle;
  final String eventID;
  const FavoriteIcon({
    super.key,
    required this.isFavorite,
    required this.onToggle,
    required this.eventID,
  });

  @override
  State<FavoriteIcon> createState() => _FavoriteIconState();
}

class _FavoriteIconState extends State<FavoriteIcon> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onToggle(!widget.isFavorite);
        if (widget.isFavorite) {
          // Remove from favorites
          // You can add the removal logic here
        } else {
          FavoritesService.addFavorite(widget.eventID);
          // Add to favorites
// Call your addFavorite function
        }
      },
      child: Icon(
        widget.isFavorite ? Icons.star : Icons.star_border,
        color: widget.isFavorite ? Theme.of(context).colorScheme.primary : null,
      ),
    );
  }
}
