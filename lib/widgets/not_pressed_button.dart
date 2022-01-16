import 'package:flutter/material.dart';

class NotPressedButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 9),
      decoration: BoxDecoration(
        color: Colors.black12,
        border: Border(
          left: BorderSide(
            color: Colors.white70,
            width: 5,
          ),
          top: BorderSide(
            color: Colors.white70,
            width: 5,
          ),
          right: BorderSide(
            color: Colors.black45,
            width: 5,
          ),
          bottom: BorderSide(
            color: Colors.black45,
            width: 5,
          ),
        ),
      ),
      child: FittedBox(
        fit: BoxFit.cover,
        child: Text(
          " ",
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
          ),
        ),
      ),
    );
  }
}
