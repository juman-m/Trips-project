abstract class AuthEvent {}

class SignUpEvent extends AuthEvent {
  final String email;
  final String password;
  final String name;
  final String phone;
  final String age;
  final String city;
  final String gender;

  SignUpEvent(
    this.email,
    this.password,
    this.name,
    this.phone,
    this.age,
    this.city,
    this.gender,
  );
}

class SignInEvent extends AuthEvent {
  final String email;
  final String password;

  SignInEvent(
    this.email,
    this.password,
  );
}

class OTPEvent extends AuthEvent {
  final String otp;
  final String email;
  OTPEvent(this.otp, this.email);
}
