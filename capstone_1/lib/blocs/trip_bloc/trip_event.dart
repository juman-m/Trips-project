part of 'trip_bloc.dart';

abstract class TripEvent {}

class GetUsersEvent extends TripEvent {
  final Trip trip;
  final String userId;
  final int tripId;
  
  GetUsersEvent(this.trip, this.userId, this.tripId);
}


