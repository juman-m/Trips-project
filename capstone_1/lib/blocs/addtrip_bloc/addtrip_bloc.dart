import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:capstone_1/models/trip.dart';
import 'package:capstone_1/services/supabase_request.dart';

part 'addtrip_event.dart';
part 'addtrip_state.dart';



class AddTripBloc extends Bloc<AddTripEvent, AddTripState> {
  AddTripBloc() : super(AddTripInitialState()) {
    on<AddTripEvent>(_onAddTrip);
  }

  Future<void> _onAddTrip(
      AddTripEvent event, Emitter<AddTripState> emit) async {
    emit(AddTripLoadingState());

    try {
     
      await addTrip(event.trip.toJson(), event.image);
      emit(AddTripSuccessState());
    } catch (error) {
      print('Failed to add trip: $error');
      emit(AddTripErrorState("Something went wrong. Please try again."));
    }
  }
}
