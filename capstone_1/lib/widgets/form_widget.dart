import 'package:flutter/material.dart';

Widget buildStyledTextField({
  required TextEditingController controller,
  required String labelText,
  int maxLines = 1,
  TextInputType keyboardType = TextInputType.text,
  Widget? suffixIcon,
}) {
  return TextFormField(
    controller: controller,
    maxLines: maxLines,
    keyboardType: keyboardType,
    style: const TextStyle(color: Color(0xff023047)),
    decoration: InputDecoration(
      labelText: labelText,
      labelStyle:
          const TextStyle(color: Color(0xff023047), fontWeight: FontWeight.w200),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xffFFB703), width: 2),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xff8ECAE6), width: 1),
      ),
      suffixIcon: suffixIcon,
    ),
  );
}
