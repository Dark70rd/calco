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
          onPressed: onPressed as VoidCallback,
          child: Icon(
            icon,
            color: Colors.black,
            size: 35,
          ),
        ),
      ),
    );
  }
}
