import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'logic.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  Widget button(String buttonText) {
    return ElevatedButton(
      onPressed: () => calc(buttonText),
      child: Text(
        buttonText,
        style: const TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }

  static List<String> historyList = [];
  static int iteration = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Mike's Calculator"),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              ToConverterPage.func(context);
            },
            child: Container(
              color: Colors.purple,
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: const Text(
                'Converter',
                style: TextStyle(color: Colors.white, fontSize: 15.0),
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              await addHistoryListToSF();
              ToHistoryPage.func2(context);
            },
            child: Container(
              color: Colors.purple,
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: const Text(
                'History',
                style: TextStyle(color: Colors.white, fontSize: 15.0),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    output,
                    textAlign: TextAlign.left,
                    style: const TextStyle(color: Colors.white, fontSize: 70),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                button('C'),
                button('+'),
                button('/'),
                button('-'),
              ],
            ),
            const SizedBox(
              height: 55,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                button('7'),
                button('8'),
                button('9'),
                button('*'),
              ],
            ),
            const SizedBox(
              height: 55,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                button('4'),
                button('5'),
                button('6'),
                button('%'),
              ],
            ),
            const SizedBox(
              height: 55,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                button('1'),
                button('2'),
                button('3'),
                button('+/-'),
              ],
            ),
            const SizedBox(
              height: 55,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                button('0'),
                button('.'),
                button('AC'),
                button('='),
              ],
            ),
            const SizedBox(
              height: 55,
            ),
          ],
        ),
      ),
    );
  }

// logic for most buttons in the calculator

  String output = "0";
  String out = "0";
  String expression = "";

  Future<void> calc(buttonText) async {
    if (buttonText == "=") {
      if (expression.isEmpty) {
        expression = expression + "0";
      }
      try {
        Parser p = Parser();
        Expression exp = p.parse(expression);
        ContextModel cm = ContextModel();
        var result = exp.evaluate(EvaluationType.REAL, cm);
        buildHistory(expression, result.toString());
        expression = result.toString();
        out = result.toString();
        print('result =  $result');
      } catch (error) {
        print('invalid expression, please start with a number and end with a number =  $error');
      }
    }
    else if (buttonText == "C") {
      out = "0";
      expression = "";
    } else {
      expression = expression + buttonText;
      print(expression);
      if(!["+", "-", "*", "/"].contains(buttonText)){
        out = expression;
      }
      output = output + buttonText;
    }
    setState(() {
      output = out;
    });
  }

  void buildHistory(String exp, String res) {
    var idk = '$exp = $res';
    historyList.add(idk);
  }

  addHistoryListToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (var entry in historyList) {
      prefs.setString(iteration.toString(), entry);
      iteration++;
    }
  }
}
