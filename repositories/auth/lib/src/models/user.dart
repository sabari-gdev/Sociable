import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String uid;
  final String? email;
  final String? displayName;
  final String? profilePic;

  const UserModel({
    required this.uid,
    this.email,
    this.profilePic,
    this.displayName,
  });

  static const empty = UserModel(uid: '');

  bool get isEmpty => this == UserModel.empty;
  bool get isNotEmpty => this != UserModel.empty;

  @override
  List<Object?> get props => [uid, email, profilePic, displayName];
}
