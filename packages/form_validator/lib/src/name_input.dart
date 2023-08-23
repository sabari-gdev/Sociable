import 'package:formz/formz.dart';

enum NameValidationError { empty }

class NameValidator extends FormzInput<String, NameValidationError> {
  const NameValidator.pure() : super.pure('');
  const NameValidator.dirty({String name = ''}) : super.dirty(name);

  @override
  NameValidationError? validator(String value) {
    return value.isEmpty ? NameValidationError.empty : null;
  }
}
