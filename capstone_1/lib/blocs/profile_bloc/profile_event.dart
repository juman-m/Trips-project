import 'package:capstone_1/models/user.dart';

abstract class ProfileEvent {}

class GetInfoEvent extends ProfileEvent {}

class GetFollowingEvent extends ProfileEvent {
  UserModel user;
  GetFollowingEvent({required this.user});
}

class GetFollowersEvent extends ProfileEvent {
  UserModel user;
  GetFollowersEvent({required this.user});
}

class FollowEvent extends ProfileEvent {
  UserModel user;
  FollowEvent({required this.user});
}

class UnFollowEvent extends ProfileEvent {
  UserModel user;
  UnFollowEvent({required this.user});
}

class GetUsersInfoEvent extends ProfileEvent {
  UserModel user;
  GetUsersInfoEvent({required this.user});
}
