import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:sociable/core/utils/enums/enums.dart';
import 'package:sociable/core/utils/theme/styles.dart';
import 'package:sociable/core/widgets/button/rounded_button.dart';
import 'package:sociable/presentation/authentication/screens/complete_profile_screen.dart';

class OTPInputScreen extends StatelessWidget {
  const OTPInputScreen({super.key});

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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Confirm your mobile\nnumber",
                  style: kHeading1TextStyle,
                ),
                Text(
                  "Enter the code we sent to the number.",
                  style: kParagraphOneTextStyle,
                ),
                Pinput(
                  length: 4,
                ),
              ],
            ),
            RoundedButton(
              text: "Confirm",
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
