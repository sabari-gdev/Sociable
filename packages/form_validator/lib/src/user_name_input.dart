import 'package:formz/formz.dart';

enum UsernameValidationError { empty }

class UsernameValidator extends FormzInput<String, UsernameValidationError> {
  const UsernameValidator.pure() : super.pure('');
  const UsernameValidator.dirty({String name = ''}) : super.dirty(name);

  @override
  UsernameValidationError? validator(String value) {
    return value.isEmpty ? UsernameValidationError.empty : null;
  }
}
