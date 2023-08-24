part of 'profile_bloc.dart';

sealed class ProfileEvent {
  const ProfileEvent();
}

final class DocUpdateEvent extends ProfileEvent {
  final UserDocument doc;

  DocUpdateEvent({required this.doc});
}
