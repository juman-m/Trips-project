import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProfileInfoRow extends StatelessWidget {
  ProfileInfoRow(
      {super.key, required this.text, this.iconSize = 24, this.black = false});
  String text;
  double iconSize;
  bool black;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: Row(
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: black ? Colors.black : Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}
