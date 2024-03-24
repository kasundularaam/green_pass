import 'package:green_pass/models/failure.dart';

import '../models/ticket_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TicketService {
  static Future<void> addTicket(
    String eventId,
    String ticketName,
    double ticketPrice,
    int ticketCount,
  ) async {
    try {
      final doc = FirebaseFirestore.instance.collection('ticket').doc();
      await doc.set({
        'id': doc.id,
        'eventId': eventId,
        'ticketName': ticketName,
        'ticketPrice': ticketPrice,
        'ticketCount': ticketCount,
      });
    } on FirebaseException catch (e) {
      throw Failure(message: e.message ?? "Failed to add ticket");
    } catch (e) {
      throw Failure(message: "Failed to add ticket");
    }
  }

  static Stream<List<Ticket>> getTicketsByEventId(
      {required String eventId}) async* {
    final ticketsCollection = FirebaseFirestore.instance
        .collection('ticket')
        .where("eventId", isEqualTo: eventId);

    try {
      yield* ticketsCollection.snapshots().map((snapshot) {
        return snapshot.docs.map((e) => Ticket.fromMap(e.data())).toList();
      });
    } on FirebaseException catch (e) {
      throw Failure(message: e.message ?? "Failed to load tickets");
    } catch (e) {
      throw Failure(message: "Failed to load tickets");
    }
  }

  static Future<Ticket> getTicketById(id) async {
    try {
      final DocumentSnapshot userSnapshot =
          await FirebaseFirestore.instance.collection('ticket').doc(id).get();

      final Map<String, dynamic> ticketData =
          userSnapshot.data() as Map<String, dynamic>;

      final Ticket ticket = Ticket.fromMap(ticketData);

      return ticket;
    } on FirebaseException catch (e) {
      throw Failure(message: e.message ?? "Failed to load ticket");
    } catch (e) {
      throw Failure(message: "Failed to load ticket");
    }
  }

  static Future<List<Ticket>> getAllTicketsByEventID(String id) async {
    try {
      final ticketsCollection = FirebaseFirestore.instance.collection('ticket');
      final querySnapshot =
          await ticketsCollection.where("eventId", isEqualTo: id).get();
      final List<Ticket> tickets =
          querySnapshot.docs.map((doc) => Ticket.fromMap(doc.data())).toList();
      return tickets;
    } on FirebaseException catch (e) {
      throw Failure(message: e.message ?? "Failed to load tickets");
    } catch (e) {
      throw Failure(message: "Failed to load tickets");
    }
  }
}
