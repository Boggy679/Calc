import 'package:flutter/material.dart';
import 'logic.dart';


class ConverterPage extends StatelessWidget {
  const ConverterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Converter"),
        ),
        body: const Padding(
          padding: EdgeInsets.all(2.0),
          child: CalculationWidget(),
        ));
  }
}

class CalculationWidget extends StatefulWidget {
  const CalculationWidget({super.key});

  @override
  CalculationWidgetState createState() => CalculationWidgetState();
}

class CalculationWidgetState extends State<CalculationWidget> {
  late double inputNumber;
  String result = '';
  bool dataIsEntered = false;

  Calculation calculation = Calculation();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                  decoration:
                      const InputDecoration(hintText: 'Value to convert'),
                  keyboardType: TextInputType.number,
                  onChanged: (String number) {
                    if (number.isNotEmpty) {
                      inputNumber = double.parse(number.replaceAll(",", '.'));
                      setState(() {
                        dataIsEntered = true;
                      });
                    } else {
                      setState(() {
                        dataIsEntered = false;
                      });
                    }
                  },
                )),
              ],
            ),
          ),
          Expanded(
            child: Text(
              result,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(0),
            child: ElevatedButton(
              onPressed: () => {
                setState(() {
                  result = calculation.calcMiles(inputNumber);
                })
              },
              child: const Text("To miles"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(100),
            child: ElevatedButton(
              onPressed: () => {
                setState(() {
                  result = calculation.calcKiloMeters(inputNumber);
                })
              },
              child: const Text("To kilometers"),
            ),
          ),
        ],
      ),
    );
  }
}
