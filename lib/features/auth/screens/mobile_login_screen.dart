import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:sociable/core/utils/enums/enums.dart';
import 'package:sociable/core/utils/theme/styles.dart';
import 'package:sociable/core/widgets/button/rounded_button.dart';
import 'package:sociable/features/auth/screens/otp_screen.dart';

class MobileLoginScreen extends StatelessWidget {
  const MobileLoginScreen({super.key});

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
                  "Enter your mobile\nnumber",
                  style: kHeading1TextStyle,
                ),
                const Text(
                  "We'll send you an OTP code for verification.",
                  style: kParagraphOneTextStyle,
                ),
                const SizedBox(height: 16),
                IntlPhoneField(
                  decoration: InputDecoration(
                    hintText: "Mobile Number",
                    counterText: "",
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ],
            ),
            RoundedButton(
              text: "Send me the code",
              type: ButtonType.primary,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const OTPInputScreen(),
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
