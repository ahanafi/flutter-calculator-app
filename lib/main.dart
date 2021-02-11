import 'package:flutter/material.dart';
import 'package:my_calculator_app/my_button.dart';

//Import library or package
import 'package:math_expressions/math_expressions.dart';
import 'package:toast/toast.dart';

void main() => runApp(MyCalculatorApp());

class MyCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Flutter Demo', home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  CalculatorAppState createState() => CalculatorAppState();
}

class CalculatorAppState extends State<MyHomePage> {
  String _mathOperation = '';
  String _calculationHistory = '';

  void btnClick(String text) {
    final List<String> expressionList = ['+', '-', '*', '/', '%', '='];

    final bool isInputExpression =
        (expressionList.contains(text)) ? true : false;

    setState(() {
      if (isInputExpression && _mathOperation.length == 0) {
        alert('Please input number first!');
      } else {
        _mathOperation += text;
      }
    });
  }

  void clearResult(String text) {
    setState(() {
      _mathOperation = '';
      _calculationHistory = '';
    });
  }

  void calculate(String text) {
    final bool isContainPlus = _mathOperation.contains('+') ? true : false;
    final bool isContainMinus = _mathOperation.contains('-') ? true : false;
    final bool isContainX = _mathOperation.contains('*') ? true : false;
    final bool isContainSlash = _mathOperation.contains('/') ? true : false;
    final bool isContainModSign = _mathOperation.contains('%') ? true : false;

    final bool isThereOperation = (isContainPlus ||
            isContainMinus ||
            isContainX ||
            isContainSlash ||
            isContainModSign)
        ? true
        : false;

    //kalo ada operasi, terus tekan sama dengan, hitung
    //kalo ga ada, jangan hitung

    if (isThereOperation) {
      Parser parser = Parser();
      Expression exp = parser.parse(_mathOperation);

      ContextModel contexModel = ContextModel();

      double result = exp.evaluate(EvaluationType.REAL, contexModel);

      setState(() {
        _calculationHistory = _mathOperation;
        _mathOperation = result.toString().split(".")[0];
      });
    } else {
      alert("Please input math operation first!");
    }
  }

  void alert(String message, {int duration}) {
    Toast.show(message, context, duration: duration, gravity: Toast.BOTTOM);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF283637),
        body: Container(
          margin: EdgeInsets.all(5.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 10.0),
                  child: Text(_calculationHistory,
                      style: TextStyle(fontSize: 30, color: Colors.grey),
                      textAlign: TextAlign.right),
                  alignment: Alignment(1, 1),
                  padding: EdgeInsets.only(right: 10.0),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 30.0),
                  child: Text(_mathOperation,
                      style: TextStyle(fontSize: 60, color: Colors.white),
                      textAlign: TextAlign.right),
                  alignment: Alignment(1, 1),
                  padding: EdgeInsets.only(right: 10.0),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    MyCustomButton(
                        text: "CLEAR",
                        btnWidth: 202,
                        btnType: 'operation',
                        callback: clearResult),
                    MyCustomButton(
                        text: "%", btnType: 'operation', callback: btnClick),
                    MyCustomButton(
                        text: "/", btnType: 'operation', callback: btnClick)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    MyCustomButton(text: "7", callback: btnClick),
                    MyCustomButton(text: "8", callback: btnClick),
                    MyCustomButton(text: "9", callback: btnClick),
                    MyCustomButton(
                        text: "*", btnType: 'operation', callback: btnClick)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    MyCustomButton(text: "4", callback: btnClick),
                    MyCustomButton(text: "5", callback: btnClick),
                    MyCustomButton(text: "6", callback: btnClick),
                    MyCustomButton(
                        text: "-", btnType: 'operation', callback: btnClick)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    MyCustomButton(text: "1", callback: btnClick),
                    MyCustomButton(text: "2", callback: btnClick),
                    MyCustomButton(text: "3", callback: btnClick),
                    MyCustomButton(
                        text: "+", btnType: 'operatio', callback: btnClick)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    MyCustomButton(text: "0", callback: btnClick),
                    MyCustomButton(text: ".", callback: btnClick),
                    MyCustomButton(
                        text: "=",
                        btnType: 'operation',
                        btnWidth: 202,
                        callback: calculate)
                  ],
                ),
              ]),
        ));
  }
}
