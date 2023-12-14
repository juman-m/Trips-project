import 'package:capstone_1/globals/global_user.dart';
import 'package:capstone_1/models/trip.dart';
import 'package:capstone_1/screens/trip_screens/trip_details_screen.dart';
import 'package:capstone_1/services/supabase_request.dart';
import 'package:capstone_1/widgets/trip_countener.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class FollowingTripGridView extends StatelessWidget {
  const FollowingTripGridView({
    super.key,
    this.selectedCategory,
  });
  final selectedCategory;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getFollowingTrips(id: currentUser!.user_uuid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Trip> tripsList = snapshot.data!;
            if (selectedCategory != "All") {
              tripsList = snapshot.data!
                  .where((element) => element.category == selectedCategory)
                  .toList();
            }
            return tripsList.isNotEmpty
                ? SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.7,
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
                        itemCount: tripsList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TripDetailsScreen(
                                            trip: tripsList[index],
                                          )));
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4.0, vertical: 4),
                              child: TripCountener(
                                trip: tripsList[index],
                              ),
                            ),
                          );
                        }),
                  )
                : Center(
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset('lib/assets/Animation - 1702283696079.json',
                          height: 100, width: 100),
                      const Text(
                        "Add Your First Friend",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      )
                    ],
                  ));
          } else if (snapshot.hasError) {
            return const Center(child: Text("error"));
          }
          return const Center(child: CircularProgressIndicator(color: Color(0xff023047)));
        });
  }
}
