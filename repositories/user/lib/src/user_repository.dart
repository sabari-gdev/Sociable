import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_storage/firebase_storage.dart';

import 'package:user_repository/src/models/user_details.dart';

class UserRepository {
  final FirebaseFirestore _firestore;
  final auth.FirebaseAuth _firebaseAuth;
  final FirebaseStorage _firebaseStorage;
  UserRepository({
    FirebaseFirestore? firestore,
    auth.FirebaseAuth? firebaseAuth,
    FirebaseStorage? firebaseStorage,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _firebaseAuth = firebaseAuth ?? auth.FirebaseAuth.instance,
        _firebaseStorage = firebaseStorage ?? FirebaseStorage.instance;

  Future<void> addUserDetails(UserDocument user) async {
    final CollectionReference usersCollection = _firestore.collection('users');
    final newUserDocument = usersCollection.doc(_firebaseAuth.currentUser?.uid);

    await newUserDocument
        .set(user.toJson())
        .then(
          (_) => log("User Details Added to the document."),
        )
        .onError(
          (error, stackTrace) => log("Error: $error"),
        );
  }

  Future<void> updateUserDetails(UserDocument data) async {
    final CollectionReference usersCollection = _firestore.collection('users');

    await usersCollection
        .doc(data.uid)
        .update({
          "username": data.userName,
        })
        .then((value) => print("Updated successfully!"))
        .onError(
          (error, stackTrace) => print("Error: $error"),
        );
  }

  Future<String?> uploadImage({required File image}) async {
    try {
      final storageRef = _firebaseStorage
          .ref()
          .child('users')
          .child('avatars')
          .child(_firebaseAuth.currentUser!.uid);

      final task = storageRef.putFile(image);
      final taskSnapshot = task.snapshot;
      if (taskSnapshot.state == TaskState.success) {
        return storageRef.getDownloadURL();
      } else {
        return null;
      }
    } on FirebaseException catch (e) {
      log("Exception: ${e.code}");
      throw Exception(e);
    } catch (_) {
      throw Exception("Exception occured");
    }
  }
}
