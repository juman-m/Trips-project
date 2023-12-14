import 'package:capstone_1/models/trip.dart';
import 'package:flutter/material.dart';

class TripCountener extends StatelessWidget {
  const TripCountener({
    super.key,
    required this.trip,
  });
  final Trip trip;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      alignment: Alignment.topCenter,
      width: 150,
      height: 272,
      decoration: const ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(70),
            topRight: Radius.circular(70),
            bottomLeft: Radius.circular(27),
            bottomRight: Radius.circular(27),
          ),
        ),
        shadows: [
          BoxShadow(
            color: Color.fromARGB(61, 81, 81, 81),
            blurRadius: 10,
            offset: Offset(0, 3),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipOval(
            child: Image.network(
              trip.image!,
              height: 150,
              width: 150,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            "${trip.title}",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            trip.date!,
            style: const TextStyle(
              color: Color(0xFF637663),
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            trip.time!,
            style: const TextStyle(
              color: Color(0xFF637663),
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            trip.location!,
            style: const TextStyle(
              color: Color(0xFF637663),
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
        ],
      ),
    );
  }
}
