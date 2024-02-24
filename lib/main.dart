import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_calculator/calculator_page.dart';
import 'package:simple_calculator/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
        runApp(const CalculatorApp());
      });
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        final MediaQueryData data = MediaQuery.of(context);
        return MediaQuery(
          data: data.copyWith(textScaler: const TextScaler.linear(1.0)),
          child: child!,
        );
      },
      title: 'Calculator',
      theme: appThemeData,
      home: const CalculatorPage(),
    );
  }
}





