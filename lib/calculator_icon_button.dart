import 'package:flutter/material.dart';


class CalculatorIconButton extends StatelessWidget {
  final IconData icon;
  final Color bgColor;
  final Function onPressed;

  const CalculatorIconButton(this.icon, this.bgColor, this.onPressed,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(7),
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 4,
        height: MediaQuery.of(context).size.width / 4,
        child: MaterialButton(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              side: BorderSide(width: 1, color: Colors.white12)),
          color: bgColor,
          onPressed: onPressed as VoidCallback,
          child: Icon(
            icon,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }
}
