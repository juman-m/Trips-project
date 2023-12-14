import 'package:capstone_1/blocs/profile_trips_bloc/profile_trips_bloc.dart';
import 'package:capstone_1/globals/global_user.dart';
import 'package:capstone_1/models/trip.dart';
import 'package:capstone_1/screens/trip_screens/trip_details_screen.dart';
import 'package:capstone_1/services/supabase_request.dart';
import 'package:capstone_1/widgets/trip_countener.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class ProfileLeftWidget extends StatelessWidget {
  const ProfileLeftWidget({super.key, required this.tripOwnerId});
  final String tripOwnerId;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileTripsBloc, ProfileTripsState>(
        builder: (context, state) {
      if (state is GetTripsSuccessedState) {
        return Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 24, right: 24),
          child: FutureBuilder(
              future: getOwnerTrips(tripOwnerId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Trip> tripsList = state.trip;
                  return tripsList.isNotEmpty
                      ? SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: GridView.builder(
                             
                              padding: const EdgeInsets.only(bottom: 50),
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10.0,
                                mainAxisSpacing: 10.0,
                                childAspectRatio: 170 / 272,
                              ),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                TripDetailsScreen(
                                                  trip: snapshot.data![index],
                                                ))).then((value) {
                                      if (value == "back") {
                                        context.read<ProfileTripsBloc>().add(
                                            GetProfileTripsEvent(tripOwnerId));
                                      }
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0, vertical: 4),
                                    child: TripCountener(
                                      trip: snapshot.data![index],
                                    ),
                                  ),
                                );
                              }),
                        )
                      : tripOwnerId == currentUser!.user_uuid!
                          ? Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 100,
                                  ),
                                  const Text("add your first trip"),
                                  Lottie.asset('lib/assets/Add.json',
                                      height: 60, width: 60),
                                ],
                              ),
                            )
                          : Center(
                              child: Lottie.asset(
                                  'lib/assets/Animation - 1702414059341.json',
                                  height: 100,
                                  width: 100),
                            );
                } else if (snapshot.hasError) {
                  return const Center(child: Text("error"));
                }
                return const Center(child: CircularProgressIndicator(color: Color(0xff023047)));
              }),
        );
      }

      return Padding(
        padding: const EdgeInsets.only(top: 10.0, left: 24, right: 24),
        child: FutureBuilder(
            future: getOwnerTrips(tripOwnerId),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Trip> tripsList = snapshot.data!;
                return tripsList.isNotEmpty
                    ? SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: GridView.builder(
                           
                            padding: const EdgeInsets.only(bottom: 50),
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10.0,
                              mainAxisSpacing: 10.0,
                              childAspectRatio: 170 / 272,
                            ),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              TripDetailsScreen(
                                                trip: snapshot.data![index],
                                              )));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0, vertical: 4),
                                  child: TripCountener(
                                    trip: snapshot.data![index],
                                  ),
                                ),
                              );
                            }),
                      )
                    : tripOwnerId == currentUser!.user_uuid!
                        ? Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 100,
                                ),
                                const Text("add your first trip"),
                                Lottie.asset('lib/assets/Add.json',
                                    height: 60, width: 60),
                              ],
                            ),
                          )
                        : Center(
                            child: Lottie.asset(
                                'lib/assets/Animation - 1702414059341.json',
                                height: 100,
                                width: 100),
                          );
              } else if (snapshot.hasError) {
                return const Center(child: Text("error"));
              }
              return const Center(child: CircularProgressIndicator(color: Color(0xff023047)));
            }),
      );
    });
  }
}
