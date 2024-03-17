import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ThemeProvider extends ChangeNotifier {
  final List<FlexScheme> availableSchemes = [
    FlexScheme.gold,
    FlexScheme.mandyRed,
    FlexScheme.custom,
    FlexScheme.redWine,
    FlexScheme.bigStone,
    FlexScheme.vesuviusBurn,
    //FlexScheme.deepBlue
  ];

  ThemeMode _themeMode = ThemeMode.system;

   // Currently selected theme
  FlexScheme _selectedScheme = FlexScheme.gold;

  ThemeMode get themeMode => _themeMode;

  ThemeProvider() {
    loadTheme();
    loadThemeMode();
  }

  FlexScheme get selectedScheme => _selectedScheme;

  set selectedScheme(FlexScheme value) {
    _selectedScheme = value;
    _saveSelectedScheme(value.name); // Save the name of the selected theme
    notifyListeners();
  }

   set themeMode(ThemeMode themeMode) {
    _themeMode = themeMode;
    _saveThemeMode(themeMode); // Save the selected theme mode
    notifyListeners();
  }

  Future<void> loadTheme() async {
    await _loadSelectedScheme();
  }

  Future<void> _loadSelectedScheme() async {
    final prefs = await SharedPreferences.getInstance();
    final schemeName = prefs.getString('selectedSchemeName');
    if (schemeName != null) {
      _selectedScheme = FlexScheme.values.firstWhere(
          (scheme) => scheme.name == schemeName,
          orElse: () => FlexScheme.material);
    }
    notifyListeners();
  }

  Future<void> _saveSelectedScheme(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedSchemeName', name);
  }

  Future<void> _saveThemeMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('themeMode', mode.toString());
  }

  Future<void> loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final themeModeString = prefs.getString('themeMode');
    if (themeModeString != null) {
      switch (themeModeString) {
        case 'ThemeMode.dark':
          _themeMode = ThemeMode.dark;
          break;
        case 'ThemeMode.light':
          _themeMode = ThemeMode.light;
          break;
        default:
          _themeMode = ThemeMode.system;
          break;
      }
      notifyListeners();
    }
  }
}
