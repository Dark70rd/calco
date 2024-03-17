import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:simple_calculator/app_theme.dart';

class ThemesPage extends StatefulWidget {
  const ThemesPage({super.key});

  @override
  _ThemesPageState createState() => _ThemesPageState();
}

class _ThemesPageState extends State<ThemesPage> {
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    // Load the selected theme when the widget is initialized
    _initSharedPreferences();
  }

  Future<void> _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> _saveSelectedScheme(FlexScheme scheme) async {
    await _prefs.setString('selectedSchemeIndex', scheme.name);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final themenamesetter = "purplePunch";
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customize theme'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_sharp),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: SwitchListTile(
              title: const Text('Dark'),
              value: themeProvider.themeMode == ThemeMode.dark,
              onChanged: (bool value) {
                themeProvider.themeMode =
                    value ? ThemeMode.dark : ThemeMode.light;
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              //itemCount: themeProvider
              //    .availableSchemes.length,// _schemesToShow.length
              itemCount: FlexScheme.values.length,
              itemBuilder: (context, index) {
                final scheme = FlexScheme.values[index];
                //final scheme = themeProvider.availableSchemes[index];
                return ListTile(
                  title: scheme == FlexScheme.custom
                      ? Text(themenamesetter.capitalize)
                      : Text(scheme.name.capitalize),
                  onTap: () {
                    themeProvider.selectedScheme = scheme;
                    _saveSelectedScheme(scheme);
                  },
                  trailing: Radio(
                    value: scheme,
                    groupValue: themeProvider.selectedScheme,
                    onChanged: (value) {
                      if (value is FlexScheme) {
                        themeProvider.selectedScheme = value;
                        _saveSelectedScheme(value);
                      }
                    },
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
