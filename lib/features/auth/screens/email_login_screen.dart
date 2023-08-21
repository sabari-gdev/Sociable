import 'package:auth_repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:formz/formz.dart';
import 'package:sociable/core/utils/enums/enums.dart';
import 'package:sociable/core/utils/theme/styles.dart';
import 'package:sociable/core/widgets/button/rounded_button.dart';
import 'package:sociable/features/auth/cubits/login/login_cubit.dart';

import 'package:sociable/features/auth/screens/complete_profile_screen.dart';
import 'package:sociable/features/home/screens/home_screen.dart';

class EmailLoginScreen extends StatelessWidget {
  const EmailLoginScreen({super.key});

  static Page<void> page() => const MaterialPage<void>(
        child: EmailLoginScreen(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (_) =>
            LoginCubit(authRepository: context.read<AuthRepository>()),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [_LoginForm(), _LoginButton()],
          ),
        ),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return RoundedButton(
          text: "Login",
          type: ButtonType.primary,
          isLoading: state.status.isInProgress,
          onPressed: () {
            if (state.isValid) {
              context.read<LoginCubit>().signinWithEmailAndPassword();
            }
          },
        );
      },
    );
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
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
              builder: (context) => const HomeScreen(),
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
            "Please provide your details to continue.",
            style: kParagraphOneTextStyle,
          ),
          const SizedBox(height: 16),
          _EmailTextField(),
          const SizedBox(height: 8),
          _PasswordTextField(),
        ],
      ),
    );
  }
}

class _PasswordTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextFormField(
          obscureText: true,
          onChanged: (password) =>
              context.read<LoginCubit>().passwordChanged(password),
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
        );
      },
    );
  }
}

class _EmailTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) => BlocBuilder<LoginCubit, LoginState>(
        buildWhen: (previous, current) => previous.email != current.email,
        builder: (context, state) {
          return TextFormField(
            onChanged: (email) =>
                context.read<LoginCubit>().emailChanged(email),
            decoration: InputDecoration(
              hintText: "Email Address",
              counterText: "",
              errorText: state.email.displayError != null
                  ? state.email.error == EmailValidationError.invalid
                      ? "Invalid Email"
                      : "Email is empty"
                  : null,
              filled: true,
              hintStyle: kParagraphOneTextStyle,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
            ),
          );
        },
      );
}
