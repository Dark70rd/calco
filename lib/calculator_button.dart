
import 'package:flutter/material.dart';


class CalculatorButton extends StatelessWidget {
  final String text;
  final Color bgColor;
  final Function onPressed;

  const CalculatorButton(this.text, this.bgColor, this.onPressed, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 13, //60,
      width: MediaQuery.of(context).size.width / 5, //80,
      margin: const EdgeInsets.all(2),
      child: SizedBox(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 4,
            shadowColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
            padding: EdgeInsets.zero,
            backgroundColor: bgColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          onPressed: onPressed is Function(String)
              ? () => onPressed(text)
              : onPressed as VoidCallback,
          child: Text(
            text,
            style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
        ),
      ),
    );
  }
}