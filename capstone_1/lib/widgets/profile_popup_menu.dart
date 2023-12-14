import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProfilePopUpMenu extends StatelessWidget {
  ProfilePopUpMenu({
    super.key,
    required this.editProfile,
    required this.signout,
    required this.mode,
  });
  PopupMenuItem editProfile;
  PopupMenuItem signout;
  PopupMenuItem mode;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        color: const Color.fromARGB(255, 248, 248, 248),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 2,
        surfaceTintColor: Colors.white,
        clipBehavior: Clip.antiAlias,
        itemBuilder: (context) => [editProfile, mode, signout]);
  }
}
