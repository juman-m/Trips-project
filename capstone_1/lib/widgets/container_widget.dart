import 'package:flutter/material.dart';

Widget buildTripContainer({
  required String title,
  IconData? iconData,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.transparent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  
                ),
              ),
            ),
           
            Icon(
              iconData,
              color: Colors.green[50],
              size: 24,
            ),
          ],
        ),
      ),
    ),
  );
}
