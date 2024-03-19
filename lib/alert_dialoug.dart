import 'package:flutter/material.dart';

void showDialogAlert(BuildContext context, String alertContent) {
  // flutter defined function
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        elevation: 5,
        shadowColor: Theme.of(context).colorScheme.shadow,
        titlePadding: EdgeInsets.only(
          bottom: 7,
        ),
        contentPadding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width / 7,
          right: MediaQuery.of(context).size.width / 7,
          top: 10,
          bottom: 30,
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        icon: Icon(
          Icons.error_outline,
          size: 50,
          color: Theme.of(context).colorScheme.onErrorContainer,
        ),
        title: Text("Alert!"),
        titleTextStyle: TextStyle(
          color: Theme.of(context).colorScheme.onErrorContainer,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
        content: Text(alertContent),
        contentTextStyle: TextStyle(
          color: Theme.of(context).colorScheme.onErrorContainer,
          fontSize: 16,
        ),
        actionsAlignment: MainAxisAlignment.end,
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(),
                  child: Text(
                    "Close",
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ]),
        ],
      );
    },
  );
}
