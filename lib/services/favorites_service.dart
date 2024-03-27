// import 'package:green_pass/models/event_model.dart';
import 'package:green_pass/models/failure.dart';
import 'package:green_pass/models/favorites_model.dart';
import 'package:green_pass/services/i_listener.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'user_service.dart';

class FavoritesService implements IListener<FavoriteEvent> {
  static Future<void> addFavorite(
    String EventID,
  ) async {
    try {
      final userID = UserService.getUserId();
      final doc = FirebaseFirestore.instance.collection('favorites').doc();
      await doc.set({
        'id': doc.id,
        'userID': userID,
        'eventID': EventID,
      });
    } on FirebaseException catch (e) {
      throw Failure(message: e.message ?? "Failed to add favorite");
    } catch (e) {
      throw e.toString();
    }
  }

  static Future<void> removeFavorite(String id) async {
    try {
      await FirebaseFirestore.instance.collection('favorites').doc(id).delete();
    } on FirebaseException catch (e) {
      throw Failure(message: e.message ?? "Failed to remove favorite");
    } catch (e) {
      throw e.toString();
    }
  }

  static Future<FavoriteEvent> getFavorites() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      final favorites = await firestore.collection('favorites').doc().get();
      return FavoriteEvent.fromMap(favorites.data() as Map<String, dynamic>);
    } on FirebaseException catch (e) {
      throw Failure(message: e.message ?? "Failed to load favorites");
    } catch (e) {
      throw e.toString();
    }
  }

  static Future<List<FavoriteEvent>> getFavoritesByUser() async {
    try {
      final userId = UserService.getUserId();

      final userSnapshot = await FirebaseFirestore.instance
          .collection('favorites')
          .where("userID", isEqualTo: userId)
          .get();

      return userSnapshot.docs
          .map((e) => FavoriteEvent.fromMap(e.data()))
          .toList();
    } on FirebaseException catch (e) {
      throw Failure(message: e.message ?? "Failed to load favorites");
    } catch (e) {
      throw e.toString();
    }
  }

  static Future<FavoriteEvent> getFavoritesByID(id) async {
    try {
      final DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('favorites')
          .doc(id)
          .get();

      final Map<String, dynamic> favoritesData =
          snapshot.data() as Map<String, dynamic>;

      final FavoriteEvent favorites = FavoriteEvent.fromMap(favoritesData);

      return favorites;
    } on FirebaseException catch (e) {
      throw Failure(message: e.message ?? "Failed to load favorites");
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Stream<List<FavoriteEvent>> listenToList() async* {
    final userId = UserService.getUserId();
    final eventsCollection = FirebaseFirestore.instance
        .collection('favorites')
        .where("userID", isEqualTo: userId);
    yield* eventsCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((e) => FavoriteEvent.fromMap(e.data())).toList();
    }).handleError((e) {
      throw Failure(message: e.message ?? "Failed to load events");
    });
  }
}
