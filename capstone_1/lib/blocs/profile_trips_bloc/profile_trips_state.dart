part of 'profile_trips_bloc.dart';

@immutable
sealed class ProfileTripsState {}

final class ProfileTripsInitial extends ProfileTripsState {}

final class GetTripsSuccessedState extends ProfileTripsState {
  final List<Trip> trip;

  GetTripsSuccessedState(this.trip);
}
final class GetJointTripsSuccessedState extends ProfileTripsState {
  final List<Trip> trip;

  GetJointTripsSuccessedState(this.trip);
}