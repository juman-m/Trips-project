import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddTextField extends StatelessWidget {
  const AddTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.isPassword,
    required this.controller,
    required this.icon,
    required this.isAge,
  });
  final String label;
  final String hint;
  final bool isPassword;
  final bool isAge;
  final IconData icon;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 330,
      height: 50,
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: isAge ? TextInputType.number : TextInputType.text,
        inputFormatters: isAge ? [FilteringTextInputFormatter.digitsOnly] : [],
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          label: Text(
            label,
            style: const TextStyle(
                color: Color.fromARGB(255, 95, 93, 93), fontSize: 18),
          ),
          hintText: hint,
          hintStyle: const TextStyle(
              color: Color.fromARGB(255, 198, 198, 198), fontSize: 14),
          suffixIconColor: const Color.fromARGB(143, 255, 184, 3),
          suffixIcon: Icon(icon),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide:
                const BorderSide(color: Color.fromARGB(255, 211, 211, 211)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide:
                const BorderSide(color: Color.fromARGB(255, 169, 169, 169)),
          ),
        ),
      ),
    );
  }
}
