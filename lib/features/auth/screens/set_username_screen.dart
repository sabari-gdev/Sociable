import 'package:auth_repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:sociable/core/utils/enums/enums.dart';
import 'package:sociable/core/utils/theme/styles.dart';
import 'package:sociable/core/widgets/button/rounded_button.dart';
import 'package:sociable/features/auth/auth.dart';

import 'package:user_repository/user_repository.dart';

class SetUsernameScreen extends StatelessWidget {
  const SetUsernameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
          child: _SetUsernameForm(),
        ),
      ),
    );
  }
}

class _SetUsernameForm extends StatelessWidget {
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
              builder: (context) => const SetUserAvatarScreen(),
            ),
          );
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Set your usename",
            style: kHeading1TextStyle,
          ),
          const Text(
            "Set a username so that your profile can be searched by others.",
            style: kParagraphOneTextStyle,
          ),
          const SizedBox(height: 16),
          _UsernameTextField(),
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
            if (state.isValid) {
              context.read<SignUpCubit>().setUsername();
            }
          },
        );
      },
    );
  }
}

class _UsernameTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return TextFormField(
          decoration: InputDecoration(
            hintText: "Choose a username",
            counterText: "",
            errorText: state.username.displayError != null
                ? state.username.error.toString()
                : null,
            filled: true,
            hintStyle: kParagraphOneTextStyle,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
          onChanged: (username) =>
              context.read<SignUpCubit>().usernameChanged(username),
        );
      },
    );
  }
}
