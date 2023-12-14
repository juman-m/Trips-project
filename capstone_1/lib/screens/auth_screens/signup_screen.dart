import 'package:capstone_1/blocs/auth_bloc/auth_bloc.dart';
import 'package:capstone_1/blocs/auth_bloc/auth_events.dart';
import 'package:capstone_1/blocs/auth_bloc/auth_states.dart';
import 'package:capstone_1/screens/auth_screens/signin_screen.dart';
import 'package:capstone_1/screens/auth_screens/verification_screen.dart';
import 'package:capstone_1/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_radio_button/group_radio_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String gender = "Female";
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final ageController = TextEditingController();
  final genderList = [
    "Female",
    "Male",
  ];
  String selectedCity = 'Riyadh';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 40,
              ),
              const Text(
                "Sign up",
                style: TextStyle(
                    fontSize: 40,
                    color: Color(0xff8ECAE6),
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 30,
              ),
              AddTextField(
                label: 'Name',
                hint: 'your name',
                isPassword: false,
                controller: nameController,
                icon: Icons.person,
                isAge: false,
              ),
              const SizedBox(
                height: 30,
              ),
              AddTextField(
                label: 'Email Adress',
                hint: 'your email',
                isPassword: false,
                controller: emailController,
                icon: Icons.email,
                isAge: false,
              ),
              const SizedBox(
                height: 30,
              ),
              AddTextField(
                label: 'Password',
                hint: 'your password',
                isPassword: true,
                controller: passwordController,
                icon: Icons.password,
                isAge: false,
              ),
              const SizedBox(
                height: 30,
              ),
              AddTextField(
                label: 'Phone',
                hint: 'your phone number',
                isPassword: false,
                controller: phoneController,
                icon: Icons.phone,
                isAge: true,
              ),
              const SizedBox(
                height: 30,
              ),
              AddTextField(
                label: 'Age',
                hint: 'your age',
                isPassword: false,
                controller: ageController,
                icon: Icons.numbers,
                isAge: true,
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Select City:",
                        style:
                            TextStyle(fontSize: 16, color: Color(0xff219EBC)),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.grey[200],
                        ),
                        child: DropdownButton<String>(
                          value: selectedCity,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedCity = newValue!;
                            });
                          },
                          items: <String>['Riyadh', 'Jeddah', 'Dammam']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(fontSize: 14),
                              ),
                            );
                          }).toList(),
                          icon: const Icon(Icons.arrow_drop_down,
                              color: Color(0xff219EBC)),
                          iconSize: 36,
                          elevation: 16,
                          style: const TextStyle(color: Colors.black),
                          underline: Container(
                            height: 2,
                            color: const Color(0xff219EBC),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        "Select Gender:",
                        style:
                            TextStyle(fontSize: 16, color: Color(0xff219EBC)),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      RadioGroup<String>.builder(
                        groupValue: gender,
                        onChanged: (value) {
                          gender = value!;
                          setState(() {});
                        },
                        items: genderList,
                        itemBuilder: (item) => RadioButtonBuilder(
                          item,
                        ),
                        fillColor: const Color(0xff8ECAE6),
                      ),
                    ]),
              ),
              const SizedBox(
                height: 30,
              ),
              BlocListener<AuthBloc, AuthStates>(
                listener: (context, state) {
                  if (state is LoadingSignUpState) {
                    showDialog(
                        context: context,
                        builder: (context) => const Center(
                            child: CircularProgressIndicator(
                                color: Color(0xff023047))));
                  } else if (state is ErrorSignUpState) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.message)));
                  } else if (state is SuccessSignUpState) {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              VerificationScreen(email: emailController.text),
                        ));
                  }
                },
                child: InkWell(
                  onTap: () async {
                    context.read<AuthBloc>().add(SignUpEvent(
                          emailController.text,
                          passwordController.text,
                          nameController.text,
                          phoneController.text,
                          ageController.text,
                          selectedCity,
                          gender,
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
                        "Sign up",
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
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Joined us before?"),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SigninScreen(),
                          ));
                    },
                    child: const Text(
                      "  Sign in",
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
        ],
      ),
    );
  }
}
