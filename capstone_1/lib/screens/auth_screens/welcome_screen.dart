// ignore_for_file: use_build_context_synchronously

import 'package:capstone_1/globals/global_user.dart';
import 'package:capstone_1/screens/nav_bar.dart';
import 'package:capstone_1/screens/auth_screens/signup_screen.dart';
import 'package:capstone_1/services/supabase_request.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/assets/GLOBAL GATHERING.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 100.0, left: 20.0),
          
              ),
              Padding(
                padding: const EdgeInsets.only(top: 630),
                child: Center(
                  child: InkWell(
                    onTap: () async {
                      final supabaseClint = Supabase.instance.client;
                      showDialog(
                          context: context,
                          builder: (context) => const Center(
                              child: CircularProgressIndicator(
                                  color: Color(0xff023047))));
                      await Future.delayed(const Duration(seconds: 1),
                          () async {
                        final token =
                            supabaseClint.auth.currentSession?.accessToken;
                        final isExp =
                            supabaseClint.auth.currentSession?.isExpired;
                        if (token != null) {
                          if (isExp!) {
                            await supabaseClint.auth.setSession(supabaseClint
                                .auth.currentSession!.refreshToken!);
                          }
                          currentUser = await getUser();
                          Navigator.pop(context);
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const AppNavigationBar()),
                              (route) => false);
                        } else {
                          Navigator.pop(context);
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUpScreen()),
                              (route) => false);
                        }
                      });
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 45,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(8)),
                      child: const Center(
                        child: Text(
                          "Let's Start !",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
