import 'package:flutter/material.dart';
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
                    style: const TextStyle(color: Colors.white, fontSize: 100),
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

  double firstNumber = 0;
  double secondNumber = 0;
  String output = "0";
  String out = "0";
  String operation = "";

  Future<void> calc(buttonText) async {
    if (buttonText == "=") {
      secondNumber = double.parse(output);
      if (operation == "+") {
        out = (firstNumber + secondNumber).toString();
        buildHistory('+');
      }
      if (operation == "*") {
        out = (firstNumber * secondNumber).toString();
        buildHistory('*');
      }
      if (operation == "-") {
        out = (firstNumber - secondNumber).toString();
        buildHistory('-');
      }
      if (operation == "/") {
        out = (firstNumber / secondNumber).toString();
        buildHistory('/');
      }
      firstNumber = 0.0;
      secondNumber = 0.0;
    } else if (buttonText == "-" ||
        buttonText == "+" ||
        buttonText == "/" ||
        buttonText == "*") {
      firstNumber = double.parse(output);
      operation = buttonText;
      out = "0";
      output = output + buttonText;
    } else if (buttonText == "C") {
      out = "0";
      firstNumber = 0;
      secondNumber = 0;
      operation = "";
    } else {
      out = out + buttonText;
    }
    setState(() {
      output = double.parse(out).toStringAsFixed(2);
    });
  }

  void buildHistory( String ops) {
    historyList.add('$firstNumber + $ops + $secondNumber = $out');
  }

  addHistoryListToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (var entry in historyList) {
      prefs.setString(iteration.toString(), entry);
      iteration++;
    }
  }
}
