import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_document.g.dart';

@JsonSerializable()
class UserDocument {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? profile;
  final String? bio;
  final String? userName;
  final int? followers;
  final int? following;
  final int? posts;
  final DateTime? createdAt;

  UserDocument({
    this.bio,
    this.email,
    this.firstName,
    this.lastName,
    this.phone,
    this.profile,
    this.userName,
    this.createdAt,
    this.followers,
    this.following,
    this.posts,
  });

  factory UserDocument.fromFirestore(Map<String, dynamic> snapshot,
          {SnapshotOptions? options}) =>
      _$UserDocumentFromJson(snapshot);

  Map<String, dynamic> toFirestore() => _$UserDocumentToJson(this);
}
