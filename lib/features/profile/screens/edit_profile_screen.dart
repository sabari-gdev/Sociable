import 'package:flutter/material.dart';

import 'package:sociable/core/utils/theme/styles.dart';

import 'package:sociable/core/widgets/avatar/user_avatar.dart';
import 'package:sociable/core/widgets/input/form_input.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Profile",
          style: kTitleTextStyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          children: [
            const UserAvatarWidget(),
            TextButton(
              onPressed: () {},
              child: const Text("Change avatar"),
            ),
            const FormTextInputField(
              hintText: "First Name",
            ),
            const FormTextInputField(
              hintText: "Last Name",
            ),
            const FormTextInputField(
              hintText: "Username",
            ),
            const FormTextInputField(
              hintText: "Bio/Describe yourself",
              keyboardType: TextInputType.multiline,
              maxLines: 5,
              maxLength: 60,
            ),
          ],
        ),
      ),
    );
  }
}
