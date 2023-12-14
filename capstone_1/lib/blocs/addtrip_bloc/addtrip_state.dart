part of 'addtrip_bloc.dart';

abstract class AddTripState {}

class AddTripInitialState extends AddTripState {}

class AddTripLoadingState extends AddTripState {}

class AddTripSuccessState extends AddTripState {}

class AddTripErrorState extends AddTripState {
  final String errorMessage;

  AddTripErrorState(this.errorMessage);
}

class AddTripValidationErrorState extends AddTripState {
  final String errorMessage;

  AddTripValidationErrorState(this.errorMessage);
}
