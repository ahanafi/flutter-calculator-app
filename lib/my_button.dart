import 'package:flutter/material.dart';

class MyCustomButton extends StatelessWidget {
  final String text;
  double btnWidth;
  final Function callback;
  final bool isNumber;

  MyCustomButton(
      {Key key,
      this.text,
      this.btnWidth = 1,
      this.callback,
      this.isNumber = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final bool isPotraitScreeen =
        (mediaQuery.orientation == Orientation.portrait) ? true : false;

    double _realBtnWidth = 4;
    double _realBtnHeight = 4;

    //Cek apakah layarnya landscape,
    if (!isPotraitScreeen) {
      _realBtnWidth = _realBtnWidth * 2;
      _realBtnHeight = _realBtnHeight * 2;
    }

    //Cek ukuran button, apakah 1 (persegi), atau 2 (persegi panjang)
    if (btnWidth > 1) {
      _realBtnWidth = _realBtnWidth / 2;
    }

    return Container(
      child: SizedBox(
        width: mediaQuery.size.width / _realBtnWidth,
        height: mediaQuery.size.width / _realBtnHeight,
        child: FlatButton(
          shape: Border.all(color: Colors.white, width: 1.0),
          child: Text(
            text,
            style: TextStyle(fontSize: mediaQuery.size.width / 16),
          ),
          onPressed: () {
            callback(text);
          },
          color: (isNumber) ? Colors.blueAccent : Colors.deepOrangeAccent,
          textColor: Colors.white,
        ),
      ),
    );
  }
}
