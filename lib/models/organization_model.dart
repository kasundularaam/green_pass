import 'dart:convert';

class Organization {
  final String orgId;
  final String orgName;
  final String orgDesc;
  final String imageUrl;
  final String userId;
  final String orgEmail;

  Organization({
    required this.orgId,
    required this.orgName,
    required this.orgDesc,
    required this.imageUrl,
    required this.userId,
    required this.orgEmail,
  });

  Organization copyWith({
    String? orgId,
    String? orgName,
    String? orgDesc,
    String? imageUrl,
    String? userId,
    String? orgEmail,
  }) {
    return Organization(
      orgId: orgId ?? this.orgId,
      orgName: orgName ?? this.orgName,
      orgDesc: orgDesc ?? this.orgDesc,
      imageUrl: imageUrl ?? this.imageUrl,
      userId: userId ?? this.userId,
      orgEmail: orgEmail ?? this.orgEmail,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'orgId': orgId,
      'orgName': orgName,
      'orgDesc': orgDesc,
      'imageUrl': imageUrl,
      'userId': userId,
      'orgEmail': orgEmail,
    };
  }

  factory Organization.fromMap(Map<String, dynamic> map) {
    return Organization(
      orgId: map['orgId'] ?? '',
      orgName: map['orgName'] ?? '',
      orgDesc: map['orgDesc'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      userId: map['userId'] ?? '',
      orgEmail: map['orgEmail'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Organization.fromJson(String source) =>
      Organization.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Organization(orgId: $orgId, orgName: $orgName, orgDesc: $orgDesc, imageUrl: $imageUrl, userId: $userId, orgEmail: $orgEmail)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Organization &&
        other.orgId == orgId &&
        other.orgName == orgName &&
        other.orgDesc == orgDesc &&
        other.imageUrl == imageUrl &&
        other.userId == userId &&
        other.orgEmail == orgEmail;
  }

  @override
  int get hashCode {
    return orgId.hashCode ^
        orgName.hashCode ^
        orgDesc.hashCode ^
        imageUrl.hashCode ^
        userId.hashCode ^
        orgEmail.hashCode;
  }
}
