import 'package:flutter/material.dart';
import '../constants.dart';
import 'button.dart';

class KeyPad extends StatelessWidget {
  final Function onTap;

  KeyPad(this.onTap);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Button("C", colorFunc, colorMain, onTap),
            Button("+/-", colorFunc, colorMain, onTap),
            Button("%", colorFunc, colorMain, onTap),
            Button("/", colorCalc, colorText, onTap),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Button("7", colorNum, colorText, onTap),
            Button("8", colorNum, colorText, onTap),
            Button("9", colorNum, colorText, onTap),
            Button("x", colorCalc, colorText, onTap),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Button("4", colorNum, colorText, onTap),
            Button("5", colorNum, colorText, onTap),
            Button("6", colorNum, colorText, onTap),
            Button("-", colorCalc, colorText, onTap),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Button("1", colorNum, colorText, onTap),
            Button("2", colorNum, colorText, onTap),
            Button("3", colorNum, colorText, onTap),
            Button("+", colorCalc, colorText, onTap),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Button("0", colorNum, colorText, onTap),
            Button(".", colorNum, colorText, onTap),
            Button("=", colorCalc, colorText, onTap),
          ],
        ),
      ],
    );
  }
}
