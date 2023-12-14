part of 'addtrip_bloc.dart';

class AddTripEvent {
  final Trip trip;
  final File?image;

 AddTripEvent({required this.trip, required this.image});
}
