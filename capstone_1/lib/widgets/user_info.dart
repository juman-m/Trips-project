import 'package:flutter/material.dart';

// ignore: must_be_immutable
class UserInfo extends StatelessWidget {
  UserInfo({
    super.key,
    required this.age,
    required this.city,
    required this.name,
    required this.phone,
  });
  String name;
  String city;
  String phone;
  String age;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name.toString(),
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        Text(
          city.toString(),
          style: const TextStyle(
              fontSize: 14, color: Color.fromARGB(255, 128, 127, 127)),
        ),
        Text(
          phone.toString(),
          style: const TextStyle(
              fontSize: 14, color: Color.fromARGB(255, 128, 127, 127)),
        ),
        Text(
          age.toString(),
          style: const TextStyle(
              fontSize: 14, color: Color.fromARGB(255, 128, 127, 127)),
        ),
      ],
    );
  }
}
