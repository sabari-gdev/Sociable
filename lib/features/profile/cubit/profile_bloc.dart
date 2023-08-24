import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

part 'profile_state.dart';
part 'profile_event.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository _repository;
  late final StreamSubscription<UserDocument>
      _userRealtimeDocStreamSubscription;
  ProfileBloc({
    required UserRepository repository,
  })  : _repository = repository,
        super(const ProfileState.initial()) {
    on<DocUpdateEvent>(_onDocUpdateEvent);
    _userRealtimeDocStreamSubscription = _repository.getRealtimeUserDoc.listen(
      (event) => add(
        DocUpdateEvent(
          doc: event,
        ),
      ),
    );
  }

  @override
  Future<void> close() {
    _userRealtimeDocStreamSubscription.cancel();
    return super.close();
  }

  FutureOr<void> _onDocUpdateEvent(
      DocUpdateEvent event, Emitter<ProfileState> emit) {
    emit(
      ProfileState(
        documentSnapshot: event.doc.toFirestore(),
      ),
    );
  }
}
