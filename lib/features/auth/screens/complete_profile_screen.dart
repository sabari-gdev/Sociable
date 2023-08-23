import 'package:auth_repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:sociable/core/utils/enums/enums.dart';
import 'package:sociable/core/utils/theme/styles.dart';
import 'package:sociable/core/widgets/button/rounded_button.dart';
import 'package:sociable/features/auth/auth.dart';
import 'package:user_repository/user_repository.dart';

class CompleteProfileScreen extends StatelessWidget {
  const CompleteProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: BlocProvider(
        create: (context) => SignUpCubit(
          authRepository: context.read<AuthRepository>(),
          userRepository: context.read<UserRepository>(),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 16,
          ),
          child: _CompleteProfileForm(),
        ),
      ),
    );
  }
}

class _CompleteProfileForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? "Login Failed!"),
              ),
            );
        }
        if (state.status.isSuccess) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const SetUsernameScreen(),
            ),
          );
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Complete your profile",
            style: kHeading1TextStyle,
          ),
          const Text(
            "Please add some details so that your followers know you more.",
            style: kParagraphOneTextStyle,
          ),
          const SizedBox(height: 16),
          _FirstNameTextField(),
          const SizedBox(height: 8),
          _LastNameTextField(),
          const SizedBox(height: 8),
          _BioDescTextField(),
          const SizedBox(height: 8),
          Row(
            children: [
              BlocBuilder<SignUpCubit, SignUpState>(
                builder: (context, state) {
                  return Checkbox(
                    value: state.isAgreedToTerms,
                    onChanged: (value) => context
                        .read<SignUpCubit>()
                        .toggleTermsAgreement(value!),
                  );
                },
              ),
              const Text(
                "I'm at least 18 years old.",
                style: kParagraphOneTextStyle,
              )
            ],
          ),
          const Spacer(),
          _ProceedButton()
        ],
      ),
    );
  }
}

class _ProceedButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return RoundedButton(
          text: "Proceed",
          type: ButtonType.primary,
          isLoading: state.status.isInProgress,
          onPressed: () {
            debugPrint("form valid: ${state.isValid}");

            if (state.isAgreedToTerms && state.isValid) {
              debugPrint("pressed");
              context.read<SignUpCubit>().completeProfile();
            }
          },
        );
      },
    );
  }
}

class _BioDescTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.bio != current.bio,
      builder: (context, state) {
        return TextFormField(
          keyboardType: TextInputType.multiline,
          maxLength: 60,
          maxLines: 5,
          onChanged: (bio) => context.read<SignUpCubit>().bioChanged(bio),
          decoration: InputDecoration(
            hintText: "Bio/Describe yourself",
            counterText: "",
            errorText: state.bio.displayError != null
                ? state.bio.error.toString()
                : null,
            hintStyle: kParagraphOneTextStyle,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
        );
      },
    );
  }
}

class _LastNameTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.lastName != current.lastName,
      builder: (context, state) {
        return TextFormField(
          decoration: InputDecoration(
            hintText: "Last Name",
            counterText: "",
            errorText: state.lastName.displayError != null
                ? state.lastName.error.toString()
                : null,
            filled: true,
            hintStyle: kParagraphOneTextStyle,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
          onChanged: (lastName) =>
              context.read<SignUpCubit>().lastNameChanged(lastName),
        );
      },
    );
  }
}

class _FirstNameTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.firstName != current.firstName,
      builder: (context, state) {
        return TextFormField(
          decoration: InputDecoration(
            hintText: "First Name",
            counterText: "",
            errorText: state.firstName.displayError != null
                ? state.firstName.error.toString()
                : null,
            filled: true,
            hintStyle: kParagraphOneTextStyle,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
          onChanged: (firstName) =>
              context.read<SignUpCubit>().firstNameChanged(firstName),
        );
      },
    );
  }
}
