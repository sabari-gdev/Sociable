import 'dart:developer';

import 'package:auth_repository/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:formz/formz.dart';
import 'package:user_repository/user_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  LoginCubit(
      {required AuthRepository authRepository,
      required UserRepository userRepository})
      : _authRepository = authRepository,
        _userRepository = userRepository,
        super(const LoginState());

  void emailChanged(String email) {
    final formattedEmail = EmailValidator.dirty(value: email);

    emit(
      state.copyWith(
        email: formattedEmail,
        isValid: Formz.validate([formattedEmail, state.password]),
      ),
    );
  }

  void passwordChanged(String password) {
    final formattedPassword = PasswordValidator.dirty(value: password);
    emit(
      state.copyWith(
        password: formattedPassword,
        isValid: Formz.validate([state.email, formattedPassword]),
      ),
    );
  }

  Future<void> signinWithEmailAndPassword() async {
    if (!state.isValid) return;

    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    try {
      await _authRepository.loginWithEmail(
        email: state.email.value,
        password: state.password.value,
      );
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } on LogInWithEmailAndPasswordFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: FormzSubmissionStatus.failure,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }

  Future<void> logInWithGoogle() async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      await _authRepository.loginWithGoogle();
      final userDetailsExists = await _userRepository.userDocumentExists();

      if (userDetailsExists) {
        log('User details exists');
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      }
    } on LogInWithGoogleFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: FormzSubmissionStatus.failure,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }
}
