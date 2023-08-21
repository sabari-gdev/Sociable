import 'package:sociable/core/common/usecases/auth_use_case.dart';
import 'package:sociable/domain/entities/auth/user_entity.dart';

class LoginWithEmailUseCase implements AuthUseCase<UserEntity> {
  @override
  Future<UserEntity> call() {
    throw UnimplementedError();
  }
}
