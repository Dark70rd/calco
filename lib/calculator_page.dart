import 'package:flutter/material.dart';
import 'package:simple_calculator/calculator_button.dart';
import 'package:simple_calculator/calculator_icon_button.dart';
import 'package:simple_calculator/state_save.dart';
import 'package:simple_calculator/database_helper.dart';
import 'package:simple_calculator/history_drawer.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:simple_calculator/calculator_mini_button.dart';

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
              height: MediaQuery.of(context).size.height / 8.5,
              color: Colors.grey[850],
              padding: const EdgeInsets.all(10),
              alignment: Alignment.centerRight,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                reverse: true,
                child: Text(
                  equation,
                  style: const TextStyle(color: Colors.white, fontSize: 35),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 11,
              color: Colors.grey[900],
              padding: const EdgeInsets.all(10),
              alignment: Alignment.centerRight,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                reverse: true,
                child: Text(
                  result,
                  style: const TextStyle(color: Colors.white, fontSize: 27),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CalculatorMiniButton(
                    '(',
                    Colors.blue,
                    (text) => appendOperator(text),
                  ),
                  CalculatorMiniButton(
                    ')',
                    Colors.blue,
                    (text) => appendOperator(text),
                  ),
                  CalculatorMiniButton(
                    '+/-',
                    Colors.blue,
                    () => toggleSign(),
                  ),
                ],
              ),
            ),
            Expanded(
                child: GridView.count(
              padding: const EdgeInsets.only(top: 2, bottom: 2, left: 2, right: 2),
              crossAxisCount: 4,
              //physics: const NeverScrollableScrollPhysics(),
              children: [
                CalculatorButton(
                  'AC',
                  Colors.red,
                  () => clearEquation(),
                ),
                CalculatorIconButton(Icons.backspace_outlined, Colors.blue,
                    () => deleteLastCharacter()),
                CalculatorButton(
                    '%', Colors.blue, (text) => appendPercentage(text)),
                CalculatorButton(
                    '/', Colors.blue, (text) => appendOperator(text)),
                CalculatorButton(
                    '7', Colors.black, (text) => appendNumber(text)),
                CalculatorButton(
                    '8', Colors.black, (text) => appendNumber(text)),
                CalculatorButton(
                    '9', Colors.black, (text) => appendNumber(text)),
                CalculatorButton(
                    'x', Colors.blue, (text) => appendOperator(text)),
                CalculatorButton(
                    '4', Colors.black, (text) => appendNumber(text)),
                CalculatorButton(
                    '5', Colors.black, (text) => appendNumber(text)),
                CalculatorButton(
                    '6', Colors.black, (text) => appendNumber(text)),
                CalculatorButton(
                    '-', Colors.blue, (text) => appendOperator(text)),
                CalculatorButton(
                    '1', Colors.black, (text) => appendNumber(text)),
                CalculatorButton(
                    '2', Colors.black, (text) => appendNumber(text)),
                CalculatorButton(
                    '3', Colors.black, (text) => appendNumber(text)),
                CalculatorButton(
                    '+', Colors.blue, (text) => appendOperator(text)),
                CalculatorButton(
                    '0', Colors.black, (text) => appendNumber(text)),
                CalculatorButton('.', Colors.black, () => appendDecimal()),
                CalculatorIconButton(
                  Icons.history_sharp,
                  Colors.blue,
                  () => _scaffoldKey.currentState?.openEndDrawer(),
                ),
                CalculatorButton(
                    '=', Colors.teal, (text) => evaluateEquation(text)),
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
      //String lastPart = equation.split(RegExp(r'[\+\-\x\/]')).last;

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

//  void appendDoubleZero() {
//    if (equation.length >= 16) {
//      return;
//    }
//    if (equation.isNotEmpty && !equation.startsWith('0') ||
//        equation.length > 1) {
//      setState(() {
//        equation += '00';
//      });
//    }
//  }

  void appendPercentage(String operator) {
    if (equation.isNotEmpty) {
      String lastCharacter = equation[equation.length - 1];
      if (lastCharacter != '+' &&
          lastCharacter != '-' &&
          lastCharacter != 'x' &&
          lastCharacter != '/' &&
          lastCharacter != '%') {
        setState(() {
          equation += operator;
        });
      }
    }
  }

  void toggleSign() {
    if (equation.isNotEmpty) {
      List<String> parts = equation.split(RegExp(r'(?<=[\+\x\/])|(?<=[\+\x\/]-)'));
      String lastNumber = parts.last;
      if (lastNumber.isNotEmpty) {
        if (lastNumber.startsWith('-')) {
          setState(() {
            equation = equation.replaceRange(
                equation.length - lastNumber.length,
                equation.length,
                lastNumber.substring(1));
          });
        } else {
          setState(() {
            equation = equation.replaceRange(
                equation.length - lastNumber.length,
                equation.length,
                '-' + lastNumber);
          });
        }
      }
    } else if (lastOperationWasCalculation && result.isNotEmpty) {
      if (result.startsWith('-')) {
        setState(() {
          result = result.substring(1);
          equation = result;
        });
      } else {
        setState(() {
          result = '-' + result;
          equation = result;
        });
      }
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
    if (equation.isNotEmpty || operator == '(') {
      String lastCharacter =
          equation.isNotEmpty ? equation[equation.length - 1] : '';
      if (lastCharacter != '+' &&
              lastCharacter != '-' &&
              lastCharacter != 'x' &&
              lastCharacter != '/' &&
              lastCharacter != '%' ||
          operator == '(' ||
          operator == ')') {
        setState(() {
          if (lastOperationWasCalculation &&
              operator != '(' &&
              operator != ')') {
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
    String equationToEvaluate =
        equation.replaceAll('x', '*').replaceAll('%', '/100');
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
