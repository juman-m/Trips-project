import 'package:capstone_1/blocs/profile_bloc/profile_bloc.dart';
import 'package:capstone_1/blocs/profile_bloc/profile_event.dart';
import 'package:capstone_1/blocs/profile_bloc/profile_state.dart';
import 'package:capstone_1/models/user.dart';
import 'package:capstone_1/screens/profile_screens/profile_screen.dart';
import 'package:capstone_1/screens/profile_screens/users_profile_screen.dart';
import 'package:capstone_1/widgets/users_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// ignore: must_be_immutable
class FollowingUsersScreen extends StatelessWidget {
  FollowingUsersScreen({super.key, required this.user, required this.dirction});
  UserModel user;
  int dirction;
  final currentUserId = Supabase.instance.client.auth.currentUser!.id;
  @override
  Widget build(BuildContext context) {
    context.read<ProfileBloc>().add(GetFollowingEvent(user: user));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
            currentUserId == user.user_uuid ? 'My Following' : 'Following'),
        leading: IconButton(
          onPressed: () {
           
            if (dirction == 0) {
              context.read<ProfileBloc>().add(GetInfoEvent());
              Navigator.pop(context);
            } else {
              
              context.read<ProfileBloc>().add(GetUsersInfoEvent(user: user));
              Navigator.pop(context);
            }
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is LoadingFollowingState) {
              return const Center(
                  child: CircularProgressIndicator(color: Color(0xff023047)));
            } else if (state is EmptyFollowingState) {
              return const Center(child: Text('No following'));
            } else if (state is GetFollowingState) {
              return Padding(
                padding: const EdgeInsets.only(top: 24),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: state.followingUsers.length,
                  itemBuilder: (context, i) {
                    if (state.followingUsers[i].user_uuid == currentUserId) {
                      return UsersCard(
                        isVisible: false,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (contsex) => const ProfileScreen()));
                        },
                        user: state.followingUsers[i],
                        buttonText: 'Unfollow',
                        followOnPressed: () {
                          context.read<ProfileBloc>().add(
                              UnFollowEvent(user: state.followingUsers[i]));
                        },
                      );
                    } else {
                      return UsersCard(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (contsex) => UsersProfileScreen(
                                      user: state.followingUsers[i],
                                      direction: 'following',
                                      identity: user)));
                        },
                        user: state.followingUsers[i],
                        buttonText: 'Unfollow',
                        followOnPressed: () {
                          context.read<ProfileBloc>().add(
                              UnFollowEvent(user: state.followingUsers[i]));
                        },
                      );
                    }
                  },
                  separatorBuilder: (context, i) {
                    return SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.01);
                  },
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
