import 'package:flutter/material.dart';


class CalculatorMiniButton extends StatelessWidget {
  final String text;
  final Color bgColor;
  final Function onPressed;

  const CalculatorMiniButton(this.text, this.bgColor, this.onPressed, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(7),
      child: SizedBox(
        width: (MediaQuery.of(context).size.width / 3.5),
        height: (MediaQuery.of(context).size.width / 4) - 65,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            //padding: EdgeInsets.only(top: 2, bottom: 2),
            elevation: 4,
            shadowColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
            backgroundColor: bgColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onPressed: onPressed is Function(String)
              ? () => onPressed(text)
              : onPressed as VoidCallback,
          child: Text(
            text,
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                ),
          ),
        ),
      ),
    );
  }
}