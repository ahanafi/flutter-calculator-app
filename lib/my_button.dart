import 'package:flutter/material.dart';

class MyCustomButton extends StatelessWidget {
  final String text;
  final String btnType;
  final double btnWidth;
  final Function callback;

  MyCustomButton(
      {Key key,
      this.text,
      this.btnType = 'number',
      this.btnWidth = 4,
      this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        width: MediaQuery.of(context).size.width / btnWidth,
        height: MediaQuery.of(context).size.width / 4,
        child: FlatButton(
          shape: Border.all(color: Colors.white, width: 1.0),
          child: Text(
            text,
            style: TextStyle(fontSize: MediaQuery.of(context).size.width / 16),
          ),
          onPressed: () {
            callback(text);
          },
          color: (btnType != 'number')
              ? Colors.deepOrangeAccent
              : Colors.blueAccent,
          textColor: Colors.white,
        ),
      ),
    );
  }
}
