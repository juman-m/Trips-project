part of 'chat_bloc.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class GetUsersSuccessedState extends ChatState {
  final List<UserModel> users;

  GetUsersSuccessedState(this.users);
}

final class ErrorGetUsersState extends ChatState {}