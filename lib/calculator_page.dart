import 'package:flutter/material.dart';
import 'package:simple_calculator/calculator_button.dart';
import 'package:simple_calculator/calculator_icon_button.dart';
import 'package:simple_calculator/state_save.dart';
import 'package:simple_calculator/database_helper.dart';
import 'package:simple_calculator/history_drawer.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String equation = '';
  String result = '';
  bool lastOperationWasCalculation = false;

  @override
  void initState() {
    super.initState();
    loadData('equation').then((savedEquation) {
      setState(() {
        equation = savedEquation;
      });
    });
    loadData('result').then((savedResult) {
      setState(() {
        result = savedResult;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text('Calculator'),
          scrolledUnderElevation: 0.0,
          actions: <Widget>[
            Container(),
          ],
        ),
        body: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 7.5,
              color: Colors.grey[850],
              padding: const EdgeInsets.all(10),
              alignment: Alignment.centerRight,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                reverse: true,
                child: Text(
                  equation,
                  style: const TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 7.5,
              color: Colors.grey[900],
              padding: const EdgeInsets.all(10),
              alignment: Alignment.centerRight,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                reverse: true,
                child: Text(
                  result,
                  style: const TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
            ),
            Expanded(
                child: GridView.count(
              padding: const EdgeInsets.only(top: 2, bottom: 2),
              crossAxisCount: 4,
              //physics: const NeverScrollableScrollPhysics(),
              children: [
                CalculatorButton(
                  'C',
                  Colors.red,
                  () => clearEquation(),
                ),
                CalculatorButton(
                    '/', Colors.blue, (text) => appendOperator(text)),
                CalculatorButton(
                    'x', Colors.blue, (text) => appendOperator(text)),
                CalculatorButton(
                    '-', Colors.blue, (text) => appendOperator(text)),
                CalculatorButton(
                    '7', Colors.black, (text) => appendNumber(text)),
                CalculatorButton(
                    '8', Colors.black, (text) => appendNumber(text)),
                CalculatorButton(
                    '9', Colors.black, (text) => appendNumber(text)),
                CalculatorButton(
                    '+', Colors.blue, (text) => appendOperator(text)),
                CalculatorButton(
                    '4', Colors.black, (text) => appendNumber(text)),
                CalculatorButton(
                    '5', Colors.black, (text) => appendNumber(text)),
                CalculatorButton(
                    '6', Colors.black, (text) => appendNumber(text)),
                CalculatorButton(
                    '=', Colors.teal, (text) => evaluateEquation(text)),
                CalculatorButton(
                    '1', Colors.black, (text) => appendNumber(text)),
                CalculatorButton(
                    '2', Colors.black, (text) => appendNumber(text)),
                CalculatorButton(
                    '3', Colors.black, (text) => appendNumber(text)),
                CalculatorButton('.', Colors.black, () => appendDecimal()),
                CalculatorButton(
                    '0', Colors.black, (text) => appendNumber(text)),
                CalculatorButton('00', Colors.black, () => appendDoubleZero()),
                CalculatorIconButton(Icons.backspace_outlined, Colors.blue,
                    () => deleteLastCharacter()),
                CalculatorIconButton(
                  Icons.history_sharp,
                  Colors.blue,
                  () => _scaffoldKey.currentState?.openEndDrawer(),
                )
              ],
            ))
          ],
        ),
        endDrawer: HistoryDrawer(
          drawerwidth: MediaQuery.of(context).size.width / 1.5,
        ),
      ),
    );
  }

  void clearEquation() {
    setState(() {
      equation = '';
      result = '';
      lastOperationWasCalculation = false;
    });
    saveData('result', result);
    saveData('equation', equation);
  }

  void deleteLastCharacter() {
    setState(() {
      if (equation.isNotEmpty) {
        equation = equation.substring(0, equation.length - 1);
      }
    });
  }

  void appendNumber(String number) {
    setState(() {
      if (result != '' && lastOperationWasCalculation) {
        equation = '';
        result = '';
        lastOperationWasCalculation = false;
      }

      if (number == '0' && equation == '0') {
        return;
      }

      // Split the equation on the operator and get the last part
      String lastPart = equation.split(RegExp(r'[\+\-\x\/]')).last;

      if (equation == '0' && number != '0') {
        equation = number;
      } else {
        equation += number;
      }
    });
  }

  void appendDecimal() {
    if (equation.isEmpty) {
      return;
    }
    String lastNumber = equation.split(RegExp(r'[\+\-\x\/]')).last;
    if (!lastNumber.contains('.')) {
      setState(() {
        equation += '.';
      });
    }
  }

  void appendDoubleZero() {
    if (equation.length >= 16) {
      return;
    }
    if (equation.isNotEmpty && !equation.startsWith('0') ||
        equation.length > 1) {
      setState(() {
        equation += '00';
      });
    }
  }

  void appendOperator(String operator) {
    //  if (equation.isEmpty) {
    //  return;
    //}

    String displayOperator = operator;
    if (operator == 'x') {
      operator = '*';
    }
    if (equation.isNotEmpty) {
      String lastCharacter = equation[equation.length - 1];
      if (lastCharacter != '+' &&
          lastCharacter != '-' &&
          lastCharacter != 'x' &&
          lastCharacter != '/') {
        setState(() {
          if (lastOperationWasCalculation) {
            equation = result + displayOperator;
            lastOperationWasCalculation = false;
          } else {
            equation += displayOperator;
          }
        });
      }
    }
  }

  void evaluateEquation(String text) {
    String equationToEvaluate = equation.replaceAll('x', '*');
    try {
      Parser p = Parser();
      Expression exp = p.parse(equationToEvaluate);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);

      setState(() {
        // Check if the decimal part is zero
        if (eval == eval.floor()) {
          // Convert to integer and then to string to remove decimal part
          result = eval.toInt().toString();
        } else {
          result = eval.toString();
        }
        lastOperationWasCalculation = true;
      });
      saveData('equation', equation);
      saveData('result', result);
      DatabaseHelper().saveUser(equation, result);
    } catch (e) {
      setState(() {
        result = 'Error';
      });
    }
  }
}
