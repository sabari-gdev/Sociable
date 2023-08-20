import 'package:flutter/material.dart';
import 'package:sociable/core/utils/enums/enums.dart';
import 'package:sociable/core/utils/theme/colors.dart';
import 'package:sociable/core/widgets/button/rounded_button.dart';
import 'package:sociable/presentation/home/screens/home_screen.dart';

class SetUserAvatarScreen extends StatelessWidget {
  const SetUserAvatarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton.icon(
            label: const Text(
              "Complete",
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.check,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 16.0,
        ),
        child: Column(
          children: [
            const CircleAvatar(
              maxRadius: 80,
              backgroundColor: kPinkColor,
              child: Icon(
                Icons.person,
                size: 48,
                color: kLightWhiteColor,
              ),
            ),
            const SizedBox(height: 32),
            RoundedButton(
              text: "Take a photo",
              icon: Icons.camera_alt,
              type: ButtonType.primary,
              onPressed: () {},
            ),
            RoundedButton(
              text: "Choose a photo",
              icon: Icons.collections,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
