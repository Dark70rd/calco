import 'package:flutter/material.dart';
import 'package:simple_calculator/calculator_button.dart';
import 'package:simple_calculator/calculator_icon_button.dart';
import 'package:simple_calculator/state_save.dart';
import 'package:simple_calculator/database_helper.dart';
import 'package:simple_calculator/history_drawer.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:simple_calculator/calculator_mini_button.dart';
import 'package:simple_calculator/settings_page.dart';

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
    final resultDisplayColor = Theme.of(context).colorScheme.inversePrimary;
    final equationDisplay = Theme.of(context).colorScheme.primary;
    final equationFontSize = equation.length > 12 ? 25.0 : 50.0;
    final resultFontSize = equation.length > 12 ? 20.0 : 30.0;
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Scaffold(
        key: _scaffoldKey,
        endDrawerEnableOpenDragGesture: false,
        appBar: AppBar(
          title: const Text('Calculator',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          centerTitle: true,
          scrolledUnderElevation: 0.0,
          backgroundColor: Theme.of(context).colorScheme.primary,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.settings,
                size: 35,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingsPage(),
                  ),
                );
              },
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              height: (MediaQuery.of(context).size.height / 2) < 350
                  ? 200
                  : (MediaQuery.of(context).size.height / 3) - 1,
              child: Stack(
                clipBehavior: Clip.hardEdge,
                fit: StackFit.loose,
                children: <Widget>[
                  Positioned.fill(
                    //height: MediaQuery.of(context).size.height / 10,
                    //width: MediaQuery.of(context).size.width,
                    top: 77,
                    child: Container(
                      height: MediaQuery.of(context).size.height / 15,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: resultDisplayColor,
                        border: Border(
                          bottom: BorderSide(
                            width: 1,
                          ),
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      alignment: Alignment.bottomRight,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        reverse: true,
                        child: SelectableText(
                          result,
                          style: TextStyle(
                            //color: Colors.white,
                            fontSize: resultFontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height <= 200
                        ? 100
                        : MediaQuery.of(context).size.height / 4.5,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: equationDisplay,
                      border: Border(
                        bottom: BorderSide(
                          width: 1,
                        ),
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    alignment: Alignment.bottomRight,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      reverse: true,
                      child: Text(
                        equation,
                        style: TextStyle(
                          //color: Colors.white,
                          fontSize: equationFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 1.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  CalculatorMiniButton(
                    '(',
                    Theme.of(context).colorScheme.secondary,
                    (text) => appendOperator(text),
                  ),
                  CalculatorMiniButton(
                    ')',
                    Theme.of(context).colorScheme.secondary,
                    (text) => appendOperator(text),
                  ),
                  CalculatorMiniButton(
                    '+/-',
                    Theme.of(context).colorScheme.secondary,
                    () => toggleSign(),
                  ),
                ],
              ),
            ),
            Container(
                alignment: Alignment.bottomCenter,
                height: MediaQuery.of(context).size.height / 2,
                child: Padding(
                  padding: EdgeInsets.only(top: 3, bottom: 3),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CalculatorButton(
                              'C',
                              Theme.of(context).colorScheme.tertiary,
                              () => clearEquation(),
                            ),
                            CalculatorIconButton(
                                Icons.backspace_outlined,
                                Theme.of(context).colorScheme.secondary,
                                () => deleteLastCharacter()),
                            CalculatorButton(
                                '%',
                                Theme.of(context).colorScheme.secondary,
                                (text) => appendPercentage(text)),
                            CalculatorButton(
                                '/',
                                Theme.of(context).colorScheme.secondary,
                                (text) => appendOperator(text)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(2.5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CalculatorButton(
                                '7',
                                Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer,
                                (text) => appendNumber(text)),
                            CalculatorButton(
                                '8',
                                Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer,
                                (text) => appendNumber(text)),
                            CalculatorButton(
                                '9',
                                Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer,
                                (text) => appendNumber(text)),
                            CalculatorButton(
                                'x',
                                Theme.of(context).colorScheme.secondary,
                                (text) => appendOperator(text)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(2.5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CalculatorButton(
                                '4',
                                Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer,
                                (text) => appendNumber(text)),
                            CalculatorButton(
                                '5',
                                Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer,
                                (text) => appendNumber(text)),
                            CalculatorButton(
                                '6',
                                Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer,
                                (text) => appendNumber(text)),
                            CalculatorButton(
                                '-',
                                Theme.of(context).colorScheme.secondary,
                                (text) => appendOperator(text)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(2.5),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CalculatorButton(
                                  '1',
                                  Theme.of(context)
                                      .colorScheme
                                      .secondaryContainer,
                                  (text) => appendNumber(text)),
                              CalculatorButton(
                                  '2',
                                  Theme.of(context)
                                      .colorScheme
                                      .secondaryContainer,
                                  (text) => appendNumber(text)),
                              CalculatorButton(
                                  '3',
                                  Theme.of(context)
                                      .colorScheme
                                      .secondaryContainer,
                                  (text) => appendNumber(text)),
                              CalculatorButton(
                                  '+',
                                  Theme.of(context).colorScheme.secondary,
                                  (text) => appendOperator(text)),
                            ]),
                      ),
                      Padding(
                        padding: EdgeInsets.all(2.5),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CalculatorButton(
                                  '0',
                                  Theme.of(context)
                                      .colorScheme
                                      .secondaryContainer,
                                  (text) => appendNumber(text)),
                              CalculatorButton(
                                  '.',
                                  Theme.of(context)
                                      .colorScheme
                                      .secondaryContainer,
                                  () => appendDecimal()),
                              CalculatorIconButton(
                                Icons.history_sharp,
                                Theme.of(context).colorScheme.secondary,
                                () =>
                                    _scaffoldKey.currentState?.openEndDrawer(),
                              ),
                              CalculatorButton(
                                  '=',
                                  Theme.of(context)
                                      .colorScheme
                                      .tertiaryContainer,
                                  (text) => evaluateEquation(text)),
                            ]),
                      ),
                    ],
                  ),
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
      List<String> parts =
          equation.split(RegExp(r'(?<=[\+\x\/])|(?<=[\+\x\/]-)'));
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
