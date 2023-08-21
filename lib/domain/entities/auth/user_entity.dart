import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String uid;
  final String? email;
  final String? profilePic;

  const UserEntity({
    required this.uid,
    this.email,
    this.profilePic,
  });

  static const empty = UserEntity(uid: '');

  bool get isEmpty => this == UserEntity.empty;
  bool get isNotEmpty => this != UserEntity.empty;

  @override
  List<Object?> get props => [uid, email, profilePic];
}
