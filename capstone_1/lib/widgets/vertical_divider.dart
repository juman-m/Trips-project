import 'package:flutter/material.dart';

// ignore: must_be_immutable
class VerticalDivider extends StatelessWidget {
  VerticalDivider({
    super.key,
    required this.height,
  });
  double height;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        height: height,
        width: 1,
        color: Colors.grey,
      ),
    );
  }
}
