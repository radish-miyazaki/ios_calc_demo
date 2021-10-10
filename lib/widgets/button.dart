import 'package:flutter/material.dart';
import 'package:calc_clone/constants.dart';

class Button extends StatelessWidget {
  final String text;
  final Color colorButton;
  final Color colorText;
  final Function onTap;

  Button(this.text, this.colorButton, this.colorText, this.onTap)
      : super(key: Key(text));

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton(
        child: Padding(
          padding: text == "0"
              ? const EdgeInsets.only(left: 10, top: 20, right: 90, bottom: 20)
              : EdgeInsets.symmetric(vertical: 20),
          child: mapIcon.containsKey(text)
              ? Icon(mapIcon[text], size: 30)
              : Text(text,
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.w300)),
        ),
        onPressed: () => onTap(text),
        style: ElevatedButton.styleFrom(
          primary: colorButton,
          onPrimary: colorText,
          shape: text == "0" ? const StadiumBorder() : const CircleBorder(),
        ),
      ),
    );
  }
}
