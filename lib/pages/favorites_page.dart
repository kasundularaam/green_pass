import 'package:green_pass/models/event_model.dart';
import 'package:green_pass/models/favorites_model.dart';
import 'package:green_pass/services/favorites_service.dart';
import 'package:green_pass/widgets/event_card.dart';
import 'package:green_pass/widgets/list_listener.dart';
import 'package:flutter/material.dart';

import '../Services/event_service.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        title: Text(
          "Favorites",
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: ListListener<FavoriteEvent>(
          listener: FavoritesService(),
          itemBuilder: (item) => FutureBuilder<Event>(
              future: EventService.getEventById(item.eventID),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return EventCard(event: snapshot.data!);
                }
                return const Text("Loading...");
              }),
        ),
      ),
    );
  }
}
