part of 'login_cubit.dart';

final class LoginState extends Equatable {
  final EmailValidator email;
  final PasswordValidator password;
  final FormzSubmissionStatus status;
  final bool isValid;
  final String? errorMessage;

  const LoginState({
    this.email = const EmailValidator.pure(),
    this.password = const PasswordValidator.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [
        email,
        password,
        status,
        errorMessage,
      ];

  LoginState copyWith({
    EmailValidator? email,
    PasswordValidator? password,
    FormzSubmissionStatus? status,
    bool? isValid,
    String? errorMessage,
  }) =>
      LoginState(
        email: email ?? this.email,
        password: password ?? this.password,
        status: status ?? this.status,
        isValid: isValid ?? this.isValid,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
