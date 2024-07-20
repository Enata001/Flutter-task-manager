import 'dart:convert';

class Userdata {
  final int id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String gender;
  final String? image;

  const Userdata({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.gender,
    this.image,
  });

  @override
  bool operator ==(covariant other) =>
      identical(this, other) ||
      (other is Userdata &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          username == other.username &&
          email == other.email &&
          firstName == other.firstName &&
          lastName == other.lastName &&
          gender == other.gender &&
          image == other.image);

  @override
  int get hashCode =>
      id.hashCode ^
      username.hashCode ^
      email.hashCode ^
      firstName.hashCode ^
      lastName.hashCode ^
      gender.hashCode ^
      image.hashCode;

  @override
  String toString() {
    return jsonEncode(toMap());
  }

  Userdata copyWith({
    int? id,
    String? username,
    String? email,
    String? firstName,
    String? lastName,
    String? gender,
    String? image,
  }) {
    return Userdata(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      gender: gender ?? this.gender,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'gender': gender,
      'image': image,
    };
  }

  factory Userdata.fromMap(Map<String, dynamic> map) {
    return Userdata(
      id: map['id'],
      username: map['username'],
      email: map['email'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      gender: map['gender'],
      image: map['image'],
    );
  }

  factory Userdata.fromString(String? text) {
    return Userdata.fromMap(jsonDecode(text ?? "{}"));
  }
}
