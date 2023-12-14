part of 'profile_trips_bloc.dart';

@immutable
sealed class ProfileTripsEvent {}

class GetProfileTripsEvent extends ProfileTripsEvent {
   final String id;

  GetProfileTripsEvent(this.id);
}

class GetJointTripsEvent extends ProfileTripsEvent {
  final String id;

  GetJointTripsEvent(this.id);
}
