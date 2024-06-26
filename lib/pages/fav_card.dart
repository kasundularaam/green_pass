import 'package:flutter/material.dart';

import 'package:green_pass/models/favorites_model.dart';

class FavoriteCard extends StatefulWidget {
  final FavoriteEvent favorites;
  const FavoriteCard({
    super.key,
    required this.favorites,
  });

  @override
  State<FavoriteCard> createState() => _FavoriteCardState();
}

class _FavoriteCardState extends State<FavoriteCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [Text(widget.favorites.eventID)],
      ),
    );
  }
}
