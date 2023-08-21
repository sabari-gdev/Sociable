import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:sociable/domain/entities/auth/user_entity.dart';

extension on auth.User {
  UserEntity get toUser {
    return UserEntity(
      uid: uid,
      email: email,
      profilePic: photoURL,
    );
  }
}
