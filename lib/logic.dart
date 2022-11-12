import 'package:calc/screen_two.dart';
import 'package:flutter/material.dart';

import 'formulas.dart';
import 'history_page.dart';

// the logic for the calculator is in the screen_one.dart file

class ToConverterPage {
  static void func(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ConverterPage()),
      );
}

class ToHistoryPage {
  static void func2(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HistoryPage()),
      );
}

class Calculation {
  String calcMiles(inputNumber) {
    return miles(inputNumber).toString();
  }

  String calcKiloMeters(m) {
    return kilometers(m).toString();
  }
}
