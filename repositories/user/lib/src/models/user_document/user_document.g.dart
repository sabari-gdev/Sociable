// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDocument _$UserDocumentFromJson(Map<String, dynamic> json) => UserDocument(
      bio: json['bio'] as String?,
      email: json['email'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      phone: json['phone'] as String?,
      profile: json['profile'] as String?,
      userName: json['userName'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      followers: json['followers'] as int?,
      following: json['following'] as int?,
      posts: json['posts'] as int?,
    );

Map<String, dynamic> _$UserDocumentToJson(UserDocument instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'phone': instance.phone,
      'profile': instance.profile,
      'bio': instance.bio,
      'userName': instance.userName,
      'followers': instance.followers,
      'following': instance.following,
      'posts': instance.posts,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
