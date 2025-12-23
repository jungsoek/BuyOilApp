import 'package:flutter/material.dart';

void showToastMessage(BuildContext context, String message) {
  final SnackBar snackBar = SnackBar(
    content: Text(message),
    duration: const Duration(seconds: 2), // How long the toast is displayed
    action: SnackBarAction(
      label: 'Undo', // Optional action
      onPressed: () {
        // Some code to undo the change.
        print('Undo action pressed');
      },
    ),
    behavior: SnackBarBehavior.floating, // Makes it float above bottom nav bar
    shape: RoundedRectangleBorder( // Optional: for rounded corners
      borderRadius: BorderRadius.circular(10.0),
    ),
    margin: const EdgeInsets.all(10.0), // Optional: if behavior is floating
  );

  // Find the ScaffoldMessenger in the widget tree and use it to show a SnackBar.
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}