import 'package:capstone_1/blocs/profile_bloc/profile_event.dart';
import 'package:capstone_1/blocs/profile_bloc/profile_state.dart';
import 'package:capstone_1/services/supabase_request.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<GetInfoEvent>((event, emit) async {
      final currentUserId = Supabase.instance.client.auth.currentUser!.id;
      emit(LoadingInfoState());
      final user = await getUser();
      final followingUsers = await getFollowing(currentUserId);
      final followersUsers = await getFollowers(currentUserId);
      emit(GetInfoState(
          user: user,
          followingUsers: followingUsers,
          followersUsers: followersUsers));
    });

    on<GetFollowingEvent>((event, emit) async {
      emit(LoadingFollowingState());
      final followingUsers =
          await getFollowing(event.user.user_uuid.toString());
      if (followingUsers.isEmpty) {
        emit(EmptyFollowingState());
      } else {
        emit(GetFollowingState(followingUsers: followingUsers));
      }
    });

    on<GetFollowersEvent>((event, emit) async {
      emit(LoadingFollowersState());
      final followersUsers =
          await getFollowers(event.user.user_uuid.toString());
      if (followersUsers.isEmpty) {
        emit(EmptyFollowersState());
      } else {
        for (var element in followersUsers) {
          var check = await isFollowed(
              Supabase.instance.client.auth.currentUser!.id,
              element.user_uuid.toString());
          if (check == false) {
            element.followState = false;
          } else if (check == true) {
            element.followState = true;
          }
        }
        emit(GetFollowersState(followersUsers: followersUsers));
      }
    });
//******************************************/
    on<FollowEvent>((event, emit) async {
      final currentUserId = Supabase.instance.client.auth.currentUser!.id;
      final check =
          await isFollowed(currentUserId, event.user.user_uuid.toString());
      if (check == false) {
        emit(LoadingFollowersState());
        await follow(currentUserId, event.user.user_uuid.toString());
        final followersUsers = await getFollowers(currentUserId);
        emit(
            UpdateFollowersState(followersUsers: followersUsers, check: false));
      } else {
        return;
      }
      // final currentUserId = Supabase.instance.client.auth.currentUser!.id;
      // final check =
      //     await isFollowed(currentUserId, event.user.user_uuid.toString());
      // final List<UserModel> followersUsers = await getFollowers(currentUserId);
      // if (check == false) {
      //   // await follow(currentUserId, event.user.user_uuid.toString());
      //   for (var element in followersUsers) {
      //     if (element.user_uuid == event.user.user_uuid) {
      //       await follow(currentUserId, event.user.user_uuid.toString());
      //       element.followState = false;
      //       print(
      //           '===============FROM BLOC ${element.followState}===============');
      //     }
      //   }
      // } else if (check == true) {
      //   // await unfollow(event.user.user_uuid.toString());
      //   for (var element in followersUsers) {
      //     if (element.user_uuid == event.user.user_uuid) {
      //       await unfollow(event.user.user_uuid.toString());
      //       element.followState = true;
      //       print(
      //           '===============FROM BLOC ${element.followState}===============');
      //     }
      //   }
      // }
      // emit(GetFollowersState(followersUsers: followersUsers));
    });

    on<UnFollowEvent>((event, emit) async {
      emit(LoadingFollowingState());
      await unfollow(event.user.user_uuid.toString());
      final followingUsers =
          await getFollowing(Supabase.instance.client.auth.currentUser!.id);
      if (followingUsers.isEmpty) {
        emit(EmptyFollowingState());
      } else {
        emit(GetFollowingState(followingUsers: followingUsers));
      }
    });
//******************************************/
    on<GetUsersInfoEvent>((event, emit) async {
      emit(LoadingUsersInfoState());
      final user = await getUserById(event.user.user_uuid.toString());
      final followingUsers =
          await getFollowing(event.user.user_uuid.toString());
      final followersUsers =
          await getFollowers(event.user.user_uuid.toString());
      emit(GetUsersInfoState(
          user: user,
          followingUsers: followingUsers,
          followersUsers: followersUsers));
    });
  }
}
