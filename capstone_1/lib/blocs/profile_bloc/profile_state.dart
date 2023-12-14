import 'package:capstone_1/models/user.dart';

abstract class ProfileState {}

final class ProfileInitial extends ProfileState {}

class LoadingInfoState extends ProfileState {}

class GetInfoState extends ProfileState {
  UserModel user;
  List<UserModel> followingUsers;
  List<UserModel> followersUsers;
  GetInfoState(
      {required this.user,
      required this.followingUsers,
      required this.followersUsers});
}

class LoadingFollowingState extends ProfileState {}

class EmptyFollowingState extends ProfileState {}

class GetFollowingState extends ProfileState {
  List<UserModel> followingUsers;
  GetFollowingState({required this.followingUsers});
}

class LoadingFollowersState extends ProfileState {}

class EmptyFollowersState extends ProfileState {}

class GetFollowersState extends ProfileState {
  List<UserModel> followersUsers;
  GetFollowersState({required this.followersUsers});
}

class UpdateFollowersState extends ProfileState {
  List<UserModel> followersUsers;
  bool check;
  UpdateFollowersState({required this.followersUsers, required this.check});
}

class LoadingTripsState extends ProfileState {}

class FollowState extends ProfileState {
  String followState;
  FollowState({required this.followState});
}

class UnFollowState extends ProfileState {
  List<UserModel> followersUsers;
  UnFollowState({required this.followersUsers});
}

class LoadingUsersInfoState extends ProfileState {}

class GetUsersInfoState extends ProfileState {
  UserModel user;
  List<UserModel> followingUsers;
  List<UserModel> followersUsers;
  GetUsersInfoState(
      {required this.user,
      required this.followingUsers,
      required this.followersUsers});
}
