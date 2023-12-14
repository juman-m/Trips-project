import 'package:capstone_1/blocs/addtrip_bloc/addtrip_bloc.dart';
import 'package:capstone_1/blocs/auth_bloc/auth_bloc.dart';
import 'package:capstone_1/blocs/chat_bloc/chat_bloc.dart';
import 'package:capstone_1/blocs/edit_profile_bloc/edit_profile_bloc.dart';
import 'package:capstone_1/blocs/home_bloc/home_bloc.dart';
import 'package:capstone_1/blocs/profile_bloc/profile_bloc.dart';
import 'package:capstone_1/blocs/profile_trips_bloc/profile_trips_bloc.dart';
import 'package:capstone_1/blocs/search_bloc/search_bloc.dart';
import 'package:capstone_1/blocs/theme_bloc/theme_bloc.dart';
import 'package:capstone_1/blocs/theme_bloc/theme_state.dart';
import 'package:capstone_1/blocs/trip_bloc/trip_bloc.dart';
import 'package:capstone_1/blocs/trip_details_bloc/tripdetails_bloc.dart';
import 'package:capstone_1/screens/auth_screens/welcome_screen.dart';
import 'package:capstone_1/services/supabase_service.dart';
import 'package:capstone_1/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await supabaseConfig();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) => SearchBloc(),
        ),
        BlocProvider(
          create: (context) => ChatBloc(),
        ),
        BlocProvider(
          create: (context) => TripBloc(),
        ),
        BlocProvider(
          create: (context) => HomeBloc(),
        ),
        BlocProvider(
          create: (context) => AddTripBloc(),
        ),
        BlocProvider(
          create: (context) => ProfileBloc(),
        ),
        BlocProvider(
          create: (context) => TripDetailsBloc(),
        ),
        BlocProvider(
          create: (context) => ProfileTripsBloc(),
        ),
        BlocProvider(
          create: (context) => EditProfileBloc(),
        ),
        BlocProvider(
          create: (context) => ThemeBloc(),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          if (state is ChangeModeState) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: state.theme,
              home: const WelcomeScreen(),
            );
          } else {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: appThemme['light'],
              home: const WelcomeScreen(),
            );
          }
        },
      ),
    );
  }
}
