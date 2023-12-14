import 'package:capstone_1/blocs/profile_bloc/profile_bloc.dart';
import 'package:capstone_1/blocs/profile_bloc/profile_event.dart';
import 'package:capstone_1/blocs/profile_bloc/profile_state.dart';
import 'package:capstone_1/blocs/theme_bloc/theme_bloc.dart';
import 'package:capstone_1/blocs/theme_bloc/theme_event.dart';
import 'package:capstone_1/blocs/theme_bloc/theme_state.dart';
import 'package:capstone_1/globals/global_user.dart';
import 'package:capstone_1/screens/profile_screens/edit_profile_screen.dart';
import 'package:capstone_1/screens/profile_screens/followers_users_screen.dart';
import 'package:capstone_1/screens/profile_screens/following_users_screen.dart';
import 'package:capstone_1/screens/trip_screens/form_screen.dart';
import 'package:capstone_1/screens/auth_screens/signin_screen.dart';
import 'package:capstone_1/widgets/following_button.dart';
import 'package:capstone_1/widgets/profile_left_widget.dart';
import 'package:capstone_1/widgets/profile_popup_menu.dart';
import 'package:capstone_1/widgets/profile_right_widget.dart';
import 'package:capstone_1/widgets/profile_taps.dart';
import 'package:capstone_1/widgets/user_avtar.dart';
import 'package:capstone_1/widgets/user_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ThemeBloc>();
    context.read<ProfileBloc>().add(GetInfoEvent());
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('Profile',
              style: TextStyle(
                  color: Color(0xff023047), fontWeight: FontWeight.bold)),
          actions: [
            BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, state) {
                return ProfilePopUpMenu(
                  editProfile: PopupMenuItem(
                    child: const ListTile(
                      leading: Icon(Icons.edit, color: Color(0xff023047)),
                      title: Text(
                        'Edit Profile',
                        style: TextStyle(color: Color(0xff023047)),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EditProfileScreen()));
                    },
                  ),
                  signout: PopupMenuItem(
                    child: const ListTile(
                      leading: Icon(
                        Icons.logout_outlined,
                        color: Color(0xffFB8500),
                      ),
                      title: Text(
                        'Sign Out',
                        style: TextStyle(
                          color: Color(0xffFB8500),
                        ),
                      ),
                    ),
                    onTap: () {
                      final supabase = Supabase.instance.client;
                      supabase.auth.signOut();
                      currentUser = null;
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SigninScreen()),
                          (route) => false);
                    },
                  ),
                  mode: PopupMenuItem(
                    child: ListTile(
                      leading:
                          const Icon(Icons.dark_mode, color: Color(0xff023047)),
                      title: const Text(
                        'Mode',
                        style: TextStyle(color: Color(0xff023047)),
                      ),
                      trailing: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: SizedBox(
                          height: 15,
                          width: 15,
                          child: BlocBuilder<ThemeBloc, ThemeState>(
                            buildWhen: (oldState, newState) {
                              if (newState is ChangeModeState) {
                                return true;
                              }
                              return false;
                            },
                            builder: (context, state) {
                              return Switch(
                                value: bloc.dark,
                                onChanged: (value) {
                                  context
                                      .read<ThemeBloc>()
                                      .add(ChangeModeEvent(mode: value));
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    onTap: () {},
                  ),
                );
              },
            ),
          ],
        ),

       
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(184, 255, 184, 3),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const TripFormScreen()));
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),

       
        body: SafeArea(
          child: ListView(
           
            shrinkWrap: true,
            children: [
              BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  if (state is LoadingInfoState) {
                    return SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.26,
                        child: const Center(
                            child: CircularProgressIndicator(
                                color: Color(0xff023047))));
                  } else if (state is GetInfoState) {
                    return Container(
                      padding: const EdgeInsets.all(20),
                      width: double.infinity,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              UserAvatar(
                                src: state.user.imageUrl.toString(),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Container(
                                width: 1,
                                height: 75,
                                color: const Color.fromARGB(150, 158, 158, 158),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              UserInfo(
                                age: '${state.user.age.toString()} years',
                                city: state.user.city.toString(),
                                name: state.user.name.toString(),
                                phone: state.user.phone.toString(),
                              ),
                            ],
                          ),


                          Padding(
                            padding: const EdgeInsets.only(left: 130.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                FollowingButton(
                                  text: 'Following',
                                  noOfusers: state.followingUsers.length,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                FollowingUsersScreen(
                                                    user: state.user,
                                                    dirction: 0)));
                                  },
                                ),
                                const SizedBox(width: 20),
                                FollowingButton(
                                  text: 'Followers',
                                  noOfusers: state.followersUsers.length,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                FollowersUsersScreen(
                                                    user: state.user,
                                                    dirction: 0)));
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
              ProfileTaps(
                leftWidget:
                    ProfileLeftWidget(tripOwnerId: currentUser!.user_uuid!),
                rightWidget:
                    ProfileRightWidget(tripOwnerId: currentUser!.user_uuid!),
              ),
              const SizedBox(
                height: 40,
              )
            ],
          ),
        ),
      ),
    );
  }
}
