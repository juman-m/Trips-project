abstract class EditProfileEvent {}

class UpdateProfileEvent extends EditProfileEvent {
  String name;
  String phone;
  String age;
  String city;

  UpdateProfileEvent(
      {required this.name,
      required this.phone,
      required this.age,
      required this.city});
}
