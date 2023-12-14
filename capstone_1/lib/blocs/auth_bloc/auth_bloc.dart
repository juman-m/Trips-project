import 'package:capstone_1/blocs/auth_bloc/auth_events.dart';
import 'package:capstone_1/blocs/auth_bloc/auth_states.dart';
import 'package:capstone_1/globals/global_user.dart';
import 'package:capstone_1/models/user.dart';
import 'package:capstone_1/services/supabase_request.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthBloc extends Bloc<AuthEvent, AuthStates> {
  AuthBloc() : super(InitialState()) {
    on<SignUpEvent>((event, emit) async {
      emit(LoadingSignUpState());
      try {
        if (event.email.isNotEmpty &&
            event.name.isNotEmpty &&
            event.password.isNotEmpty) {
          if (RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(event.email)) {
            final supabase = Supabase.instance.client;

            await supabase.auth
                .signUp(email: event.email, password: event.password);

            user = UserModel(
                name: event.name,
                email: event.email,
                phone: event.phone,
                age: int.tryParse(event.age),
                gender: event.gender,
                imageUrl:
                    "https://cdn-icons-png.flaticon.com/512/5987/5987424.png",
                city: event.city);

            emit(SuccessSignUpState());
          } else {
            emit(ErrorSignUpState("Please enter correct email"));
          }
        } else {
          emit(ErrorSignUpState("Please enter all fields"));
        }
      } catch (authException) {
        if (authException is AuthException) {
          print("AuthException: ${authException.message}");
          emit(ErrorSignUpState(authException.message));
        } else {
        
          print("Unexpected error: $authException");
          emit(ErrorSignUpState("Unexpected error occurred"));
        }
      }
    });

    on<OTPEvent>((event, emit) async {
      emit(LoadingOtpState());
      try {
        if (event.otp.isNotEmpty) {
          final supabase = Supabase.instance.client;
          final authResponse = await supabase.auth.verifyOTP(
              token: event.otp, type: OtpType.signup, email: event.email);

          print(Supabase.instance.client.auth.currentUser!.id);
          print(authResponse.user!.id);

          addUser({
            "name": user!.name,
            "email": user!.email,
            "user_uuid": authResponse.user!.id,
            "gender": user!.gender,
            "phone": user!.phone,
            "city": user!.city,
            "image_url": user!.imageUrl,
            "age": user!.age,
          });
          currentUser = await getUser();
          emit(SuccessOtpState());
        } else {
          emit(ErrorOtpState("Please enter otp"));
        }
      } catch (e) {
        print(e);
        emit(ErrorOtpState("Error !!"));
      }
    });

    on<SignInEvent>((event, emit) async {
      emit(LoadingSignInState());
      try {
        if (event.email.isNotEmpty && event.password.isNotEmpty) {
          final supabase = Supabase.instance.client;
          await Future.delayed(const Duration(seconds: 1));

          final login = await supabase.auth
              .signInWithPassword(email: event.email, password: event.password);
          if (login.user?.id != null) {
            currentUser = await getUser();
            emit(SuccessSignInState());
          } else {
            emit(ErrorSignInState("Email or password is error"));
          }
          currentUser = await getUser();
          emit(SuccessSignInState());
        } else {
          emit(ErrorSignInState("Please enter all fields"));
        }
      } catch (e) {
        print(e);
        emit(ErrorSignInState("Error !!"));
      }
    });
  }
}
