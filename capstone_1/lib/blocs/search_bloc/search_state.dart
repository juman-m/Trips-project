import 'package:capstone_1/models/user.dart';

abstract class SearchState {}

final class SearchInitial extends SearchState {}

class LoadingState extends SearchState {}

class EmptyResponseState extends SearchState {
  String message;
  EmptyResponseState({required this.message});
}

class ResultResponseState extends SearchState {
  List<UserModel> response;
  bool followState;
  ResultResponseState({required this.response, this.followState = false});
}

class ClearSearchState extends SearchState {}

class FollowState extends SearchState {
  List<UserModel> users;
  bool followState;
  FollowState({required this.users, this.followState = false});
}
