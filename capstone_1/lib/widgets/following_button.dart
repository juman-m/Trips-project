import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FollowingButton extends StatelessWidget {
  FollowingButton(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.noOfusers});
  String text;
  int noOfusers;
  Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.23,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          
          backgroundColor: Colors.white,
          padding: const EdgeInsets.all(5),
          elevation: 1,
          
        ),
        onPressed: onPressed,
        child: Column(
          children: [
            Text(
              noOfusers.toString(),
              style: const TextStyle(
                color: Color(0xff023047),
              ),
            ),
            Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xff023047),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
