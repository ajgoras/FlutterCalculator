import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.teal,
      ),
      dark: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.yellow,
      ),
      initial: AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MaterialApp(
        title: 'Calculator',
        theme: theme,
        darkTheme: darkTheme,
        home: const MyHomePage(title: 'Calculator'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String calculatorText = "";
  bool iscalculatorTextContainsOperator = false;
  bool iscalculatorTextContainsDot = false;
  var theme = ThemeData.light();

  void _addNumber(String number) {
    setState(() {
      calculatorText = calculatorText + number;
    });
  }

  void _clear() {
    setState(() {
      calculatorText = "";
      iscalculatorTextContainsOperator = false;
      iscalculatorTextContainsDot = false;
    });
  }

  void _backspace() {
    setState(() {
      if (calculatorText.length > 0) {
        if (calculatorText[calculatorText.length - 1] == '+' ||
            calculatorText[calculatorText.length - 1] == '-' ||
            calculatorText[calculatorText.length - 1] == '*' ||
            calculatorText[calculatorText.length - 1] == '/') {
          iscalculatorTextContainsOperator = false;
        }
        if (calculatorText[calculatorText.length - 1] == '.') {
          iscalculatorTextContainsDot = false;
        }
        calculatorText = calculatorText.substring(0, calculatorText.length - 1);
      }
    });
  }

  void _substract() {
    setState(() {
      if (calculatorText.length > 0 &&
          iscalculatorTextContainsOperator == false) {
        calculatorText = calculatorText + "-";
        iscalculatorTextContainsOperator = true;
        iscalculatorTextContainsDot = false;
      }
    });
  }

  void _add() {
    setState(() {
      if (calculatorText.length > 0 &&
          iscalculatorTextContainsOperator == false) {
        calculatorText = calculatorText + "+";
        iscalculatorTextContainsOperator = true;
        iscalculatorTextContainsDot = false;
      }
    });
  }

  void _multiply() {
    setState(() {
      if (calculatorText.length > 0 &&
          iscalculatorTextContainsOperator == false) {
        calculatorText = calculatorText + "*";
        iscalculatorTextContainsOperator = true;
        iscalculatorTextContainsDot = false;
      }
    });
  }

  void _divide() {
    setState(() {
      if (calculatorText.length > 0 &&
          iscalculatorTextContainsOperator == false) {
        calculatorText = calculatorText + "/";
        iscalculatorTextContainsOperator = true;
        iscalculatorTextContainsDot = false;
      }
    });
  }

  void _dot() {
    setState(() {
      if (calculatorText.length > 0 &&
          iscalculatorTextContainsDot == false &&
          calculatorText[calculatorText.length - 1] != '.' &&
          calculatorText[calculatorText.length - 1] != '+' &&
          calculatorText[calculatorText.length - 1] != '-' &&
          calculatorText[calculatorText.length - 1] != '*' &&
          calculatorText[calculatorText.length - 1] != '/') {
        calculatorText = calculatorText + ".";
        iscalculatorTextContainsDot = true;
      }
    });
  }

  void operation() {
    setState(() {
      String a = '';
      String b = '';
      bool isFirstHalf = true;
      for (var i = 0; i < calculatorText.length; i++) {
        if (isFirstHalf == true) {
          a += calculatorText[i];
        } else if (isFirstHalf == false) {
          b += calculatorText[i];
        }
        if (calculatorText[i] == '+' ||
            calculatorText[i] == '-' ||
            calculatorText[i] == '*' ||
            calculatorText[i] == '/') {
          isFirstHalf = false;
          a = a.substring(0, a.length - 1);
        }
      }
      if (calculatorText.contains('+')) {
        addOperation(a, b);
      } else if (calculatorText.contains('-')) {
        substractOperation(a, b);
      } else if (calculatorText.contains('*')) {
        multiplyOperation(a, b);
      } else if (calculatorText.contains('/')) {
        divideOperation(a, b);
      }
    });
  }

  void addOperation(String a, String b) {
    setState(() {
      double result = double.parse(a) + double.parse(b);
      result = double.parse((result).toStringAsFixed(9));
      calculatorText = result.toString();
    });
  }

  void substractOperation(String a, String b) {
    setState(() {
      double result = double.parse(a) - double.parse(b);
      result = double.parse((result).toStringAsFixed(9));
      calculatorText = result.toString();
    });
  }

  void multiplyOperation(String a, String b) {
    setState(() {
      double result = double.parse(a) * double.parse(b);
      result = double.parse((result).toStringAsFixed(9));
      calculatorText = result.toString();
    });
  }

  void divideOperation(String a, String b) {
    setState(() {
      double result = double.parse(a) / double.parse(b);
      result = double.parse((result).toStringAsFixed(9));
      calculatorText = result.toString();
      if (calculatorText == 'Infinity') {
        calculatorText = "Don't do that!";
        Future.delayed(const Duration(milliseconds: 50), () {
          calculatorText = '';
        });
      }
    });
  }

  bool checkIsInt() {
    bool result = false;
    for (var i = 0; i < calculatorText.length; i++) {
      if (calculatorText[calculatorText.length - 2] == '.' &&
          calculatorText[calculatorText.length - 1] == '0') {
        result = true;
      } else {
        result = false;
      }
    }
    return result;
  }

  void equalSignPressed() {
    setState(() {
      if (iscalculatorTextContainsOperator == true) {
        operation();
        if (checkIsInt() == true) {
          calculatorText =
              calculatorText.substring(0, calculatorText.length - 2);
          iscalculatorTextContainsDot = false;
        }
        iscalculatorTextContainsOperator = false;
      }
    });
  }

  void changeSign() {
    setState(() {
      if (calculatorText.length > 0) {
        if (calculatorText[0] == '-') {
          calculatorText = calculatorText.substring(1, calculatorText.length);
        } else {
          calculatorText = '-' + calculatorText;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: AspectRatio(
            aspectRatio: 58 / 109,
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      AdaptiveTheme.of(context).toggleThemeMode();
                      ;
                    },
                    child: const Icon(
                      Icons.sunny,
                      size: 31,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, h * 0.07, 0, h * 0.07),
                  alignment: Alignment.centerRight,
                  child: Text(
                    calculatorText,
                    style: TextStyle(fontSize: 32),
                  ),
                ),
                Expanded(
                  child: GridView.count(
                    primary: false,
                    padding: const EdgeInsets.all(15),
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    crossAxisCount: 4,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          color: Colors.teal[700],
                          child: TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                            ),
                            onPressed: () {
                              _clear();
                            },
                            child: const Text(
                              'C',
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          color: Colors.teal[700],
                          child: TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                            ),
                            onPressed: () {
                              _backspace();
                            },
                            child: const Icon(
                              Icons.arrow_back,
                              size: 31,
                            ),
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          color: Colors.teal[700],
                          child: TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                            ),
                            onPressed: () {
                              _divide();
                            },
                            child: const Text(
                              '/',
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          color: Colors.teal[700],
                          child: TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                            ),
                            onPressed: () {
                              _multiply();
                            },
                            child: const Text(
                              '*',
                              style: TextStyle(fontSize: 35),
                            ),
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          color: Colors.teal[400],
                          child: TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                            ),
                            onPressed: () {
                              _addNumber('7');
                            },
                            child: const Text(
                              '7',
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          color: Colors.teal[400],
                          child: TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                            ),
                            onPressed: () {
                              _addNumber('8');
                            },
                            child: const Text(
                              '8',
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          color: Colors.teal[400],
                          child: TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                            ),
                            onPressed: () {
                              _addNumber('9');
                            },
                            child: const Text(
                              '9',
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          color: Colors.teal[700],
                          child: TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                            ),
                            onPressed: () {
                              _substract();
                            },
                            child: const Text(
                              '-',
                              style: TextStyle(fontSize: 40),
                            ),
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          color: Colors.teal[400],
                          child: TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                            ),
                            onPressed: () {
                              _addNumber('4');
                            },
                            child: const Text(
                              '4',
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          color: Colors.teal[400],
                          child: TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                            ),
                            onPressed: () {
                              _addNumber('5');
                            },
                            child: const Text(
                              '5',
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          color: Colors.teal[400],
                          child: TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                            ),
                            onPressed: () {
                              _addNumber('6');
                            },
                            child: const Text(
                              '6',
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          color: Colors.teal[700],
                          child: TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                            ),
                            onPressed: () {
                              _add();
                            },
                            child: const Text(
                              '+',
                              style: TextStyle(fontSize: 35),
                            ),
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          color: Colors.teal[400],
                          child: TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                            ),
                            onPressed: () {
                              _addNumber('1');
                            },
                            child: const Text(
                              '1',
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          color: Colors.teal[400],
                          child: TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                            ),
                            onPressed: () {
                              _addNumber('2');
                            },
                            child: const Text(
                              '2',
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          color: Colors.teal[400],
                          child: TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                            ),
                            onPressed: () {
                              _addNumber('3');
                            },
                            child: const Text(
                              '3',
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          color: Colors.teal[700],
                          child: TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                            ),
                            onPressed: () {
                              changeSign();
                            },
                            child: const Text(
                              '+/-',
                              style: TextStyle(fontSize: 30),
                            ),
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          color: Colors.teal[700],
                          child: TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                            ),
                            onPressed: () {
                              _addNumber('00');
                            },
                            child: const Text(
                              '00',
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          color: Colors.teal[700],
                          child: TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                            ),
                            onPressed: () {
                              _addNumber('0');
                            },
                            child: const Text(
                              '0',
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          color: Colors.teal[700],
                          child: TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                            ),
                            onPressed: () {
                              _dot();
                            },
                            child: const Text(
                              '.',
                              style: TextStyle(fontSize: 30),
                            ),
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          color: Colors.teal[700],
                          child: TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                            ),
                            onPressed: () {
                              equalSignPressed();
                            },
                            child: const Text(
                              '=',
                              style: TextStyle(fontSize: 30),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
