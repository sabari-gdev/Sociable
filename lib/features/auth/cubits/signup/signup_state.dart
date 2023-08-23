part of 'signup_cubit.dart';

enum ConfirmPasswordValidationError { invalid }

final class SignUpState extends Equatable {
  const SignUpState({
    this.email = const EmailValidator.pure(),
    this.password = const PasswordValidator.pure(),
    this.confirmedPassword = const ConfirmedPassword.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.errorMessage,
    this.firstName = const NameValidator.pure(),
    this.lastName = const LastNameValidator.pure(),
    this.bio = const BioValidator.pure(),
    this.isAgreedToTerms = false,
    this.username = const UsernameValidator.pure(),
    this.profile,
    this.pickedAvatar,
  });

  final EmailValidator email;
  final PasswordValidator password;
  final ConfirmedPassword confirmedPassword;
  final NameValidator firstName;
  final LastNameValidator lastName;
  final BioValidator bio;
  final UsernameValidator username;
  final FormzSubmissionStatus status;
  final bool isValid;
  final bool isAgreedToTerms;
  final String? errorMessage;
  final String? profile;
  final File? pickedAvatar;

  @override
  List<Object?> get props => [
        email,
        password,
        confirmedPassword,
        firstName,
        lastName,
        status,
        isValid,
        errorMessage,
        bio,
        isAgreedToTerms,
        username,
        profile,
        pickedAvatar,
      ];

  SignUpState copyWith({
    EmailValidator? email,
    PasswordValidator? password,
    ConfirmedPassword? confirmedPassword,
    NameValidator? firstName,
    LastNameValidator? lastName,
    BioValidator? bio,
    UsernameValidator? username,
    FormzSubmissionStatus? status,
    bool? isValid,
    String? errorMessage,
    bool? isAgreedToTerms,
    String? profile,
    File? pickedAvatar,
  }) {
    return SignUpState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmedPassword: confirmedPassword ?? this.confirmedPassword,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage ?? this.errorMessage,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      bio: bio ?? this.bio,
      isAgreedToTerms: isAgreedToTerms ?? this.isAgreedToTerms,
      username: username ?? this.username,
      profile: profile ?? this.profile,
      pickedAvatar: pickedAvatar ?? this.pickedAvatar,
    );
  }
}
