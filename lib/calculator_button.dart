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
      margin: const EdgeInsets.all(7),
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 4 ,
        height: MediaQuery.of(context).size.width / 4,
        child: MaterialButton(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              side: BorderSide(width: 1, color: Colors.white24)),
          color: bgColor,
          onPressed: onPressed is Function(String)
              ? () => onPressed(text)
              : onPressed as VoidCallback,
          child: Text(
            text,
            style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.normal,
                color: Colors.white),
          ),
        ),
      ),
    );
  }
}