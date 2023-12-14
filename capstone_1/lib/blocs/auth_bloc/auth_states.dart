abstract class AuthStates {}

class InitialState extends AuthStates {}

class SuccessSignUpState extends AuthStates {}

class SuccessSignInState extends AuthStates {}

class SuccessOtpState extends AuthStates {}

class LoadingSignUpState extends AuthStates {}

class ErrorSignUpState extends AuthStates {
  final String message;

  ErrorSignUpState(this.message);
}

class LoadingSignInState extends AuthStates {}

class ErrorSignInState extends AuthStates {
  final String message;

  ErrorSignInState(this.message);
}

class LoadingOtpState extends AuthStates {}

class ErrorOtpState extends AuthStates {
  final String message;

  ErrorOtpState(this.message);
}
