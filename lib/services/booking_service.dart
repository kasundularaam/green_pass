import 'package:green_pass/models/booking_model.dart';
import 'package:green_pass/models/failure.dart';
import 'package:green_pass/services/i_listener.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'user_service.dart';

class BookingService implements IListener {
  static Future<void> addBooking(
    String ticketID,
    int quantity,
  ) async {
    try {
      final userId = UserService.getUserId();
      final doc = FirebaseFirestore.instance.collection('booking').doc();
      await doc.set({
        'id': doc.id,
        'userID': userId,
        'ticketID': ticketID,
        'quantity': quantity,
      });
    } on FirebaseException catch (e) {
      throw Failure(message: e.message ?? "Failed to add booking");
    } catch (e) {
      throw Failure(message: "Failed to add booking");
    }
  }

  static Future<List<Booking>> getBookingsByUser() async {
    try {
      final userId = UserService.getUserId();

      final userSnapshot = await FirebaseFirestore.instance
          .collection('booking')
          .where("userID", isEqualTo: userId)
          .get();

      return userSnapshot.docs.map((e) => Booking.fromMap(e.data())).toList();
    } on FirebaseException catch (e) {
      throw Failure(message: e.message ?? "Failed to load bookings");
    } catch (e) {
      throw Failure(message: "Failed to load bookings");
    }
  }

  @override
  Stream<List<Booking>> listenToList() async* {
    final userId = UserService.getUserId();

    final collection = await FirebaseFirestore.instance
        .collection('booking')
        .where("userID", isEqualTo: userId);

    yield* collection.snapshots().map((snapshot) {
      return snapshot.docs.map((e) => Booking.fromMap(e.data())).toList();
    }).handleError((e) {
      throw Failure(message: e.message ?? "Failed to load bookings");
    });
  }
}
