import 'package:capstone_1/models/user.dart';

abstract class SearchEvent {}

class SearchRequestEvent extends SearchEvent {
  String query;
  SearchRequestEvent({required this.query});
}

class ClearSearchEvent extends SearchEvent {}

class FollowEvent extends SearchEvent {
  UserModel user;
  String query;
  FollowEvent({required this.user, required this.query});
}
