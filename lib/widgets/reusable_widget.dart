import 'package:flutter/material.dart';

SnackBar generalSnackBar(successMessage, context) {
  return SnackBar(
    duration: Duration(milliseconds: 1500),
    backgroundColor: Colors.white.withOpacity(0.9),
    content: Container(
      height: 60,
      alignment: Alignment.center,
      child: Text(
        successMessage,
        style: Theme.of(context).textTheme.headline5!.copyWith(
              color: Theme.of(context).accentColor,
            ),
      ),
    ),
  );
}

Future<dynamic> generalAlertDialog(context, errMessage) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Text(errMessage),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Okay"),
        )
      ],
    ),
  );
}
