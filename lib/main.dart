import 'package:flutter/material.dart';
import 'package:my_calculator_app/my_button.dart';

//Import library or package
import 'package:math_expressions/math_expressions.dart';
import 'package:toast/toast.dart';

void main() => runApp(MyCalculatorApp());

class MyCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        home: MyHomePage(),
        debugShowCheckedModeBanner: false);
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
  bool isPotraitScreeen = false;

  //Method to check what user input
  void btnClick(String text) {
    final List<String> expressionList = ['+', '-', '*', '/', '%', '=', '.'];

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

  //Method to reset the calculation history
  void clearResult(String text) {
    setState(() {
      _mathOperation = '';
      _calculationHistory = '';
    });
  }

  //Method to calculate the result
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

  //Show alert
  void alert(String message, {int duration}) {
    Toast.show(message, this.context,
        duration: duration, gravity: Toast.BOTTOM);
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    isPotraitScreeen =
        (mediaQuery.orientation == Orientation.portrait) ? true : false;

    return Scaffold(
        backgroundColor: Color(0xFF283637),
        resizeToAvoidBottomPadding: false,
        body: Container(
            height: mediaQuery.size.height / 1,
            child: (isPotraitScreeen)
                ? potraitDisplay(mediaQuery)
                : landscapeDisplay(mediaQuery)));
  }

  Widget potraitDisplay(MediaQueryData mediaQuery) {
    return Column(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
      //First Container section --> For history calculation
      displayCalculationHistory(true, mediaQuery),

      //Second Container section --> For display what user type
      displayExpression(true, mediaQuery),

      //Last Container section --> Button list
      displayButtons(true, mediaQuery)
    ]);
  }

  Widget landscapeDisplay(MediaQueryData mediaQuery) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Flexible(
            fit: FlexFit.loose,
            flex: 1,
            child: Container(
              child: Column(
                children: <Widget>[
                  Flexible(
                      flex: 3,
                      child: displayCalculationHistory(false, mediaQuery)),
                  Flexible(
                      flex: 1, child: displayExpression(false, mediaQuery)),
                ],
              ),
            )),
        Flexible(flex: 1, child: displayButtons(false, mediaQuery))
      ],
    );
  }

  Widget displayCalculationHistory(bool isPotrait, MediaQueryData mediaQuery) {
    return Container(
      child: Text(_calculationHistory,
          style: TextStyle(fontSize: 30, color: Colors.grey),
          textAlign: TextAlign.right),
      alignment: Alignment(1, 1),
      padding: EdgeInsets.only(right: 10.0),
    );
  }

  Widget displayExpression(bool isPotrait, MediaQueryData mediaQuery) {
    return Container(
      child: Text(_mathOperation,
          style: TextStyle(fontSize: 80, color: Colors.white),
          textAlign: TextAlign.right),
      alignment: Alignment(1, 1),
      padding: EdgeInsets.only(right: 10.0),
    );
  }

  Widget displayButtons(bool isPotrait, MediaQueryData mediaQuery) {
    return Container(
      width: mediaQuery.size.height / ((isPotrait) ? 2 : 1),
      child: Wrap(
        spacing: 0,
        runSpacing: 0,
        direction: (isPotrait) ? Axis.vertical : Axis.horizontal,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              MyCustomButton(
                  text: "CLEAR",
                  btnWidth: 2,
                  callback: clearResult,
                  isNumber: false),
              MyCustomButton(text: "%", callback: btnClick, isNumber: false),
              MyCustomButton(text: "/", callback: btnClick, isNumber: false)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              MyCustomButton(text: "7", callback: btnClick),
              MyCustomButton(text: "8", callback: btnClick),
              MyCustomButton(text: "9", callback: btnClick),
              MyCustomButton(text: "*", callback: btnClick, isNumber: false)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              MyCustomButton(text: "4", callback: btnClick),
              MyCustomButton(text: "5", callback: btnClick),
              MyCustomButton(text: "6", callback: btnClick),
              MyCustomButton(text: "-", callback: btnClick, isNumber: false)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              MyCustomButton(text: "1", callback: btnClick),
              MyCustomButton(text: "2", callback: btnClick),
              MyCustomButton(text: "3", callback: btnClick),
              MyCustomButton(text: "+", callback: btnClick, isNumber: false)
            ],
          ),
          Row(
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              MyCustomButton(text: "0", callback: btnClick),
              MyCustomButton(text: ".", callback: btnClick),
              MyCustomButton(
                  text: "=", btnWidth: 2, callback: calculate, isNumber: false)
            ],
          ),
        ],
      ),
    );
  }
}

/* 
  Created by
  Name  : Ahmad Hanafi
  Class : Software Engineering 1/7
  ID    : 2017102020
 */
