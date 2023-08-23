import 'package:auth_repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:sociable/core/utils/enums/enums.dart';
import 'package:sociable/core/utils/theme/styles.dart';
import 'package:sociable/core/widgets/button/rounded_button.dart';
import 'package:sociable/features/auth/auth.dart';
import 'package:user_repository/user_repository.dart';

class EmailSignupScreen extends StatelessWidget {
  const EmailSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (_) => SignUpCubit(
          authRepository: context.read<AuthRepository>(),
          userRepository: context.read<UserRepository>(),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _SignupForm(),
                _SignUpButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return RoundedButton(
          text: "Sign up",
          type: ButtonType.primary,
          onPressed: () {
            if (state.isValid) {
              context.read<SignUpCubit>().signUpWithEmail();
            }
          },
        );
      },
    );
  }
}

class _SignupForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const CompleteProfileScreen(),
            ),
          );
        }
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? "Signup Failed!"),
              ),
            );
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Enter your details",
            style: kHeading1TextStyle,
          ),
          const Text(
            "Please provide your details to create an account.",
            style: kParagraphOneTextStyle,
          ),
          const SizedBox(height: 16),
          _EmailTextField(),
          const SizedBox(height: 8),
          _PasswordTextField(),
          const SizedBox(height: 8),
          _ConfirmPasswordTextField(),
        ],
      ),
    );
  }
}

class _ConfirmPasswordTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextFormField(
          decoration: InputDecoration(
            hintText: "Confirm Password",
            counterText: "",
            errorText: state.confirmedPassword.displayError != null
                ? state.confirmedPassword.error.toString()
                : null,
            filled: true,
            hintStyle: kParagraphOneTextStyle,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
          obscureText: true,
          onChanged: (password) =>
              context.read<SignUpCubit>().confirmedPasswordChanged(password),
          style: kTextInputTextStyle,
        );
      },
    );
  }
}

class _PasswordTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextFormField(
          decoration: InputDecoration(
            hintText: "Password",
            counterText: "",
            errorText: state.password.displayError != null
                ? state.password.error.toString()
                : null,
            filled: true,
            hintStyle: kParagraphOneTextStyle,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
          obscureText: true,
          onChanged: (password) =>
              context.read<SignUpCubit>().passwordChanged(password),
          style: kTextInputTextStyle,
        );
      },
    );
  }
}

class _EmailTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextFormField(
          decoration: InputDecoration(
            hintText: "Email Address",
            counterText: "",
            errorText: state.email.displayError != null
                ? state.email.error.toString()
                : null,
            filled: true,
            hintStyle: kParagraphOneTextStyle,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
          keyboardType: TextInputType.emailAddress,
          onChanged: (email) => context.read<SignUpCubit>().emailChanged(email),
          style: kTextInputTextStyle,
        );
      },
    );
  }
}
