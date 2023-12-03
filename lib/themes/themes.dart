import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'static_themes.dart';
part 'themes_events.dart';
part 'themes_state.dart';

class ThemesMenager extends Bloc<ThemesEvent, ThemesMenagerState> {
  ThemesMenager() : super(const ThemesMenagerState.initial()) {
    on<InitThemes>((event, emit) {
      add(const AddTheme("blue", {
        "light": ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xFF00687A),
          onPrimary: Color(0xFFFFFFFF),
          primaryContainer: Color(0xFFABEDFF),
          onPrimaryContainer: Color(0xFF001F26),
          secondary: Color(0xFF4B6269),
          onSecondary: Color(0xFFFFFFFF),
          secondaryContainer: Color(0xFFCEE7EF),
          onSecondaryContainer: Color(0xFF061F24),
          tertiary: Color(0xFF565D7E),
          onTertiary: Color(0xFFFFFFFF),
          tertiaryContainer: Color(0xFFDDE1FF),
          onTertiaryContainer: Color(0xFF131937),
          error: Color(0xFFBA1A1A),
          errorContainer: Color(0xFFFFDAD6),
          onError: Color(0xFFFFFFFF),
          onErrorContainer: Color(0xFF410002),
          background: Color(0xFFFEFBFF),
          onBackground: Color(0xFF001849),
          surface: Color(0xFFFEFBFF),
          onSurface: Color(0xFF001849),
          surfaceVariant: Color(0xFFDBE4E7),
          onSurfaceVariant: Color(0xFF3F484B),
          outline: Color(0xFF70797B),
          onInverseSurface: Color(0xFFEEF0FF),
          inverseSurface: Color(0xFF002B75),
          inversePrimary: Color(0xFF55D6F4),
          shadow: Color(0xFF000000),
          surfaceTint: Color(0xFF00687A),
          outlineVariant: Color(0xFFBFC8CB),
          scrim: Color(0xFF000000),
        ),
        "dark": ColorScheme(
          brightness: Brightness.dark,
          primary: Color(0xFF55D6F4),
          onPrimary: Color(0xFF003640),
          primaryContainer: Color(0xFF004E5C),
          onPrimaryContainer: Color(0xFFABEDFF),
          secondary: Color(0xFFB2CBD2),
          onSecondary: Color(0xFF1D343A),
          secondaryContainer: Color(0xFF334A51),
          onSecondaryContainer: Color(0xFFCEE7EF),
          tertiary: Color(0xFFBFC4EB),
          onTertiary: Color(0xFF282F4D),
          tertiaryContainer: Color(0xFF3F4565),
          onTertiaryContainer: Color(0xFFDDE1FF),
          error: Color(0xFFFFB4AB),
          errorContainer: Color(0xFF93000A),
          onError: Color(0xFF690005),
          onErrorContainer: Color(0xFFFFDAD6),
          background: Color(0xFF001849),
          onBackground: Color(0xFFDBE1FF),
          surface: Color(0xFF001849),
          onSurface: Color(0xFFDBE1FF),
          surfaceVariant: Color(0xFF3F484B),
          onSurfaceVariant: Color(0xFFBFC8CB),
          outline: Color(0xFF899295),
          onInverseSurface: Color(0xFF001849),
          inverseSurface: Color(0xFFDBE1FF),
          inversePrimary: Color(0xFF00687A),
          shadow: Color(0xFF000000),
          surfaceTint: Color(0xFF55D6F4),
          outlineVariant: Color(0xFF3F484B),
          scrim: Color(0xFF000000),
        ),
      }));
      add(const AddTheme("green", {
        "light": ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xFF3A6A00),
          onPrimary: Color(0xFFFFFFFF),
          primaryContainer: Color(0xFFB4F575),
          onPrimaryContainer: Color(0xFF0E2000),
          secondary: Color(0xFF57624A),
          onSecondary: Color(0xFFFFFFFF),
          secondaryContainer: Color(0xFFDBE7C9),
          onSecondaryContainer: Color(0xFF151E0C),
          tertiary: Color(0xFF386664),
          onTertiary: Color(0xFFFFFFFF),
          tertiaryContainer: Color(0xFFBBECE9),
          onTertiaryContainer: Color(0xFF00201F),
          error: Color(0xFFBA1A1A),
          errorContainer: Color(0xFFFFDAD6),
          onError: Color(0xFFFFFFFF),
          onErrorContainer: Color(0xFF410002),
          background: Color(0xFFF7FFEE),
          onBackground: Color(0xFF002200),
          surface: Color(0xFFF7FFEE),
          onSurface: Color(0xFF002200),
          surfaceVariant: Color(0xFFE0E4D5),
          onSurfaceVariant: Color(0xFF44483E),
          outline: Color(0xFF74796C),
          onInverseSurface: Color(0xFFCAFFB9),
          inverseSurface: Color(0xFF003A01),
          inversePrimary: Color(0xFF99D85C),
          shadow: Color(0xFF000000),
          surfaceTint: Color(0xFF3A6A00),
          outlineVariant: Color(0xFFC4C8BA),
          scrim: Color(0xFF000000),
        ),
        "dark": ColorScheme(
          brightness: Brightness.dark,
          primary: Color(0xFF99D85C),
          onPrimary: Color(0xFF1B3700),
          primaryContainer: Color(0xFF2A5000),
          onPrimaryContainer: Color(0xFFB4F575),
          secondary: Color(0xFFBFCBAE),
          onSecondary: Color(0xFF29341F),
          secondaryContainer: Color(0xFF3F4A34),
          onSecondaryContainer: Color(0xFFDBE7C9),
          tertiary: Color(0xFFA0CFCD),
          onTertiary: Color(0xFF003736),
          tertiaryContainer: Color(0xFF1E4E4C),
          onTertiaryContainer: Color(0xFFBBECE9),
          error: Color(0xFFFFB4AB),
          errorContainer: Color(0xFF93000A),
          onError: Color(0xFF690005),
          onErrorContainer: Color(0xFFFFDAD6),
          background: Color(0xFF002200),
          onBackground: Color(0xFFB0F49E),
          surface: Color(0xFF002200),
          onSurface: Color(0xFFB0F49E),
          surfaceVariant: Color(0xFF44483E),
          onSurfaceVariant: Color(0xFFC4C8BA),
          outline: Color(0xFF8E9285),
          onInverseSurface: Color(0xFF002200),
          inverseSurface: Color(0xFFB0F49E),
          inversePrimary: Color(0xFF3A6A00),
          shadow: Color(0xFF000000),
          surfaceTint: Color(0xFF99D85C),
          outlineVariant: Color(0xFF44483E),
          scrim: Color(0xFF000000),
        ),
      }));
      add(const AddTheme("yellow", {
        "light": ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xFF865300),
          onPrimary: Color(0xFFFFFFFF),
          primaryContainer: Color(0xFFFFDDB8),
          onPrimaryContainer: Color(0xFF2B1700),
          secondary: Color(0xFF715A41),
          onSecondary: Color(0xFFFFFFFF),
          secondaryContainer: Color(0xFFFCDDBD),
          onSecondaryContainer: Color(0xFF281805),
          tertiary: Color(0xFF54643D),
          onTertiary: Color(0xFFFFFFFF),
          tertiaryContainer: Color(0xFFD7E9B8),
          onTertiaryContainer: Color(0xFF131F02),
          error: Color(0xFFBA1A1A),
          errorContainer: Color(0xFFFFDAD6),
          onError: Color(0xFFFFFFFF),
          onErrorContainer: Color(0xFF410002),
          background: Color(0xFFFFFBFF),
          onBackground: Color(0xFF2A1800),
          surface: Color(0xFFFFFBFF),
          onSurface: Color(0xFF2A1800),
          surfaceVariant: Color(0xFFF1E0D0),
          onSurfaceVariant: Color(0xFF504539),
          outline: Color(0xFF827568),
          onInverseSurface: Color(0xFFFFEEDE),
          inverseSurface: Color(0xFF462A00),
          inversePrimary: Color(0xFFFFB960),
          shadow: Color(0xFF000000),
          surfaceTint: Color(0xFF865300),
          outlineVariant: Color(0xFFD4C4B5),
          scrim: Color(0xFF000000),
        ),
        "dark": ColorScheme(
          brightness: Brightness.dark,
          primary: Color(0xFFFFB960),
          onPrimary: Color(0xFF472A00),
          primaryContainer: Color(0xFF653E00),
          onPrimaryContainer: Color(0xFFFFDDB8),
          secondary: Color(0xFFDFC2A2),
          onSecondary: Color(0xFF3F2D17),
          secondaryContainer: Color(0xFF57432B),
          onSecondaryContainer: Color(0xFFFCDDBD),
          tertiary: Color(0xFFBBCD9E),
          onTertiary: Color(0xFF273513),
          tertiaryContainer: Color(0xFF3D4B27),
          onTertiaryContainer: Color(0xFFD7E9B8),
          error: Color(0xFFFFB4AB),
          errorContainer: Color(0xFF93000A),
          onError: Color(0xFF690005),
          onErrorContainer: Color(0xFFFFDAD6),
          background: Color(0xFF2A1800),
          onBackground: Color(0xFFFFDDB6),
          surface: Color(0xFF2A1800),
          onSurface: Color(0xFFFFDDB6),
          surfaceVariant: Color(0xFF504539),
          onSurfaceVariant: Color(0xFFD4C4B5),
          outline: Color(0xFF9C8E81),
          onInverseSurface: Color(0xFF2A1800),
          inverseSurface: Color(0xFFFFDDB6),
          inversePrimary: Color(0xFF865300),
          shadow: Color(0xFF000000),
          surfaceTint: Color(0xFFFFB960),
          outlineVariant: Color(0xFF504539),
          scrim: Color(0xFF000000),
        ),
      }));
      add(const AddTheme("purple", {
        "light": ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xFF6151A6),
          onPrimary: Color(0xFFFFFFFF),
          primaryContainer: Color(0xFFE6DEFF),
          onPrimaryContainer: Color(0xFF1D0160),
          secondary: Color(0xFF605B71),
          onSecondary: Color(0xFFFFFFFF),
          secondaryContainer: Color(0xFFE6DFF9),
          onSecondaryContainer: Color(0xFF1C192B),
          tertiary: Color(0xFF7C5263),
          onTertiary: Color(0xFFFFFFFF),
          tertiaryContainer: Color(0xFFFFD9E5),
          onTertiaryContainer: Color(0xFF30111F),
          error: Color(0xFFBA1A1A),
          errorContainer: Color(0xFFFFDAD6),
          onError: Color(0xFFFFFFFF),
          onErrorContainer: Color(0xFF410002),
          background: Color(0xFFFFFBFF),
          onBackground: Color(0xFF1B0261),
          surface: Color(0xFFFFFBFF),
          onSurface: Color(0xFF1B0261),
          surfaceVariant: Color(0xFFE6E0EC),
          onSurfaceVariant: Color(0xFF48454E),
          outline: Color(0xFF79757F),
          onInverseSurface: Color(0xFFF4EEFF),
          inverseSurface: Color(0xFF302175),
          inversePrimary: Color(0xFFCBBEFF),
          shadow: Color(0xFF000000),
          surfaceTint: Color(0xFF6151A6),
          outlineVariant: Color(0xFFC9C4D0),
          scrim: Color(0xFF000000),
        ),
        "dark": ColorScheme(
          brightness: Brightness.dark,
          primary: Color(0xFFCBBEFF),
          onPrimary: Color(0xFF332074),
          primaryContainer: Color(0xFF49398C),
          onPrimaryContainer: Color(0xFFE6DEFF),
          secondary: Color(0xFFCAC3DC),
          onSecondary: Color(0xFF322E41),
          secondaryContainer: Color(0xFF484458),
          onSecondaryContainer: Color(0xFFE6DFF9),
          tertiary: Color(0xFFEDB8CB),
          onTertiary: Color(0xFF492534),
          tertiaryContainer: Color(0xFF623B4B),
          onTertiaryContainer: Color(0xFFFFD9E5),
          error: Color(0xFFFFB4AB),
          errorContainer: Color(0xFF93000A),
          onError: Color(0xFF690005),
          onErrorContainer: Color(0xFFFFDAD6),
          background: Color(0xFF1B0261),
          onBackground: Color(0xFFE5DEFF),
          surface: Color(0xFF1B0261),
          onSurface: Color(0xFFE5DEFF),
          surfaceVariant: Color(0xFF48454E),
          onSurfaceVariant: Color(0xFFC9C4D0),
          outline: Color(0xFF938F99),
          onInverseSurface: Color(0xFF1B0261),
          inverseSurface: Color(0xFFE5DEFF),
          inversePrimary: Color(0xFF6151A6),
          shadow: Color(0xFF000000),
          surfaceTint: Color(0xFFCBBEFF),
          outlineVariant: Color(0xFF48454E),
          scrim: Color(0xFF000000),
        ),
      }));
    });
    on<ChangeTheme>((event, emit) {
      emit(state.copyWith(
          currentTheme: event.themeName, status: ThemesStates.newSheme));
    });
    on<ChangeThemeMode>((event, emit) {
      emit(state.copyWith(
          currentThemeMode: event.themeMode,
          status: ThemesStates.newThemeMode));
    });
    on<AddTheme>((event, emit) {
      emit(state.copyWith(status: ThemesStates.loading));
      emit(
          state.copyWith(themes: state.addTheme(event.themeName, event.theme)));
      emit(state.copyWith(status: ThemesStates.themeAdded));
    });
  }

  ///Gets Theme Settings Row for App Settings
  Widget getSettingsRow(BuildContext context) {
    bool isAutoBrightness = state.currentThemeMode == ThemeMode.system;
    final dropdownState = GlobalKey<FormFieldState>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: DropdownButtonFormField(
              key: dropdownState,
              decoration: const InputDecoration(
                labelText: "Theme Color:",
                border: OutlineInputBorder(),
              ),
              items: [
                DropdownMenuItem(
                  //here add more themes options
                  value: "pink",
                  child: Text('Pink',
                      style: TextStyle(
                          color: state.themes["pink"]!["light"]!.primary)),
                ),
                DropdownMenuItem(
                  value: "blue",
                  child: Text('Blue',
                      style: TextStyle(
                          color: state.themes["blue"]!["light"]!.primary)),
                ),
                DropdownMenuItem(
                  value: "green",
                  child: Text('Green',
                      style: TextStyle(
                          color: state.themes["green"]!["light"]!.primary)),
                ),
                DropdownMenuItem(
                  value: "yellow",
                  child: Text('Yellow',
                      style: TextStyle(
                          color: state.themes["yellow"]!["light"]!.primary)),
                ),
                DropdownMenuItem(
                  value: "purple",
                  child: Text('Purple',
                      style: TextStyle(
                          color: state.themes["purple"]!["light"]!.primary)),
                ),
                const DropdownMenuItem(
                  value: "dynamic",
                  child: Text('Dynamic'),
                ),
              ],
              value: state.currentThemeString,
              elevation: 1,
              onChanged: (value) {
                if (value == 'dynamic') {
                  if (state.themes.containsKey("dynamic")) {
                    add(const ChangeTheme("dynamic"));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Dynamic theme is not available"),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                } else {
                  add(ChangeTheme(value as String));
                }
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: ElevatedButton.icon(
                onPressed: () {
                  switch (state.currentThemeMode) {
                    case ThemeMode.dark:
                      add(const ChangeThemeMode(ThemeMode.light));
                      break;
                    case ThemeMode.light:
                      add(const ChangeThemeMode(ThemeMode.system));
                      break;
                    case ThemeMode.system:
                      add(const ChangeThemeMode(ThemeMode.dark));
                      break;
                    default:
                  }
                  // themeProvider
                  //     .setThemeMode(themeProvider.themeMode == ThemeMode.dark
                  //         ? themeProvider.themeMode == ThemeMode.light
                  //             ? ThemeMode.system
                  //             : ThemeMode.light
                  //         : ThemeMode.dark);
                },
                icon: Icon(
                  state.currentThemeMode == ThemeMode.light
                      ? Icons.brightness_3
                      : state.currentThemeMode == ThemeMode.system
                          ? Icons.brightness_auto
                          : Icons.sunny,
                ),
                label: state.currentThemeMode == ThemeMode.light
                    ? const Text("Dark Mode")
                    : state.currentThemeMode == ThemeMode.system
                        ? const Text("Auto Mode")
                        : const Text("Light Mode"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class ThemesMenager with ChangeNotifier {
//   String _theme = "pink";
//   ThemeMode _themeMode = ThemeMode.system;

//   // static final ThemesMenager _instance = ThemesMenager.internal();
//   // ThemesMenager.internal();

//   // factory ThemesMenager() {
//   //   return _instance;
//   // }

//   ThemesMenager() {
//     loadFromMemory();
//   }

//   void loadFromMemory() async {
//     var prefs = await SharedPreferences.getInstance();
//     var theme = prefs.getString("theme");
//     var themeMode = prefs.getString("themeMode");
//     if (theme != null) {
//       setTheme(theme);
//     }
//     if (themeMode != null) {
//       setThemeMode(themeMode == "system"
//           ? ThemeMode.system
//           : themeMode == "light"
//               ? ThemeMode.light
//               : ThemeMode.dark);
//     }
//   }

//   void addDynamic(ColorScheme? light, ColorScheme? dark) {
//     if (light != null && dark != null) {
//       if (!colorShemes.containsKey("dynamic_light") ||
//           !colorShemes.containsKey("dynamic_dark")) {
//         // print("adding dynamic themes");
//         colorShemes.addAll({
//           'dynamic_light': light,
//           'dynamic_dark': dark,
//         });
//         setTheme("dynamic", notify: false);
//         setThemeMode(ThemeMode.system);
//       }
//     } else {
//       // print("dynamic themes are null");
//     }
//   }

//   void setTheme(String theme, {bool notify = true}) async {
//     // print("trying to set the theme to $theme");
//     if (ThemesMenager.colorShemes.containsKey("${theme}_light")) {
//       _theme = theme;

//       // print("setting theme to $theme");
//       if (notify) {
//         notifyListeners();
//       }
//       var prefs = await SharedPreferences.getInstance();
//       prefs.setString("theme", theme);
//     }
//   }

//   void setThemeMode(ThemeMode themeMode) async {
//     // print("setting theme mode to $themeMode");
//     _themeMode = themeMode;
//     Future.delayed(const Duration(milliseconds: 100), () {
//       notifyListeners();
//     });
//     var prefs = await SharedPreferences.getInstance();
//     prefs.setString(
//         "themeMode",
//         themeMode == ThemeMode.system
//             ? "system"
//             : themeMode == ThemeMode.light
//                 ? "light"
//                 : "dark");
//   }

//   ThemeMode get themeMode => _themeMode;
//   String get theme => _theme;

//   ColorScheme? getColorScheme({bool systemAutoBrightness = false}) {
//     if (systemAutoBrightness == false || _themeMode != ThemeMode.system) {
//       if (_themeMode == ThemeMode.light) {
//         if (colorShemes.containsKey("${_theme}_light")) {
//           return colorShemes["${_theme}_light"];
//         } else {
//           return colorShemes["pink_light"];
//         }
//       } else if (_themeMode == ThemeMode.dark) {
//         if (colorShemes.containsKey("${_theme}_dark")) {
//           return colorShemes["${_theme}_dark"];
//         } else {
//           return colorShemes["pink_dark"];
//         }
//       } else {
//         return colorShemes["pink_light"];
//       }
//     } else {
//       print(
//           "themeMode: ${SchedulerBinding.instance.platformDispatcher.platformBrightness}");
//       if (SchedulerBinding.instance.platformDispatcher.platformBrightness ==
//           // if (SchedulerBinding.instance.platformDispatcher.platformBrightness ==
//           Brightness.dark) {
//         if (colorShemes.containsKey("${_theme}_dark")) {
//           return colorShemes["${_theme}_dark"];
//         } else {
//           return colorShemes["pink_dark"];
//         }
//       } else if (SchedulerBinding
//               .instance.platformDispatcher.platformBrightness ==
//           Brightness.light) {
//         if (colorShemes.containsKey("${_theme}_light")) {
//           return colorShemes["${_theme}_light"];
//         } else {
//           return colorShemes["pink_light"];
//         }
//       } else {
//         return colorShemes["pink_light"];
//       }
//     }
//   }

//   
// }
