import 'package:bang_client/app_base/base.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool loading;

  PrimaryButton({
    required this.onPressed,
    required this.text,
    this.loading = false,
  });

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
        padding: const EdgeInsets.all(16),
        child: Builder(
          builder: (context) {
            if (loading) {
              return const LoadingWidget();
            }
            return Text(
              text,
              style: const TextStyle(
                color: Colors.white,
              ),
            );
          },
        ),
      ),
    );
  }
}
