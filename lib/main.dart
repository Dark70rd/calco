import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:simple_calculator/calculator_page.dart';
import 'package:simple_calculator/app_theme.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';



const FlexSchemeData _myFlexScheme =  FlexSchemeData(
  name: 'Midnight blue',
  description: 'Midnight blue theme, custom definition of all colors',
  light: FlexSchemeColor(
    primary: Color.fromRGBO(83, 98, 113, 1),
    primaryContainer: Color(0xFFA0C2ED),
    secondary: Color.fromRGBO(167, 192, 171, 1),
    secondaryContainer: Color.fromRGBO(239, 231, 204, 1),
    tertiary: Color.fromRGBO(219, 84, 97, 1),
    tertiaryContainer: Color.fromRGBO(200, 175, 85, 1),
  ),
  dark: FlexSchemeColor(
    primary: Color.fromRGBO(41, 0, 37, 1),
    primaryContainer: Color.fromRGBO(46, 56, 46, 1),
    secondary: Color.fromRGBO(125, 107, 145, 1),
    secondaryContainer: Color.fromRGBO(82, 82, 82, 1),
    tertiary: Color.fromRGBO(225, 58, 32, 1),
    tertiaryContainer: Color.fromRGBO(86, 3, 173, 1),
  ),
);


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
      ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        child: CalculatorApp(),
      ),
    );
  });
}

class CalculatorApp extends StatefulWidget {
  CalculatorApp({super.key});

  @override
  _CalculatorAppState createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  // Opt in/out on Material-3
  bool useMaterial3 = true;

  @override
  Widget build(BuildContext context) {
    final themeProvider =
        Provider.of<ThemeProvider>(context); // listen: true is default
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        final MediaQueryData data = MediaQuery.of(context);
        return MediaQuery(
          data: data.copyWith(textScaler: const TextScaler.linear(1.0)),
          child: child!,
        );
      },
      title: 'Calculator',
      theme: FlexThemeData.light(
        colors: themeProvider.selectedScheme == FlexScheme.custom
            ? _myFlexScheme.light
            : FlexColor.schemes[themeProvider.selectedScheme]!.light,
        //scheme: themeProvider.selectedScheme,
        useMaterial3: useMaterial3,
        appBarElevation: 0.5,
        typography: Typography.material2018(),
      ),
      darkTheme: FlexThemeData.dark(
        colors: themeProvider.selectedScheme == FlexScheme.custom
            ? _myFlexScheme.dark
            : FlexColor.schemes[themeProvider.selectedScheme]!.dark,
        //scheme: themeProvider.selectedScheme,
        useMaterial3: useMaterial3,
        appBarElevation: 2,
        typography: Typography.material2018(),
        darkIsTrueBlack: true,
      ),
      themeMode: themeProvider.themeMode,
      home: CalculatorPage(),
    );
  }
}
