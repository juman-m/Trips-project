import 'package:bloc/bloc.dart';
import 'package:capstone_1/models/trip.dart';
import 'package:capstone_1/services/supabase_request.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<GetTripsEvent>((event, emit) async {
      final List<Trip> tripsList = await getTrips();
      emit(GetTripsSuccessedState(tripsList));
    });
  }
}
