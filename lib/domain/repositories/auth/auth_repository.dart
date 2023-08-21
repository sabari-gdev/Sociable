import 'package:sociable/domain/entities/auth/user_entity.dart';

abstract class AuthRepository {
  Future<void> signUpWithEmail({
    required String email,
    required String password,
  });

  Future<void> loginWithGoogle();

  Future<void> loginWithEmail({
    required String email,
    required String password,
  });

  Future<void> logout();
  Stream<UserEntity> get currentUser;

  UserEntity get getAuthUser;
}
