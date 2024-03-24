import 'dart:convert';

class Booking {
  final String userID;
  final String ticketID;
  final int quantity;
  Booking({
    required this.userID,
    required this.ticketID,
    required this.quantity,
  });

  Booking copyWith({
    String? userID,
    String? ticketID,
    int? quantity,
  }) {
    return Booking(
      userID: userID ?? this.userID,
      ticketID: ticketID ?? this.ticketID,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userID': userID,
      'ticketID': ticketID,
      'quantity': quantity,
    };
  }

  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      userID: map['userID'] as String,
      ticketID: map['ticketID'] as String,
      quantity: map['quantity'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Booking.fromJson(String source) =>
      Booking.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Booking(userID: $userID, ticketID: $ticketID, quantity: $quantity)';

  @override
  bool operator ==(covariant Booking other) {
    if (identical(this, other)) return true;

    return other.userID == userID &&
        other.ticketID == ticketID &&
        other.quantity == quantity;
  }

  @override
  int get hashCode => userID.hashCode ^ ticketID.hashCode ^ quantity.hashCode;
}
