import 'dart:convert';

class User {
  final int? userId;
  final int? id;
  final String? title; // Changed from int?
  final int? body;

  const User({
    this.userId,
    this.id,
    this.title, // Changed from int?
    this.body,
  });

  User copyWith({
    int? userId,
    int? id,
    String? title, // Changed from int?
    int? body,
  }) {
    return User(
      userId: userId ?? this.userId,
      id: id ?? this.id,
      title: title ?? this.title, // Logic remains the same
      body: body ?? this.body,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
      'body': body,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userId: map['userId'] != null ? map['userId'] as int : null,
      id: map['id'] != null ? map['id'] as int : null,
      // Updated parsing logic for String
      title: map['title'] != null ? map['title'] as String : null,
      body: map['body'] != null ? map['body'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(userId: $userId, id: $id, title: $title, body: $body)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is User &&
      other.userId == userId &&
      other.id == id &&
      other.title == title && // Works for String comparison
      other.body == body;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
      id.hashCode ^
      title.hashCode ^ // Works for String hashCode
      body.hashCode;
  }
}