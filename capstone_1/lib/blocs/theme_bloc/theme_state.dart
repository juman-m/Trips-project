import 'package:flutter/material.dart';

abstract class ThemeState {}

final class ThemeInitial extends ThemeState {}

class ChangeModeState extends ThemeState {
  final ThemeData theme;
  bool value;
  ChangeModeState({required this.theme, required this.value});
}
