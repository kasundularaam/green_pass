// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FavoriteEvent {
  final String id;
  final String userID;
  final String eventID;
  FavoriteEvent({
    required this.id,
    required this.userID,
    required this.eventID,
  });

  FavoriteEvent copyWith({
    String? id,
    String? userID,
    String? eventID,
  }) {
    return FavoriteEvent(
      id: id ?? this.id,
      userID: userID ?? this.userID,
      eventID: eventID ?? this.eventID,
    );
  }

  factory FavoriteEvent.withEvent({required String eventID}) {
    return FavoriteEvent(id: '', userID: '', eventID: eventID);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userID': userID,
      'eventID': eventID,
    };
  }

  factory FavoriteEvent.fromMap(Map<String, dynamic> map) {
    return FavoriteEvent(
      id: map['id'] as String,
      userID: map['userID'] as String,
      eventID: map['eventID'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FavoriteEvent.fromJson(String source) =>
      FavoriteEvent.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'FavoriteEvent(id: $id, userID: $userID, eventID: $eventID)';

  @override
  bool operator ==(covariant FavoriteEvent other) {
    if (identical(this, other)) return true;

    return other.id == id && other.userID == userID && other.eventID == eventID;
  }

  @override
  int get hashCode => id.hashCode ^ userID.hashCode ^ eventID.hashCode;
}
