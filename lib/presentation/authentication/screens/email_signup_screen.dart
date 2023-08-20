import 'package:flutter/material.dart';
import 'package:sociable/core/utils/enums/enums.dart';
import 'package:sociable/core/utils/theme/styles.dart';
import 'package:sociable/core/widgets/button/rounded_button.dart';
import 'package:sociable/presentation/authentication/screens/complete_profile_screen.dart';

class EmailSignupScreen extends StatelessWidget {
  const EmailSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
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
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Email Address",
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
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Password",
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
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Confirm Password",
                    counterText: "",
                    filled: true,
                    hintStyle: kParagraphOneTextStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ],
            ),
            RoundedButton(
              text: "Sign up",
              type: ButtonType.primary,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const CompleteProfileScreen(),
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
