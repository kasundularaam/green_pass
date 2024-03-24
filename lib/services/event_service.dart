import 'dart:convert';
import 'dart:io';

import 'package:green_pass/models/failure.dart';
import 'package:green_pass/services/i_listener.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/event_model.dart';
import '../sources/fake_events.dart';

class EventService implements IListener<Event> {
  static Future<List<Event>> getAll() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      final List<dynamic> res = json.decode(eventRes);
      final List<Event> events =
          res.map((e) => Event.fromMap(e as Map<String, dynamic>)).toList();
      return events;
    } on FirebaseException catch (e) {
      throw Failure(message: e.message ?? "Failed to load events");
    } catch (e) {
      throw Failure(message: "Failed to load events");
    }
  }

  static Future<String> addEvent(
    String userId,
    String title,
    int timeStamp,
    String venue,
    String desc,
    bool isFree,
    String link,
    String imageUrl,
  ) async {
    try {
      final doc = FirebaseFirestore.instance.collection('event').doc();
      String downloadUrl = "";
      if (imageUrl.isNotEmpty) {
        final storageRef =
            FirebaseStorage.instance.ref().child('event_media/$doc.id');
        storageRef.putFile(File(imageUrl));
        downloadUrl = await storageRef.getDownloadURL();
      }
      await doc.set({
        'id': doc.id,
        'userId': userId,
        'title': title,
        'image': doc.id, // Use the document ID as the image identifier
        'time': timeStamp,
        'venue': venue,
        'desc': desc,
        'isFree': isFree,
        'link': link,
        'imageUrl': downloadUrl, // Store the image URL
        // Use server timestamp for createdAt
      });
      return doc.id;
    } on FirebaseException catch (e) {
      throw Failure(message: e.message ?? "Failed to add event");
    } catch (e) {
      throw Failure(message: "Failed to add event");
    }
  }

  static Future<Event> getEventById(String id) async {
    try {
      print(id);
      final DocumentSnapshot userSnapshot =
          await FirebaseFirestore.instance.collection('event').doc(id).get();

      final Map<String, dynamic> eventData =
          userSnapshot.data() as Map<String, dynamic>;

      final Event event = Event.fromMap(eventData);

      return event;
    } on FirebaseException catch (e) {
      throw Failure(message: e.message ?? "Failed to load the event");
    } catch (e) {
      throw Failure(message: "Failed to load the event");
    }
  }

  @override
  Stream<List<Event>> listenToList() async* {
    final eventsCollection = FirebaseFirestore.instance.collection('event');

    yield* eventsCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((e) => Event.fromMap(e.data())).toList();
    }).handleError((e) {
      throw Failure(message: e.message ?? "Failed to load events");
    });
  }
}
