import 'package:flutter/material.dart';

void showCustomSnackbar(BuildContext context, String message,
    {Color? backgroundColor}) {
  final snackBar = SnackBar(
    showCloseIcon: true,
    content: Row(
      children: [
        const Icon(Icons.info, color: Colors.white),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            message,
            maxLines: 5,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
    backgroundColor: backgroundColor ?? Colors.blue,
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height - 100, right: 20, left: 20),
    elevation: 10,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    duration: const Duration(seconds: 3),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
