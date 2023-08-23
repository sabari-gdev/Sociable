import 'dart:developer';

import 'package:auth_repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  final auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  AuthRepository({
    auth.FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
  })  : _firebaseAuth = firebaseAuth ?? auth.FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard();

  Stream<UserModel> get currentUser =>
      _firebaseAuth.authStateChanges().map((firebaseUser) {
        log("USR CHANGE TRIGGERED: $firebaseUser");
        final user =
            firebaseUser == null ? UserModel.empty : firebaseUser.toUserEntity;
        return user;
      });

  UserModel get getAuthUser {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      return user.toUserEntity;
    }
    return UserModel.empty;
  }

  Future<void> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final auth.UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        log("User successfully logged in: ${userCredential.user}");
      } else {
        log("Something went wrong");
      }
    } on auth.FirebaseAuthException catch (exception) {
      throw LogInWithEmailAndPasswordFailure.fromCode(exception.code);
    } catch (_) {
      throw const LogInWithEmailAndPasswordFailure();
    }
  }

  Future<void> loginWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser!.authentication;
      final auth.OAuthCredential credential =
          auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final auth.UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      if (userCredential.user != null) {
        log("User successfully loggedIn: ${userCredential.user}");
      } else {
        log("Something went wrong");
      }
    } on auth.FirebaseAuthException catch (exception) {
      throw LogInWithGoogleFailure.fromCode(exception.code);
    } catch (_) {
      throw const LogInWithGoogleFailure();
    }
  }

  Future<void> logout() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
      print("Logout success");
    } catch (_) {
      throw LogOutFailure();
    }
  }

  Future<void> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final auth.UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        log("User successfully created: ${userCredential.user}");
      } else {
        log("Something went wrong");
      }
    } on auth.FirebaseAuthException catch (exception) {
      throw SignUpWithEmailAndPasswordFailure.fromCode(exception.code);
    } catch (_) {
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }
}

extension on auth.User {
  UserModel get toUserEntity {
    return UserModel(
      uid: uid,
      email: email,
      profilePic: photoURL,
    );
  }
}
