import 'package:flutter/material.dart';

buildPopupDialog(BuildContext context) {
  return  AlertDialog(
    title: const Text('Popup example'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        Text("Done"),
        Text("Requested granted")
      ],
    ),
    actions: <Widget>[
      TextButton(
        style:  TextButton.styleFrom(backgroundColor: Colors.blue),
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('Close'),
      ),
    ],
  );
}