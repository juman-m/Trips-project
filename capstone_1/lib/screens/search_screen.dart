import 'package:capstone_1/blocs/search_bloc/search_bloc.dart';
import 'package:capstone_1/blocs/search_bloc/search_event.dart';
import 'package:capstone_1/blocs/search_bloc/search_state.dart';
import 'package:capstone_1/screens/profile_screens/profile_screen.dart';
import 'package:capstone_1/screens/profile_screens/users_profile_screen.dart';
import 'package:capstone_1/widgets/search_text_field.dart';
import 'package:capstone_1/widgets/users_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// ignore: must_be_immutable
class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  TextEditingController searchController = TextEditingController();
  String aQuery = '';
  final currentUserId = Supabase.instance.client.auth.currentUser!.id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
                BlocBuilder<SearchBloc, SearchState>(
                  builder: (context, state) {
                    if (state is ClearSearchState) {
                      SearchTextField(
                        controller: searchController,
                        onChange: (query) {
                          aQuery = query;
                          context
                              .read<SearchBloc>()
                              .add(SearchRequestEvent(query: query));
                        },
                      );
                    }

                    return SearchTextField(
                      controller: searchController,
                      onChange: (query) {
                        aQuery = query;
                        context
                            .read<SearchBloc>()
                            .add(SearchRequestEvent(query: query));
                      },
                    );
                  },
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
                BlocConsumer<SearchBloc, SearchState>(
                  listener: (context, state) {
                    if (state is LoadingState) {
                      showDialog(
                          context: context,
                          builder: (context) => const Center(
                              child: CircularProgressIndicator(
                                  color: Color(0xff023047))));
                    }
                  },
                  builder: (context, state) {
                    if (state is ResultResponseState) {
                      Navigator.maybePop(context);
                      return state.response.isNotEmpty
                          ? SizedBox(
                              height: MediaQuery.of(context).size.height * 0.6,
                              child: ListView.separated(
                                shrinkWrap: true,
                                itemCount: state.response.length,
                                itemBuilder: (context, i) {
                                  if (state.response[i].user_uuid ==
                                      currentUserId) {
                                    return UsersCard(
                                      isVisible: false,
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (contsex) =>
                                                    const ProfileScreen()));
                                      },
                                      user: state.response[i],
                                      followOnPressed: () {},
                                    );
                                  } else {
                                    return state.response[i].followState ==
                                            false
                                        ? UsersCard(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (contsex) =>
                                                          UsersProfileScreen(
                                                              user: state
                                                                  .response[i],
                                                              identity: state
                                                                      .response[
                                                                  i])));
                                            },
                                            user: state.response[i],
                                            buttonText: 'Follow',
                                            buttonTextColor:
                                                const Color(0xff023047),
                                            followOnPressed: () {
                                              context.read<SearchBloc>().add(
                                                  FollowEvent(
                                                      user: state.response[i],
                                                      query: aQuery));
                                            },
                                          )
                                        : UsersCard(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (contsex) =>
                                                          UsersProfileScreen(
                                                              user: state
                                                                  .response[i],
                                                              identity: state
                                                                      .response[
                                                                  i])));
                                            },
                                            user: state.response[i],
                                            buttonText: 'Unfollow',
                                            buttonTextColor: Colors.red,
                                            followOnPressed: () {
                                              context.read<SearchBloc>().add(
                                                  FollowEvent(
                                                      user: state.response[i],
                                                      query: aQuery));
                                            },
                                          );
                                  }
                                },
                                separatorBuilder: (context, i) {
                                  return SizedBox(
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                              0.01);
                                },
                              ),
                            )
                          : Container();
                    } else if (state is FollowState) {
                      Navigator.maybePop(context);
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: state.users.length,
                          itemBuilder: (context, i) {
                            if (state.users[i].user_uuid == currentUserId) {
                             
                             
                              return UsersCard(
                                isVisible: false,
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (contsex) =>
                                              const ProfileScreen()));
                                },
                                user: state.users[i],
                                buttonText: state.users[i].followState == false
                                    ? 'Follow'
                                    : 'Unfollow',
                                buttonTextColor:
                                    state.users[i].followState == false
                                        ? const Color(0xff023047)
                                        : Colors.red,
                                followOnPressed: () {},
                              );
                            } else {
                              return state.users[i].followState == false
                                  ? UsersCard(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (contsex) =>
                                                    UsersProfileScreen(
                                                        user: state.users[i],
                                                        identity:
                                                            state.users[i])));
                                      },
                                      user: state.users[i],
                                      buttonText: 'Unfollow',
                                      buttonTextColor: Colors.red,
                                      followOnPressed: () {
                                    
                                        context.read<SearchBloc>().add(
                                            FollowEvent(
                                                user: state.users[i],
                                                query: aQuery));
                                      },
                                    )
                                  : UsersCard(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (contsex) =>
                                                    UsersProfileScreen(
                                                        user: state.users[i],
                                                        identity:
                                                            state.users[i])));
                                      },
                                      user: state.users[i],
                                      buttonText: 'Follow',
                                      buttonTextColor: const Color(0xff023047),
                                      followOnPressed: () {
                                      
                                        context.read<SearchBloc>().add(
                                            FollowEvent(
                                                user: state.users[i],
                                                query: aQuery));
                                      },
                                    );
                            }
                          },
                          separatorBuilder: (context, i) {
                            return SizedBox(
                                height:
                                    MediaQuery.sizeOf(context).height * 0.01);
                          },
                        ),
                      );
                    }
                    return const Text("");
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
