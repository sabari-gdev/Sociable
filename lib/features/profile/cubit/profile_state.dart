part of 'profile_bloc.dart';

enum ProfileStatus { initial }

final class ProfileState extends Equatable {
  const ProfileState({
    required this.documentSnapshot,
  });
  const ProfileState.initial() : documentSnapshot = const {};
  final Map<String, dynamic> documentSnapshot;

  @override
  List<Object?> get props => [documentSnapshot];
}
