import 'package:formz/formz.dart';

enum EmailValidationError { invalid, empty }

class EmailValidator extends FormzInput<String, EmailValidationError> {
  static final RegExp emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );
  const EmailValidator.pure() : super.pure('');
  const EmailValidator.dirty({String value = ''}) : super.dirty(value);

  @override
  EmailValidationError? validator(String value) {
    return !emailRegExp.hasMatch(value)
        ? EmailValidationError.invalid
        : value.isEmpty
            ? EmailValidationError.empty
            : null;
  }
}
