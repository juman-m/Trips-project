abstract class EditProfileState {}

final class EditProfileInitial extends EditProfileState {}

class GetCurrentInfoState extends EditProfileState {}

class UpdateProfileState extends EditProfileState {}

class LoadingState extends EditProfileState {}

class EmptyState extends EditProfileState {
  String message;
  EmptyState({required this.message});
}

class ErrorState extends EditProfileState {
  String message;
  ErrorState({required this.message});
}
