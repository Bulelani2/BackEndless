/**
 * This code creates a SnackBar with a duration of 2500 milliseconds, an elevation of 10, a rounded rectangle border with a circular radius of 5, a background color of purple, and a content of a given message.
 * It is then displayed on the Scaffold of the given context.
 */
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    duration: const Duration(milliseconds: 2500),
    elevation: 10,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
      topLeft: Radius.circular(5),
      topRight: Radius.circular(5),
    )),
    backgroundColor: Color.fromARGB(255, 29, 29, 29),
    content: Text(message),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
