import 'package:equatable/equatable.dart';

class UserDocument extends Equatable {
  final String uid;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? profile;
  final String? bio;
  final String? userName;

  UserDocument({
    required this.uid,
    this.bio,
    this.email,
    this.firstName,
    this.lastName,
    this.phone,
    this.profile,
    this.userName,
  });

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phone": phone,
        "bio": bio,
        "username": userName,
        "profile": profile,
      };

  UserDocument copyWith({
    String? uid,
    String? firstName,
    String? lastName,
    String? bio,
    String? phone,
    String? email,
    String? profile,
    String? userName,
  }) =>
      UserDocument(
        uid: uid ?? this.uid,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        bio: bio ?? this.bio,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        profile: profile ?? this.profile,
        userName: userName ?? this.userName,
      );

  @override
  List<Object?> get props => [
        uid,
        firstName,
        lastName,
        bio,
        phone,
        email,
        userName,
        profile,
      ];
}
