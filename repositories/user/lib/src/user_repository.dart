import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_storage/firebase_storage.dart';

import 'package:user_repository/src/models/user_document/user_document.dart';

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

  Stream<UserDocument> get getRealtimeUserDoc => _firestore
          .collection('users')
          .doc(_firebaseAuth.currentUser?.uid)
          .snapshots()
          .map(
        (event) {
          log("DOC CHANGE TRIGGERED: ${event.data()}");
          return UserDocument.fromFirestore(event.data()!);
        },
      );

  Future<void> addUserDetails(UserDocument user) async {
    final CollectionReference usersCollection = _firestore.collection('users');
    final newUserDocument = usersCollection.doc(_firebaseAuth.currentUser?.uid);

    await newUserDocument
        .set(user.toFirestore())
        .then(
          (_) => log("User Details Added to the document."),
        )
        .onError(
          (error, stackTrace) => log("Error: $error"),
        );
  }

  Future<void> updateUserDetails(Map<String, dynamic> data) async {
    final CollectionReference usersCollection = _firestore.collection('users');

    await usersCollection
        .doc(_firebaseAuth.currentUser?.uid)
        .update(data)
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

      final task = await storageRef.putFile(image);
      final taskSnapshot = task.state;
      if (taskSnapshot == TaskState.success) log("Image upload Success!");
      final url = await storageRef.getDownloadURL();

      return url;
    } on FirebaseException catch (e) {
      log("Exception: ${e.code}");
      throw Exception(e);
    } catch (_) {
      throw Exception("Exception occured");
    }
  }

  Future<bool> userDocumentExists() async {
    final userDoc = await _firestore
        .collection('users')
        .where(
          'uid',
          isEqualTo: _firebaseAuth.currentUser?.uid,
        )
        .get();

    if (userDoc.docs.isEmpty) {
      return false;
    } else {
      return true;
    }
  }
}
