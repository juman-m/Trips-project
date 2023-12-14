import 'package:capstone_1/blocs/trip_details_bloc/tripdetails_event.dart';
import 'package:capstone_1/blocs/trip_details_bloc/tripdetails_state.dart';
import 'package:capstone_1/services/supabase_request.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TripDetailsBloc extends Bloc<TripDetailsEvent, TripDetailsState> {
  TripDetailsBloc() : super(TripDetailsInitialState()) {
    on<FetchTripDetailsEvent>((event, emit) async {
      emit(TripDetailsLoadingState());

      try {
        final trip = await getTripDetails(event.tripId);
        emit(TripDetailsSuccessState(trip));
      } catch (error) {
     
        emit(TripDetailsErrorState(
            'Something went wrong. Please try again.'));
      }
    });

    on<UpdateTripEvent>((event, emit) async {
      try {
        await updateTrip(event.tripId, event.body,event.image);
        emit(TripUpdateSuccessState());
        
      } catch (error) {
       
        emit(TripDetailsErrorState(
            'Something went wrong. Please try again.'));
      }
    });
  }
}
