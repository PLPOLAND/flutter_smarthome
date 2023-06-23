part of 'themes.dart';

enum ThemesStates {
  initial,
  loading,
  newSheme,
  newThemeMode,
  themeAdded,
  error,
}

extension ThemesStatesExtension on ThemesStates {
  bool get isInitial => this == ThemesStates.initial;
  bool get isLoading => this == ThemesStates.loading;
  bool get isNewSheme => this == ThemesStates.newSheme;
  bool get isNewThemeMode => this == ThemesStates.newThemeMode;
  bool get isError => this == ThemesStates.error;
}

class ThemesMenagerState extends Equatable {
  final ThemesStates status;
  final String _currentTheme;
  final ThemeMode currentThemeMode;
  final Map<String, Map<String, ColorScheme>> themes;
  const ThemesMenagerState._({
    this.status = ThemesStates.initial,
    currentTheme = 'pink',
    this.currentThemeMode = ThemeMode.system,
    this.themes = const <String, Map<String, ColorScheme>>{
      "pink": <String, ColorScheme>{
        'light': ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xFFB90063),
          onPrimary: Color(0xFFFFFFFF),
          primaryContainer: Color(0xFFFFD9E2),
          onPrimaryContainer: Color(0xFF3E001D),
          secondary: Color(0xFF396A00),
          onSecondary: Color(0xFFFFFFFF),
          secondaryContainer: Color(0xFF9EFA46),
          onSecondaryContainer: Color(0xFF0D2000),
          tertiary: Color(0xFF006E2B),
          onTertiary: Color(0xFFFFFFFF),
          tertiaryContainer: Color(0xFF69FF89),
          onTertiaryContainer: Color(0xFF002108),
          error: Color(0xFFBA1A1A),
          errorContainer: Color(0xFFFFDAD6),
          onError: Color(0xFFFFFFFF),
          onErrorContainer: Color(0xFF410002),
          background: Color(0xFFFFFBFF),
          onBackground: Color(0xFF380036),
          surface: Color(0xFFFFFBFF),
          onSurface: Color(0xFF380036),
          surfaceVariant: Color(0xFFF2DDE1),
          onSurfaceVariant: Color(0xFF514347),
          outline: Color(0xFF837377),
          onInverseSurface: Color(0xFFFFEBF7),
          inverseSurface: Color(0xFF551251),
          inversePrimary: Color(0xFFFFB1C8),
          shadow: Color(0xFF000000),
          surfaceTint: Color(0xFFB90063),
          outlineVariant: Color(0xFFD5C2C6),
          scrim: Color(0xFF000000),
        ),
        'dark': ColorScheme(
          brightness: Brightness.dark,
          primary: Color(0xFFFFB1C8),
          onPrimary: Color(0xFF650033),
          primaryContainer: Color(0xFF8E004A),
          onPrimaryContainer: Color(0xFFFFD9E2),
          secondary: Color(0xFF84DD28),
          onSecondary: Color(0xFF1B3700),
          secondaryContainer: Color(0xFF2A5000),
          onSecondaryContainer: Color(0xFF9EFA46),
          tertiary: Color(0xFF48E270),
          onTertiary: Color(0xFF003913),
          tertiaryContainer: Color(0xFF00531F),
          onTertiaryContainer: Color(0xFF69FF89),
          error: Color(0xFFFFB4AB),
          errorContainer: Color(0xFF93000A),
          onError: Color(0xFF690005),
          onErrorContainer: Color(0xFFFFDAD6),
          background: Color(0xFF380036),
          onBackground: Color(0xFFFFD7F4),
          surface: Color(0xFF380036),
          onSurface: Color(0xFFFFD7F4),
          surfaceVariant: Color(0xFF514347),
          onSurfaceVariant: Color(0xFFD5C2C6),
          outline: Color(0xFF9E8C90),
          onInverseSurface: Color(0xFF380036),
          inverseSurface: Color(0xFFFFD7F4),
          inversePrimary: Color(0xFFB90063),
          shadow: Color(0xFF000000),
          surfaceTint: Color(0xFFFFB1C8),
          outlineVariant: Color(0xFF514347),
          scrim: Color(0xFF000000),
        ),
      },
    },
  }) : _currentTheme = currentTheme;
  String get currentThemeModeString =>
      currentThemeMode.toString().replaceAll("ThemeMode.", "");
  String get currentThemeString => _currentTheme;
  ColorScheme get currentTheme {
    if (currentThemeModeString == "system") {
      if (WidgetsBinding.instance!.window.platformBrightness ==
          Brightness.light) {
        return themes[_currentTheme]!['light']!;
      } else {
        return themes[_currentTheme]!['dark']!;
      }
    } else {
      return themes[_currentTheme]![currentThemeModeString]!;
    }
  }

  const ThemesMenagerState.initial() : this._();

  /// Add new theme to themes map
  /// [themeName] - name of theme
  /// [theme] - map of colors formed like this: {'light': ColorScheme, 'dark': ColorScheme}
  Map<String, Map<String, ColorScheme>> addTheme(
      String themeName, Map<String, ColorScheme> theme) {
    Map<String, Map<String, ColorScheme>> themes = {
      ...this.themes,
    };
    themes.addAll({themeName: theme});
    return themes;
  }

  @override
  List<Object> get props => [status, currentTheme, currentThemeMode, themes];

  @override
  String toString() =>
      'ThemesState { status: $status, currentTheme: $currentTheme, currentThemeMode: $currentThemeMode, themes: $themes}';

  ThemesMenagerState copyWith({
    ThemesStates? status,
    String? currentTheme,
    ThemeMode? currentThemeMode,
    Map<String, Map<String, ColorScheme>>? themes,
  }) {
    return ThemesMenagerState._(
      status: status ?? this.status,
      currentTheme: currentTheme ?? _currentTheme,
      currentThemeMode: currentThemeMode ?? this.currentThemeMode,
      themes: themes ?? this.themes,
    );
  }
}
