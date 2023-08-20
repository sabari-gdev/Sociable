import 'package:flutter/material.dart';
import 'package:sociable/core/utils/enums/enums.dart';

import 'package:sociable/core/utils/theme/styles.dart';
import 'package:sociable/core/widgets/button/rounded_button.dart';
import 'package:sociable/presentation/authentication/screens/email_login_screen.dart';
import 'package:sociable/presentation/authentication/screens/email_signup_screen.dart';
import 'package:sociable/presentation/authentication/screens/mobile_login_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo_black.png',
              width: 300,
              height: 300,
            ),
            const SizedBox(height: 32),
            RoundedButton(
              text: "Login with Mobile",
              icon: Icons.phone_android,
              type: ButtonType.primary,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => MobileLoginScreen(),
                  ),
                );
              },
            ),
            RoundedButton(
              text: "Login with Email",
              icon: Icons.mail,
              type: ButtonType.primary,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const EmailLoginScreen(),
                  ),
                );
              },
            ),
            RoundedButton(
              text: "Signup with Email",
              icon: Icons.mail_outline,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const EmailSignupScreen(),
                  ),
                );
              },
            ),
            const Text(
              "Or Login with",
              style: kParagraphOneTextStyle,
            ),
            const RoundedButton(
              text: "Continue with Google",
              icon: Icons.g_mobiledata,
            ),
            const Text(
              "By logging in, you agree to the Terms and Conditions. See how\nwe use your data in our Privacy Policy.",
              maxLines: 2,
              textAlign: TextAlign.center,
              style: kParagraphTwoTextStyle,
            )
          ],
        ),
      ),
    );
  }
}
