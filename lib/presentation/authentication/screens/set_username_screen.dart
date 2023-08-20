import 'package:flutter/material.dart';
import 'package:sociable/core/utils/enums/enums.dart';
import 'package:sociable/core/utils/theme/styles.dart';
import 'package:sociable/core/widgets/button/rounded_button.dart';
import 'package:sociable/presentation/authentication/screens/set_avatar_screen.dart';

class SetUsernameScreen extends StatelessWidget {
  const SetUsernameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 16,
        ),
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
            TextFormField(
              decoration: InputDecoration(
                hintText: "Choose a username",
                counterText: "",
                filled: true,
                hintStyle: kParagraphOneTextStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const Spacer(),
            RoundedButton(
              text: "Proceed",
              type: ButtonType.primary,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SetUserAvatarScreen(),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
