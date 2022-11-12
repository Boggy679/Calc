import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  HistoryPageState createState() => HistoryPageState();
}

class HistoryPageState extends State<HistoryPage> {
  static List<String> ourList = ['All equations:-'];

  @override
  void initState() {
    super.initState();
    getAll();
  }

  @override
  void dispose() {
    super.dispose();
    getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("History"),
      ),
      body: ListView.builder(
        itemCount: ourList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(ourList[index]),
          );
        },
      ),
    );
  }

  getAll() async {
    for (int i = 1; i < 100; i++) {
      var entry = await getStringValuesSF(i.toString());
      ourList.add(entry);
    }
  }

  getStringValuesSF(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? stringValue = prefs.getString(value);
    return stringValue;
  }
}
