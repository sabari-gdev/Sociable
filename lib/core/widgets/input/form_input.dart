import 'package:flutter/material.dart';
import 'package:sociable/core/utils/theme/styles.dart';

class FormTextInputField extends StatelessWidget {
  final void Function(String)? onChanged;
  final String? hintText;
  final String? errorText;
  final TextInputType? keyboardType;
  final int? maxLength;
  final int? maxLines;
  final bool obscureText;
  const FormTextInputField({
    super.key,
    this.onChanged,
    this.errorText,
    this.hintText,
    this.keyboardType,
    this.maxLength,
    this.maxLines = 1,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextFormField(
        keyboardType: keyboardType,
        maxLength: maxLength,
        maxLines: maxLines,
        onChanged: onChanged,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          counterText: "",
          errorText: errorText,
          hintStyle: kParagraphOneTextStyle,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
