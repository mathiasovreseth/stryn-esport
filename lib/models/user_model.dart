import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

/// {@template user}
/// User model
///
/// [User.empty] represents an unauthenticated user.
/// {@endtemplate}
class MyUser extends Equatable {
  final String id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final Timestamp? age;
  final String? address;
  final String? phoneNumber;
  final String? postNumber;
  final String? club;
  final bool? hasMembership;

  const MyUser({
    required this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.age,
    this.address,
    this.phoneNumber,
    this.postNumber,
    this.club,
    this.hasMembership,
  });

  /// Empty user which represents an unauthenticated user.
  static const empty = MyUser(id: '');

  @override
  List<Object?> get props => [
        id,
        email,
        firstName,
        lastName,
        age,
        address,
        phoneNumber,
        postNumber,
        club,
        hasMembership
      ];

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == MyUser.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != MyUser.empty;

  MyUser copyWith({
    String Function()? id,
    String Function()? email,
    String Function()? firstName,
    String Function()? lastName,
    Timestamp Function()? age,
    String Function()? address,
    String Function()? phoneNumber,
    String Function()? postNumber,
    String Function()? club,
    bool Function()? hasMembership,
  }) {
    return MyUser(
      id: id != null ? id() : this.id,
      email: email != null ? email() : this.email,
      firstName: firstName != null ? firstName() : this.firstName,
      lastName: lastName != null ? lastName() : this.lastName,
      age: age != null ? age() : this.age,
      address: address != null ? address() : this.address,
      phoneNumber: phoneNumber != null ? phoneNumber() : this.phoneNumber,
      postNumber: postNumber != null ? postNumber() : this.postNumber,
      club: club != null ? club() : this.club,
      hasMembership:
          hasMembership != null ? hasMembership() : this.hasMembership,
    );
  }

  MyUser.fromQueryDocumentSnapshot(DocumentSnapshot snapshot)
      : id = snapshot.id,
        email = snapshot.get('email') ?? "undefined",
        firstName = snapshot.get('firstName') ?? "undefined",
        lastName = snapshot.get('lastName') ?? "undefined",
        age = snapshot.get('birthDate') ?? Timestamp.now(),
        address = snapshot.get('address') ?? "undefined",
        phoneNumber = snapshot.get('phoneNumber') ?? "phoneNumber",
        postNumber = snapshot.get('postNumber') ?? "undefined",
        club = snapshot.get('club') ?? "Stryn",
        hasMembership = snapshot.get('hasMembership') ?? false;
}

/// template of what fields are required for updating a user document
/// used when editing a user
class UpdatedUser {
  final String id;
  final String? firstName;
  final String? lastName;
  final DateTime? age;
  final String? address;
  final String? phoneNumber;
  final String? postNumber;

  const UpdatedUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.address,
    required this.phoneNumber,
    required this.postNumber,
  });
}
