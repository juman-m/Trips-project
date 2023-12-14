import 'package:capstone_1/blocs/theme_bloc/theme_event.dart';
import 'package:capstone_1/blocs/theme_bloc/theme_state.dart';
import 'package:capstone_1/themes/app_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  bool dark = false;
  ThemeBloc() : super(ThemeInitial()) {
    on<ChangeModeEvent>((event, emit) {
      dark = !dark;
      emit(ChangeModeState(
          theme: appThemme[dark == true ? 'dark' : 'light'], value: dark));
    });
  }
}
