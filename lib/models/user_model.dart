import 'dart:convert';

class User {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String faculty;
  final bool isAdmin;

  User(
    this.id,
    this.name,
    this.email,
    this.phone,
    this.faculty,
    this.isAdmin,
  );

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? faculty,
    bool? isAdmin,
  }) {
    return User(
      id ?? this.id,
      name ?? this.name,
      email ?? this.email,
      phone ?? this.phone,
      faculty ?? this.faculty,
      isAdmin ?? this.isAdmin,
    );
  }

  factory User.empty() {
    return User('', '', '', '', '', false);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'faculty': faculty,
      'isAdmin': isAdmin,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      map['id'] ?? '',
      map['name'] ?? '',
      map['email'] ?? '',
      map['phone'] ?? '',
      map['faculty'] ?? '',
      map['isAdmin'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, phone: $phone, faculty: $faculty, isAdmin: $isAdmin)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        other.phone == phone &&
        other.faculty == faculty &&
        other.isAdmin == isAdmin;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        phone.hashCode ^
        faculty.hashCode ^
        isAdmin.hashCode;
  }
}
