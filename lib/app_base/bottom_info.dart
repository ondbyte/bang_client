import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void showMsg(
  BuildContext context,
  String message,
) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: SizedBox(
      height: 64,
      width: double.infinity,
      child: Center(
        child: Text(message),
      ),
    ),
  ));
}
