// ignore_for_file: unused_local_variable, unused_element, unnecessary_this

import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Interest Calculator',
      theme:
          ThemeData(primarySwatch: Colors.teal, hintColor: Colors.tealAccent),
      home: Form(),
    );
  }
}

class Form extends StatefulWidget {
  @override
  _FormState createState() => _FormState();
}

class _FormState extends State<Form> {
  // controller
  TextEditingController principalTextEditingController =
      TextEditingController();
  TextEditingController rateofInterestTextEditingController =
      TextEditingController();
  TextEditingController termTextEditingController = TextEditingController();

  // currencices

  String result = "";
  String _character = "";
  String currentValue = "";
  String nv = "";

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Interest Calculator",
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            getImage(),
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: ListTile(
                      title: const Text(
                        "Simple Interest",
                        style: TextStyle(fontSize: 16),
                      ),
                      leading: Radio(
                        value: "simple",
                        groupValue: _character,
                        onChanged: (value) {
                          setState(() {
                            // here it is simple
                            _character = value!;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: ListTile(
                      title: const Text(
                        "Compound Interest",
                        style: TextStyle(fontSize: 16),
                      ),
                      leading: Radio(
                        value: "compound",
                        groupValue: _character,
                        onChanged: (value) {
                          setState(() {
                            _character = value!;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 5.0),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: TextField(
                style: const TextStyle(color: Colors.black),
                keyboardType: TextInputType.number,
                controller: principalTextEditingController,
                decoration: InputDecoration(
                  labelStyle: const TextStyle(color: Colors.black),
                  labelText: "Principal",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: TextField(
                style: const TextStyle(color: Colors.black),
                keyboardType: TextInputType.number,
                controller: rateofInterestTextEditingController,
                decoration: InputDecoration(
                  labelStyle: const TextStyle(color: Colors.black),
                  labelText: "Rate of Interest",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: TextField(
                style: const TextStyle(color: Colors.black),
                keyboardType: TextInputType.number,
                controller: termTextEditingController,
                decoration: InputDecoration(
                  labelStyle: const TextStyle(color: Colors.black),
                  labelText: "Term",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
            Container(
              height: 60,
              padding: const EdgeInsets.all(5),
              child: ElevatedButton(
                child: const Text(
                  "Calculate",
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  result = _getEffectiveAmount(nv);
                  onDialogOpen(context, result);
                },
              ),
            ),
            Container(
              height: 60,
              padding: const EdgeInsets.all(5),
              child: ElevatedButton(
                child: const Text(
                  "Reset",
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  _reset();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getEffectiveAmount(String newValue) {
    String newResult;
    double principal = double.parse(principalTextEditingController.text);
    double rate = double.parse(rateofInterestTextEditingController.text);
    double term = double.parse(termTextEditingController.text);

    String netpayableAmount = '';
    double netproper = 0;
    if (_character == "simple") {
      netproper = principal + (principal * rate * term) / 100;
      netpayableAmount = netproper.toStringAsFixed(2);
    } else if (_character == "compound") {
      netproper = principal * pow((1 + (rate / 100)), term);
      netpayableAmount = netproper.toStringAsFixed(2);
    }

    if (term == 1) {
      newResult =
          "After $term year, you will have to pay amount of $netpayableAmount Rupees";
    } else {
      newResult =
          "After $term year, you will have to pay amount of $netpayableAmount Rupees";
    }
    return newResult;
  }

  void _reset() {
    principalTextEditingController.text = "";
    rateofInterestTextEditingController.text = "";
    termTextEditingController.text = "";
    result = "";
  }

  // dialog box
  void onDialogOpen(BuildContext context, String s) {
    var alertDialog = AlertDialog(
      title: const Text("NP is selected...."),
      content: Text(s),
      backgroundColor: Colors.green,
      elevation: 8.0,
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            s,
          ),
        );
      },
    );
  }
}

Widget getImage() {
  AssetImage assetImage = const AssetImage("assets/cal.jpg");
  Image image = Image(
    image: assetImage,
    width: 340,
    height: 335,
  );

  return Container(
    margin: const EdgeInsets.all(5),
    child: image,
  );
}
