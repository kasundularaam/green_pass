// Event.dart

import 'dart:convert';

class Event {
  final String id;
  final String userId;
  final String title;
  final String imageUrl;
  final int time;
  final String venue;
  final String desc;
  final bool isFree;
  final String? link;
  Event({
    required this.id,
    required this.userId,
    required this.title,
    required this.imageUrl,
    required this.time,
    required this.venue,
    required this.desc,
    required this.isFree,
    this.link,
  });

  Event copyWith({
    String? id,
    String? userId,
    String? title,
    String? imageUrl,
    int? time,
    String? venue,
    String? desc,
    bool? isFree,
    String? link,
  }) {
    return Event(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      time: time ?? this.time,
      venue: venue ?? this.venue,
      desc: desc ?? this.desc,
      isFree: isFree ?? this.isFree,
      link: link ?? this.link,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'title': title,
      'imageUrl': imageUrl,
      'time': time,
      'venue': venue,
      'desc': desc,
      'isFree': isFree,
      'link': link,
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      id: map['id'] as String,
      userId: map['userId'] as String,
      title: map['title'] as String,
      imageUrl: map['imageUrl'] as String,
      time: map['time'] as int,
      venue: map['venue'] as String,
      desc: map['desc'] as String,
      isFree: map['isFree'] as bool,
      link: map['link'] != null ? map['link'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Event.fromJson(String source) =>
      Event.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Event(id: $id, userId: $userId, title: $title, imageUrl: $imageUrl, time: $time, venue: $venue, desc: $desc, isFree: $isFree, link: $link)';
  }

  @override
  bool operator ==(covariant Event other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.userId == userId &&
        other.title == title &&
        other.imageUrl == imageUrl &&
        other.time == time &&
        other.venue == venue &&
        other.desc == desc &&
        other.isFree == isFree &&
        other.link == link;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        title.hashCode ^
        imageUrl.hashCode ^
        time.hashCode ^
        venue.hashCode ^
        desc.hashCode ^
        isFree.hashCode ^
        link.hashCode;
  }
}
