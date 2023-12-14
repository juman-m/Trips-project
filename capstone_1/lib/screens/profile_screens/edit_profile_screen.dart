import 'package:capstone_1/blocs/edit_profile_bloc/edit_profile_bloc.dart';
import 'package:capstone_1/blocs/edit_profile_bloc/edit_profile_event.dart';
import 'package:capstone_1/blocs/edit_profile_bloc/edit_profile_state.dart';
import 'package:capstone_1/blocs/profile_bloc/profile_bloc.dart';
import 'package:capstone_1/blocs/profile_bloc/profile_event.dart';
import 'package:capstone_1/globals/global_user.dart';
import 'package:capstone_1/widgets/text_field.dart';
import 'package:capstone_1/widgets/user_avtar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String city = currentUser!.city.toString();
  TextEditingController nameController =
      TextEditingController(text: currentUser!.name);
  TextEditingController phoneController =
      TextEditingController(text: currentUser!.phone);
  TextEditingController ageController =
      TextEditingController(text: currentUser!.age.toString());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Edit Profile'),
        leading: IconButton(
          onPressed: () {
            context.read<ProfileBloc>().add(GetInfoEvent());
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: BlocConsumer<EditProfileBloc, EditProfileState>(
          listener: (context, state) {
            if (state is ErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  duration: const Duration(seconds: 2),
                  backgroundColor: Colors.red,
                  content: Text(
                    state.message,
                    style: const TextStyle(color: Colors.white),
                  )));
            } else if (state is EmptyState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  duration: const Duration(seconds: 2),
                  backgroundColor: Colors.red,
                  content: Text(
                    state.message,
                    style: const TextStyle(color: Colors.white),
                  )));
            } else if (state is UpdateProfileState) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  duration: Duration(seconds: 2),
                  backgroundColor: Colors.green,
                  content: Text(
                    'Your changes updated succesfully',
                    style: TextStyle(color: Colors.white),
                  )));
              context.read<ProfileBloc>().add(GetInfoEvent());
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            if (state is LoadingState) {
              return const Center(child: CircularProgressIndicator());
            }

            return ListView(
              children: [
                const SizedBox(height: 30),
                InkWell(
                  onTap: () {},
                  child: Center(
                    child: Stack(
                      children: [
                        UserAvatar(
                          height: 0.19,
                          src: currentUser!.imageUrl!,
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              
                              color: Colors.amber[300],
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.edit_document,
                              color: Colors.grey[800],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                AddTextField(
                  label: 'Name',
                  hint: 'your name',
                  isPassword: false,
                  controller: nameController,
                  icon: Icons.person,
                  isAge: false,
                ),
                const SizedBox(height: 30),
                AddTextField(
                  label: 'Phone',
                  hint: 'your phone number',
                  isPassword: false,
                  controller: phoneController,
                  icon: Icons.phone,
                  isAge: true,
                ),
                const SizedBox(height: 30),
                AddTextField(
                  label: 'Age',
                  hint: 'your age',
                  isPassword: false,
                  controller: ageController,
                  icon: Icons.numbers,
                  isAge: true,
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
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
                          value: city,
                          onChanged: (String? newValue) {
                            setState(() {
                              city = newValue!;
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
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                InkWell(
                  onTap: () {
                    context.read<EditProfileBloc>().add(UpdateProfileEvent(
                        name: nameController.text.trim(),
                        phone: phoneController.text.trim(),
                        age: ageController.text.trim(),
                        city: city.trim()));
                  },
                  child: Container(
                    width: 330,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xff8ECAE6)),
                    child: const Center(
                      child: Text(
                        "Update",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            );
          },
        ),
      ),
    );
  }
}
