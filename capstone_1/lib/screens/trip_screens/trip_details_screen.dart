// ignore_for_file: use_build_context_synchronously

import 'package:capstone_1/blocs/home_bloc/home_bloc.dart';
import 'package:capstone_1/blocs/profile_trips_bloc/profile_trips_bloc.dart';
import 'package:capstone_1/blocs/trip_bloc/trip_bloc.dart';
import 'package:capstone_1/globals/global_user.dart';
import 'package:capstone_1/models/trip.dart';
import 'package:capstone_1/models/user.dart';
import 'package:capstone_1/screens/trip_screens/edit_trip.dart';
import 'package:capstone_1/screens/profile_screens/users_profile_screen.dart';
import 'package:capstone_1/services/supabase_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TripDetailsScreen extends StatefulWidget {
  const TripDetailsScreen({
    super.key,
    required this.trip,
  });
  final Trip trip;

  @override
  State<TripDetailsScreen> createState() => _TripDetailsScreenState();
}

class _TripDetailsScreenState extends State<TripDetailsScreen> {
  bool isJoint = false;
  @override
  initState() {
    context.read<TripBloc>().add(
        GetUsersEvent(widget.trip, currentUser!.user_uuid!, widget.trip.id!));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
        title: Text(widget.trip.title!),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16, top: 8.0),
        child: ListView(
          children: [
            Container(
              width: 376,
              height: 320,
              decoration: ShapeDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.trip.image!),
                  fit: BoxFit.fill,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(34),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.trip.title ?? "-",
                        style: const TextStyle(
                          color: Color(0xFF101018),
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.52,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.trip.description ?? "-",
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF818E9C),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.calendar_month,
                            color: Color.fromARGB(155, 251, 134, 0),
                          ),
                          const SizedBox(width: 8),
                          SizedBox(
                            width: 100,
                            child: Text(
                              widget.trip.date ?? "-",
                              style: const TextStyle(
                                color: Color(0xFF818E9C),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                height: 0.10,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      Container(
                        width: 1,
                        height: 20, // Adjust the height as needed
                        color: Colors.grey, // Adjust the color as needed
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.timelapse,
                            color: Color.fromARGB(155, 251, 134, 0),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            widget.trip.time!,
                            style: const TextStyle(
                              color: Color(0xFF818E9C),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              height: 0.10,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Color.fromARGB(155, 251, 134, 0),
                          ),
                          const SizedBox(width: 8),
                          SizedBox(
                            width: 100,
                            child: Text(
                              widget.trip.location!,
                              style: const TextStyle(
                                color: Color(0xFF818E9C),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                height: 0.10,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      Container(
                        width: 1,
                        height: 20, // Adjust the height as needed
                        color: Colors.grey, // Adjust the color as needed
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.monetization_on_rounded,
                            color: Color.fromARGB(155, 251, 134, 0),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            widget.trip.cost.toString(),
                            style: const TextStyle(
                              color: Color(0xFF818E9C),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              height: 0.10,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  BlocBuilder<TripBloc, TripState>(
                    builder: (context, state) {
                      if (state is GetUserSuccessedState) {
                        return TextButton(
                          onPressed: () async {
                            final UserModel user =
                                await getAUser(widget.trip.tripCreator!);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UsersProfileScreen(
                                          user: user,
                                          identity: user,
                                        )));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                'Trip Creator:  ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                '${state.user.name}',
                                style: const TextStyle(
                                  color: Color(0xff023047),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return const Text(
                        '--- ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 13),
                  widget.trip.tripCreator == currentUser!.user_uuid
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                            
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditTripScreen(
                                            existingTrip: widget.trip)));
                               
                              },
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(176, 255, 184, 3),
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(48),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          const Color.fromARGB(164, 255, 184, 3)
                                              .withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: const Center(
                                    child: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                )),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            InkWell(
                              onTap: () async {
                                bool deleteConfirmed = await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog.adaptive(
                                      title: const Text('Delete Confirmation'),
                                      content: const Text(
                                          'Are you sure you want to delete this trip?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop(false);
                                          },
                                          child: const Text(
                                            'Cancel',
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  168, 255, 102, 0),
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop(true);
                                          },
                                          child: const Text(
                                            'Confirm',
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  168, 255, 102, 0),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );

                                if (deleteConfirmed == true) {
                                  
                                  await deleteTrip(id: widget.trip.id!);
                                  context.read<HomeBloc>().add(GetTripsEvent());
                                  context.read<ProfileTripsBloc>().add(
                                      GetProfileTripsEvent(
                                          currentUser!.user_uuid!));
                                  Navigator.pop(context, "back");
                                }
                              },
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(168, 255, 102, 0),
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(48),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          const Color.fromARGB(168, 255, 102, 0)
                                              .withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: const Center(
                                    child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                )),
                              ),
                            ),
                          ],
                        )
                      : BlocListener<TripBloc, TripState>(
                          listener: (context, state) {
                            if (state is LoadingState) {
                              showDialog(
                                  context: context,
                                  builder: (context) => const Center(
                                      child: CircularProgressIndicator(color: Color(0xff023047))));
                            }
                            if (state is GetUserSuccessedState) {
                              Navigator.pop(context);
                            }
                          },
                          child: BlocBuilder<TripBloc, TripState>(
                            builder: (context, state) {
                              if (state is GetUserSuccessedState) {
                                return !state.isJoint
                                    ? InkWell(
                                        onTap: () async {
                                          bool deleteConfirmed =
                                              await showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog.adaptive(
                                                title: const Text(
                                                    'Join Confirmation'),
                                                content: const Text(
                                                    'Are you sure you want to join to this trip?'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop(false);
                                                    },
                                                    child: const Text(
                                                      'Cancel',
                                                      style: TextStyle(
                                                          color: Color(
                                                              0xff219EBC)),
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop(true);
                                                    },
                                                    child: const Text(
                                                      'Confirm',
                                                      style: TextStyle(
                                                          color: Color(
                                                              0xff219EBC)),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                          if (deleteConfirmed == true) {
                                            await addUserToTrip({
                                              "joint_id":
                                                  currentUser!.user_uuid,
                                              "trip_id": widget.trip.id
                                            });
                                            context.read<TripBloc>().add(
                                                GetUsersEvent(
                                                    widget.trip,
                                                    currentUser!.user_uuid!,
                                                    widget.trip.id!));

                                            context
                                                .read<ProfileTripsBloc>()
                                                .add(GetProfileTripsEvent(
                                                    currentUser!.user_uuid!));
                                          }
                                        },
                                        child: Container(
                                          width: 346,
                                          height: 55,
                                          decoration: BoxDecoration(
                                            color: const Color(0xff8ECAE6),
                                            shape: BoxShape.rectangle,
                                            borderRadius:
                                                BorderRadius.circular(48),
                                            boxShadow: [
                                              BoxShadow(
                                                color: const Color(0xff8ECAE6)
                                                    .withOpacity(0.5),
                                                spreadRadius: 1,
                                                blurRadius: 10,
                                                offset: const Offset(0, 5),
                                              ),
                                            ],
                                          ),
                                          child: const Center(
                                            child: Text(
                                              'JOIN THE TRIP',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : InkWell(
                                        onTap: () async {
                                          bool deleteConfirmed =
                                              await showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog.adaptive(
                                                title: const Text(
                                                    'Delete Confirmation'),
                                                content: const Text(
                                                    'Are you sure you want to remove yourself from this trip?'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop(false);
                                                    },
                                                    child: const Text(
                                                      'Cancel',
                                                      style: TextStyle(
                                                        color: Color.fromARGB(
                                                            168, 255, 102, 0),
                                                      ),
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop(true);
                                                    },
                                                    child: const Text(
                                                      'Confirm',
                                                      style: TextStyle(
                                                        color: Color.fromARGB(
                                                            168, 255, 102, 0),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          );

                                          if (deleteConfirmed == true) {
                                            await unjointTrip(
                                                userId: currentUser!.user_uuid!,
                                                tripId: widget.trip.id!);
                                            context.read<TripBloc>().add(
                                                GetUsersEvent(
                                                    widget.trip,
                                                    currentUser!.user_uuid!,
                                                    widget.trip.id!));
                                            context
                                                .read<ProfileTripsBloc>()
                                                .add(GetProfileTripsEvent(
                                                    currentUser!.user_uuid!));
                                          }
                                        },
                                        child: Container(
                                          width: 346,
                                          height: 55,
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                168, 255, 102, 0),
                                            shape: BoxShape.rectangle,
                                            borderRadius:
                                                BorderRadius.circular(48),
                                            boxShadow: [
                                              BoxShadow(
                                                color: const Color.fromARGB(
                                                        168, 255, 102, 0)
                                                    .withOpacity(0.5),
                                                spreadRadius: 1,
                                                blurRadius: 10,
                                                offset: const Offset(0, 5),
                                              ),
                                            ],
                                          ),
                                          child: const Center(
                                            child: Text(
                                              'REMOVE THE TRIP',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                              }
                              return Container();
                            },
                          ),
                        )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
