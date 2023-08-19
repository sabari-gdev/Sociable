import 'package:flutter/material.dart';
import 'package:sociable/core/utils/enums/enums.dart';
import 'package:sociable/core/utils/theme/colors.dart';
import 'package:sociable/core/utils/theme/styles.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final ButtonType type;
  final IconData? icon;
  final void Function()? onPressed;
  const RoundedButton({
    super.key,
    required this.text,
    this.type = ButtonType.normal,
    this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: icon != null
            ? Icon(
                icon,
              )
            : const SizedBox(),
        label: Text(text),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            type == ButtonType.normal ? kSnowWhiteColor : kPinkColor,
          ),
          iconColor: MaterialStateProperty.all(type == ButtonType.primary
              ? kLightWhiteColor
              : kChromeBlackColor),
          foregroundColor: MaterialStateProperty.all(
            type == ButtonType.primary ? kLightWhiteColor : kChromeBlackColor,
          ),
          minimumSize: MaterialStateProperty.all(
            const Size(double.maxFinite, 56),
          ),
          textStyle: MaterialStateProperty.all(kButtonTextStyle),
        ),
      ),
    );
  }
}
