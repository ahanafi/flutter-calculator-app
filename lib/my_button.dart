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
      this.btnWidth = 100,
      this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 2.5),
      child: SizedBox(
        width: btnWidth,
        height: 100,
        child: FlatButton(
          shape: RoundedRectangleBorder(),
          child: Text(
            text,
            style: TextStyle(fontSize: 30),
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
