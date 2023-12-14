import 'package:flutter/material.dart';

// ignore: must_be_immutable
class UserAvatar extends StatelessWidget {
  UserAvatar({super.key, required this.src, this.height = 0.13});
  String src;
  double height;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        clipBehavior: Clip.antiAlias,
        height: MediaQuery.sizeOf(context).height * height,
        width: MediaQuery.sizeOf(context).height * height,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
        ),
        child: Image.network(
          src,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
