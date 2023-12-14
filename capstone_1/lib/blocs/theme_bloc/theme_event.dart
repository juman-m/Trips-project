abstract class ThemeEvent {}

class ChangeModeEvent extends ThemeEvent {
  bool mode;
  ChangeModeEvent({required this.mode});
}
