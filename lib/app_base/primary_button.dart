import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  PrimaryButton({required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith(
          (states) {
            if (states.contains(WidgetState.pressed)) {
              return Colors.grey.shade800;
            }
            return Colors.black;
          },
        ),
        shape: const WidgetStatePropertyAll(
          RoundedRectangleBorder(),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
