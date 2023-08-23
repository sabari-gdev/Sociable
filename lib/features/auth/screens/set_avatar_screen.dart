import 'package:auth_repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'package:sociable/core/utils/enums/enums.dart';
import 'package:sociable/core/utils/theme/colors.dart';

import 'package:sociable/core/widgets/button/rounded_button.dart';
import 'package:sociable/core/widgets/loader/loader_widget.dart';
import 'package:sociable/features/auth/auth.dart';
import 'package:sociable/features/home/screens/home_screen.dart';

import 'package:user_repository/user_repository.dart';

class SetUserAvatarScreen extends StatelessWidget {
  const SetUserAvatarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(
        authRepository: context.read<AuthRepository>(),
        userRepository: context.read<UserRepository>(),
      ),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            _CompleteButton(),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 16.0,
          ),
          child: Column(
            children: [
              _UserAvatar(),
              const SizedBox(height: 32),
              RoundedButton(
                text: "Take a photo",
                icon: Icons.camera_alt,
                type: ButtonType.primary,
                onPressed: () {},
              ),
              _ChooseFromGalleryButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _CompleteButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpState>(
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
      builder: (context, state) {
        return TextButton.icon(
          label: const Text(
            "Complete",
          ),
          onPressed: () {
            context.read<SignUpCubit>().uploadAvatar();
          },
          icon: state.status.isInProgress
              ? const LoaderWidget()
              : const Icon(
                  Icons.check,
                ),
        );
      },
    );
  }
}

class _UserAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return CircleAvatar(
          maxRadius: 80,
          backgroundColor: kPinkColor,
          backgroundImage: state.pickedAvatar != null
              ? FileImage(state.pickedAvatar!)
              : null,
          child: state.pickedAvatar != null
              ? null
              : const Icon(
                  Icons.person,
                  size: 48,
                  color: kLightWhiteColor,
                ),
        );
      },
    );
  }
}

class _ChooseFromGalleryButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return RoundedButton(
          text: "Choose a photo",
          icon: Icons.collections,
          onPressed: () {
            context.read<SignUpCubit>().pickImageFromGallery();
          },
        );
      },
    );
  }
}
