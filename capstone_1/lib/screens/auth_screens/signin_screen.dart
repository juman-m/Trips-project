// ignore_for_file: use_build_context_synchronously

import 'package:capstone_1/blocs/auth_bloc/auth_bloc.dart';
import 'package:capstone_1/blocs/auth_bloc/auth_events.dart';
import 'package:capstone_1/blocs/auth_bloc/auth_states.dart';
import 'package:capstone_1/screens/nav_bar.dart';
import 'package:capstone_1/screens/auth_screens/signup_screen.dart';
import 'package:capstone_1/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 50,
          ),
          const Text(
            "Sign in",
            style: TextStyle(
                fontSize: 35,
                color: Color(0xff219EBC),
                fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 40,
          ),
          AddTextField(
            isAge: false,
            label: 'Email',
            hint: 'Enter your email',
            isPassword: false,
            controller: emailController,
            icon: Icons.email,
          ),
          const SizedBox(
            height: 30,
          ),
          AddTextField(
            label: 'Password',
            hint: 'Enter Password',
            isAge: false,
            isPassword: true,
            controller: passwordController,
            icon: Icons.password_rounded,
          ),
          const SizedBox(
            height: 48,
          ),
          BlocListener<AuthBloc, AuthStates>(
            listener: (context, state) {
              if (state is LoadingSignInState) {
                showDialog(
                    context: context,
                    builder: (context) =>
                        const Center(child: CircularProgressIndicator(color: Color(0xff023047))));
              } else if (state is ErrorSignInState) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              } else if (state is SuccessSignInState) {
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
                context.read<AuthBloc>().add(SignInEvent(
                      emailController.text,
                      passwordController.text,
                    ));
              },
              child: Container(
                width: 330,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xff8ECAE6)),
                child: const Center(
                  child: Text(
                    "Sign in",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Don't have an account yet?"),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUpScreen(),
                      ));
                },
                child: const Text(
                  "  Sign up",
                  style: TextStyle(
                      fontSize: 15,
                      color: Color(0xff219EBC),
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
