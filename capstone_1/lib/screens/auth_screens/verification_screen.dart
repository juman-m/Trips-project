// ignore_for_file: use_build_context_synchronously

import 'package:capstone_1/blocs/auth_bloc/auth_bloc.dart';
import 'package:capstone_1/blocs/auth_bloc/auth_events.dart';
import 'package:capstone_1/blocs/auth_bloc/auth_states.dart';
import 'package:capstone_1/screens/nav_bar.dart';
import 'package:capstone_1/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({
    super.key,
    required this.email,
  });
  final String email;

  @override
  Widget build(BuildContext context) {
    TextEditingController otpController = TextEditingController();

    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Verification",
              style: TextStyle(
                  fontSize: 35,
                  color: Color(0xff8ECAE6),
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 80,
            ),
            AddTextField(
              label: 'OTP',
              hint: 'Enter your OTP',
              isPassword: false,
              controller: otpController,
              icon: Icons.password_rounded,
              isAge: false,
            ),
            const SizedBox(
              height: 100,
            ),
            BlocListener<AuthBloc, AuthStates>(
              listener: (context, state) {
                if (state is LoadingOtpState) {
                  showDialog(
                      context: context,
                      builder: (context) =>
                          const Center(child: CircularProgressIndicator(color: Color(0xff023047))));
                } else if (state is ErrorOtpState) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.message)));
                } else if (state is SuccessOtpState) {
                  Navigator.pop(context);
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AppNavigationBar()),
                      (route) => false);
                }
              },
              child: InkWell(
                onTap: () async {
                  context
                      .read<AuthBloc>()
                      .add(OTPEvent(otpController.text, email));
                },
                child: Container(
                  width: 330,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xff8ECAE6)),
                  child: const Center(
                    child: Text(
                      "Send",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
