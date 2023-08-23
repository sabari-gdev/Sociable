import 'package:formz/formz.dart';

enum BioValidationError { empty }

class BioValidator extends FormzInput<String, BioValidationError> {
  const BioValidator.pure() : super.pure('');
  const BioValidator.dirty({String bio = ''}) : super.dirty(bio);

  @override
  BioValidationError? validator(String value) {
    return value.isEmpty ? BioValidationError.empty : null;
  }
}
