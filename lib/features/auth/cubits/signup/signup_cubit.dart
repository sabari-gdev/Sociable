import 'dart:developer';
import 'dart:io';

import 'package:auth_repository/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:formz/formz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:user_repository/user_repository.dart';

part 'signup_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit({
    required AuthRepository authRepository,
    required UserRepository userRepository,
  })  : _authenticationRepository = authRepository,
        _userRepository = userRepository,
        super(const SignUpState());

  final AuthRepository _authenticationRepository;
  final UserRepository _userRepository;

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

  void confirmedPasswordChanged(String confirmPassword) {
    final confirmedPassword = ConfirmedPassword.dirty(
      password: state.password.value,
      value: confirmPassword,
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

  void firstNameChanged(String firstName) {
    final formattedFirstName = NameValidator.dirty(name: firstName);

    emit(
      state.copyWith(
        firstName: formattedFirstName,
        isValid: Formz.validate([
          state.lastName,
          formattedFirstName,
          state.bio,
        ]),
      ),
    );
  }

  void lastNameChanged(String lastName) {
    final formattedLastName = LastNameValidator.dirty(name: lastName);

    emit(
      state.copyWith(
        lastName: formattedLastName,
        isValid: Formz.validate([
          state.firstName,
          formattedLastName,
          state.bio,
        ]),
      ),
    );
  }

  void bioChanged(String bio) {
    final formattedBio = BioValidator.dirty(bio: bio);

    emit(
      state.copyWith(
        bio: formattedBio,
        isValid: Formz.validate([
          state.firstName,
          formattedBio,
          state.lastName,
        ]),
      ),
    );
  }

  void usernameChanged(String username) {
    final formattedUsername = UsernameValidator.dirty(name: username);

    emit(
      state.copyWith(
        username: formattedUsername,
        isValid: Formz.validate([
          formattedUsername,
        ]),
      ),
    );
  }

  void toggleTermsAgreement(bool value) => emit(
        state.copyWith(isAgreedToTerms: value),
      );

  Future<void> pickImageFromGallery() async {
    final ImagePicker imagePicker = ImagePicker();

    final XFile? image = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (image != null) {
      emit(
        state.copyWith(
          pickedAvatar: File(image.path),
        ),
      );
    }
  }

  Future<void> completeProfile() async {
    if (!state.isValid || !state.isAgreedToTerms) return;
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      final UserDocument userDocument = UserDocument(
        firstName: state.firstName.value,
        lastName: state.lastName.value,
        bio: state.bio.value,
        email: _authenticationRepository.getAuthUser.email,
        profile: _authenticationRepository.getAuthUser.profilePic,
        createdAt: DateTime.now(),
        followers: 0,
        following: 0,
        posts: 0,
      );
      await _userRepository.addUserDetails(userDocument);
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.toString(),
          status: FormzSubmissionStatus.failure,
        ),
      );
    }
  }

  Future<void> setUsername() async {
    if (!state.isValid) return;
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      await _userRepository
          .updateUserDetails({"userName": state.username.value});
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.toString(),
          status: FormzSubmissionStatus.failure,
        ),
      );
    }
  }

  Future<void> uploadAvatar() async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      final imageURL = await _userRepository.uploadImage(
        image: state.pickedAvatar!,
      );

      log("PROFILE_URL: $imageURL");

      await _userRepository.updateUserDetails({"profile": imageURL});
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.toString(),
          status: FormzSubmissionStatus.failure,
        ),
      );
    }
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
