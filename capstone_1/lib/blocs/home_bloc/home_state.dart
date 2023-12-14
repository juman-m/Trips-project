part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class GetTripsSuccessedState extends HomeState {
  final List<Trip> trip;

  GetTripsSuccessedState(this.trip);
}
