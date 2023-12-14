import 'package:bloc/bloc.dart';
import 'package:capstone_1/models/trip.dart';
import 'package:capstone_1/services/supabase_request.dart';
import 'package:meta/meta.dart';

part 'profile_trips_event.dart';
part 'profile_trips_state.dart';

class ProfileTripsBloc extends Bloc<ProfileTripsEvent, ProfileTripsState> {
  ProfileTripsBloc() : super(ProfileTripsInitial()) {
    on<GetProfileTripsEvent>((event, emit) async {
      final List<Trip> tripsList = await getOwnerTrips(event.id);
      emit(GetTripsSuccessedState(tripsList));
    });

    on<GetJointTripsEvent>((event, emit) async {
      final List<Trip> tripsList = await getTrips(Userid: event.id);
      emit(GetJointTripsSuccessedState(tripsList));
    });
  }
}
