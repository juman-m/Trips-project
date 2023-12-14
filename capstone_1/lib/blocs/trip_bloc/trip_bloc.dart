import 'package:bloc/bloc.dart';
import 'package:capstone_1/models/trip.dart';
import 'package:capstone_1/models/user.dart';
import 'package:capstone_1/services/supabase_request.dart';

part 'trip_event.dart';
part 'trip_state.dart';

class TripBloc extends Bloc<TripEvent, TripState> {
  TripBloc() : super(TripInitial()) {
    on<GetUsersEvent>((event, emit) async {
      emit(LoadingState());
      final UserModel user = await getAUser(event.trip.tripCreator!);
      final bool isJoint = await searchUserInTrip(
        tripId: event.tripId,
        userId: event.userId,
      );
      emit(GetUserSuccessedState(user, isJoint));
    });
  }
}
