import 'package:auth_repository/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:formz/formz.dart';

part 'signup_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit({required AuthRepository authRepository})
      : _authenticationRepository = authRepository,
        super(const SignUpState());

  final AuthRepository _authenticationRepository;

  void emailChanged(String email) {
    final formattedEmail = EmailValidator.dirty(value: email);
    emit(
      state.copyWith(
        email: formattedEmail,
        isValid: Formz.validate([
          formattedEmail,
          state.password,
          state.confirmedPassword,
        ]),
      ),
    );
  }

  void passwordChanged(String password) {
    final formattedPassword = PasswordValidator.dirty(value: password);
    final confirmedPassword = ConfirmedPassword.dirty(
      password: formattedPassword.value,
      value: state.confirmedPassword.value,
    );
    emit(
      state.copyWith(
        password: formattedPassword,
        confirmedPassword: confirmedPassword,
        isValid: Formz.validate([
          state.email,
          formattedPassword,
          confirmedPassword,
        ]),
      ),
    );
  }

  void confirmedPasswordChanged(String value) {
    final confirmedPassword = ConfirmedPassword.dirty(
      password: state.password.value,
      value: value,
    );
    emit(
      state.copyWith(
        confirmedPassword: confirmedPassword,
        isValid: Formz.validate([
          state.email,
          state.password,
          confirmedPassword,
        ]),
      ),
    );
  }

  Future<void> signUpWithEmail() async {
    if (!state.isValid) return;
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      await _authenticationRepository.signUpWithEmail(
        email: state.email.value,
        password: state.password.value,
      );
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } on SignUpWithEmailAndPasswordFailure catch (e) {
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
