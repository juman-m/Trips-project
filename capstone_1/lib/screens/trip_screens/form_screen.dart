import 'dart:io';

import 'package:capstone_1/blocs/addtrip_bloc/addtrip_bloc.dart';
import 'package:capstone_1/blocs/profile_trips_bloc/profile_trips_bloc.dart';
import 'package:capstone_1/globals/global_user.dart';
import 'package:capstone_1/models/trip.dart';
import 'package:capstone_1/widgets/form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class TripFormScreen extends StatefulWidget {
  const TripFormScreen({Key? key}) : super(key: key);

  @override
  _TripFormScreenState createState() => _TripFormScreenState();
}

String selectedCategory = "sport";
String selectedCity = "Riyadh";

class _TripFormScreenState extends State<TripFormScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController costController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  final ImagePicker picker = ImagePicker();
  File? imageFile;

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: const Color(0xff8ECAE6),
            colorScheme: const ColorScheme.light(primary: Color(0xff8ECAE6)),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateController.text = picked.toLocal().toString().split(' ')[0];
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: const Color(0xff8ECAE6),
            colorScheme: const ColorScheme.light(
              primary: Color(0xff8ECAE6),
            ),
            buttonTheme: const ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
        String formattedTime =
            '${picked.hour}:${picked.minute.toString().padLeft(2, '0')}';
        timeController.text = formattedTime;
      });
    }
  }

  Future<void> getImage() async {
    XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        imageFile = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddTripBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Add Your Trip Now!',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xff023047)),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  GestureDetector(
                    onTap: getImage,
                    child: Center(
                      child: CircleAvatar(
                        backgroundColor: const Color(0xff8ECAE6),
                        radius: 50,
                        backgroundImage:
                            imageFile != null ? FileImage(imageFile!) : null,
                        child: imageFile == null
                            ? const Icon(Icons.camera_alt,
                                size: 50, color: Colors.white)
                            : null,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const SizedBox(height: 16),
                  buildStyledTextField(
                    controller: titleController,
                    labelText: 'Trip Title',
                  ),
                  const SizedBox(height: 16),
                  InkWell(
                    onTap: () {
                      _selectDate(context);
                    },
                    child: IgnorePointer(
                      child: buildStyledTextField(
                        controller: dateController,
                        labelText: 'Date',
                        suffixIcon: const Icon(
                          Icons.calendar_today,
                          color: Color(0xff219EBC),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  InkWell(
                    onTap: () {
                      _selectTime(context);
                    },
                    child: IgnorePointer(
                      child: buildStyledTextField(
                        controller: timeController,
                        labelText: 'Time',
                        suffixIcon: const Icon(
                          Icons.access_time,
                          color: Color(0xff219EBC),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
    
                  const SizedBox(height: 9),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
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
                            style: const TextStyle(fontSize: 16),
                          ),
                        );
                      }).toList(),
                      icon: const Icon(Icons.arrow_drop_down,
                          color: Color(0xff8ECAE6)),
                      iconSize: 30,
                      elevation: 16,
                      style: const TextStyle(color: Color(0xff023047)),
                      underline: Container(
                        color: const Color(0xff8ECAE6),
                      ),
                      dropdownColor: const Color(0xff8ECAE6),
                    ),
                  ),
                  const SizedBox(height: 9),
                  buildStyledTextField(
                    controller: costController,
                    labelText: 'Cost',
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  buildStyledTextField(
                    controller: descriptionController,
                    labelText: 'Description',
                    maxLines: 3,
                  ),
                  const SizedBox(height: 9),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: DropdownButton<String>(
                      value: selectedCategory,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedCategory = newValue!;
                        });
                      },
                      items: <String>['sport', 'art', 'education', 'hangout']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        );
                      }).toList(),
                      icon: const Icon(Icons.arrow_drop_down,
                          color: Color(0xff8ECAE6)),
                      iconSize: 30,
                      elevation: 16,
                      style: const TextStyle(color: Color(0xff023047)),
                      underline: Container(
                        color: const Color(0xff8ECAE6),
                      ),
                      dropdownColor: const Color(0xff8ECAE6),
                    ),
                  ),
                  const SizedBox(height: 30),
                  BlocConsumer<AddTripBloc, AddTripState>(
                    listener: (context, state) {
                      if (state is AddTripSuccessState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Trip added successfully! Enjoy',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            duration: Duration(seconds: 2),
                            backgroundColor: Color(0xff8ECAE6),
                          ),
                        );
                      } else if (state is AddTripErrorState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Oops! ${state.errorMessage}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            duration: const Duration(seconds: 2),
                            backgroundColor: const Color(0xff8ECAE6),
                          ),
                        );
                      }

                    },
                    builder: (context, state) {
                      return Container(
                        width: 330,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xff8ECAE6),
                        ),
                        child: TextButton(
                          onPressed: () {
                

                            context.read<AddTripBloc>().add(
                                  AddTripEvent(
                                    trip: Trip(
                                      title: titleController.text,
                                      time: selectedTime.format(context),
                                      date: dateController.text,
                                      category: selectedCategory,
                                      location: selectedCity,
                                      description: descriptionController.text,
                                      cost: int.parse(costController.text),
                                      tripCreator: currentUser!.user_uuid,
                                    ),
                                    image: imageFile,
                                  ),
                                );

                            Future.delayed(const Duration(seconds: 2));
                            context.read<ProfileTripsBloc>().add(
                                GetProfileTripsEvent(currentUser!.user_uuid!));

                            Navigator.pop(context, "back");
                          },
                          child: const Center(
                            child: Text(
                              'Publish Your Trip',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xff023047),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
