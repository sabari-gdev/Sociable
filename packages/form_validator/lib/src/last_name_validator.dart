import 'package:formz/formz.dart';

enum LastNameValidationError { empty }

class LastNameValidator extends FormzInput<String, LastNameValidationError> {
  const LastNameValidator.pure() : super.pure('');
  const LastNameValidator.dirty({String name = ''}) : super.dirty(name);

  @override
  LastNameValidationError? validator(String value) {
    return value.isEmpty ? LastNameValidationError.empty : null;
  }
}
