part of 'trip_bloc.dart';

abstract class TripState {}

final class TripInitial extends TripState {}

final class GetUserSuccessedState extends TripState {
  final UserModel user;
  final bool isJoint;
  GetUserSuccessedState(this.user, this.isJoint);
}
class LoadingState extends TripState {}
