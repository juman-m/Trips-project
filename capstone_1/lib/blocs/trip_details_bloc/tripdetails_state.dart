


import 'package:capstone_1/models/trip.dart';

abstract class TripDetailsState {}

class TripDetailsInitialState extends TripDetailsState {}

class TripDetailsLoadingState extends TripDetailsState {}

class TripDetailsSuccessState extends TripDetailsState {
  final Trip trip;

  TripDetailsSuccessState(this.trip);
}

class TripDetailsErrorState extends TripDetailsState {
  final String errorMessage;

  TripDetailsErrorState(this.errorMessage);
}

class TripUpdateSuccessState extends TripDetailsState {}

