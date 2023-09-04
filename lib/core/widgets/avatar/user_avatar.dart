import 'package:flutter/material.dart';
import 'package:sociable/core/utils/theme/colors.dart';

class UserAvatarWidget extends StatelessWidget {
  final String? image;
  const UserAvatarWidget({
    super.key,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 60,
      backgroundColor: kPinkColor,
      backgroundImage: image != null ? NetworkImage(image!) : null,
    );
  }
}
