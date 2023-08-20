import 'package:flutter/material.dart';
import 'package:sociable/core/utils/enums/enums.dart';
import 'package:sociable/core/utils/theme/styles.dart';
import 'package:sociable/core/widgets/button/rounded_button.dart';
import 'package:sociable/presentation/authentication/screens/set_username_screen.dart';

class CompleteProfileScreen extends StatelessWidget {
  const CompleteProfileScreen({super.key});

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
              "Complete your profile",
              style: kHeading1TextStyle,
            ),
            const Text(
              "Please add some details so that your followers know you more.",
              style: kParagraphOneTextStyle,
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                hintText: "First Name",
                counterText: "",
                filled: true,
                hintStyle: kParagraphOneTextStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Last Name",
                counterText: "",
                filled: true,
                hintStyle: kParagraphOneTextStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              keyboardType: TextInputType.multiline,
              maxLength: 60,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "Bio/Describe yourself",
                counterText: "",
                hintStyle: kParagraphOneTextStyle,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Checkbox(
                  value: false,
                  onChanged: (value) {},
                ),
                const Text(
                  "I'm at least 18 years old.",
                  style: kParagraphOneTextStyle,
                )
              ],
            ),
            const Spacer(),
            RoundedButton(
              text: "Proceed",
              type: ButtonType.primary,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SetUsernameScreen(),
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
