import 'package:flutter/material.dart';

class PressedButton extends StatelessWidget {
  final String title;

  PressedButton(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 9),
      decoration: BoxDecoration(
          color: Colors.black12,
          border: Border.all(
            color: Colors.black45,
            width: 2,
          )),
      child: FittedBox(
        fit: BoxFit.cover,
        child: Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
          ),
        ),
      ),
    );
  }
}
