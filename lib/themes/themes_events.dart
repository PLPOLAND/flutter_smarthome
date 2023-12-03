part of 'themes.dart';

class ThemesEvent extends Equatable {
  const ThemesEvent();

  @override
  List<Object> get props => [];
}

class InitThemes extends ThemesEvent {}

class ChangeTheme extends ThemesEvent {
  final String themeName;

  const ChangeTheme(this.themeName);

  @override
  List<Object> get props => [themeName];

  @override
  String toString() => 'ChangeTheme { themeName: $themeName }';
}

class ChangeThemeMode extends ThemesEvent {
  final ThemeMode themeMode;

  const ChangeThemeMode(this.themeMode);

  @override
  List<Object> get props => [themeMode];

  @override
  String toString() => 'ChangeThemeMode { themeMode: $themeMode }';
}

class AddTheme extends ThemesEvent {
  final String themeName;
  final Map<String, ColorScheme> theme;

  const AddTheme(this.themeName, this.theme);

  @override
  List<Object> get props => [themeName, theme];

  @override
  String toString() => 'AddTheme { themeName: $themeName, theme: $theme }';
}
