class SignUpWithEmailAndPasswordFailure implements Exception {
  final String message;

  const SignUpWithEmailAndPasswordFailure({
    this.message = 'An unknown exception has occured.',
  });

  factory SignUpWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const SignUpWithEmailAndPasswordFailure(
            message: 'Email is not valid or badly formatted.');

      case 'user-disabled':
        return const SignUpWithEmailAndPasswordFailure(
          message:
              'This user has been disabled. Please contact support for help.',
        );

      case 'email-already-in-use':
        return const SignUpWithEmailAndPasswordFailure(
          message: 'An account already exists for that email.',
        );

      case 'operation-not-allowed':
        return const SignUpWithEmailAndPasswordFailure(
          message: 'Operation is not allowed.  Please contact support.',
        );

      case 'weak-password':
        return const SignUpWithEmailAndPasswordFailure(
          message: 'Please enter a stronger password.',
        );
      default:
        return const SignUpWithEmailAndPasswordFailure();
    }
  }
}
