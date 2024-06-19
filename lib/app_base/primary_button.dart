import 'package:bang_client/app_base/base.dart';
import 'package:bang_client/app_base/base_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const PrimaryButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      var loading = ref.watch(loadingProvider);
      return TextButton(
        onPressed: loading ? null : onPressed,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Builder(
            builder: (context) {
              if (loading) {
                return const CircularProgressIndicator(
                  color: Colors.white,
                );
              }
              return Text(
                text,
                style: Theme.of(context)
                    .textButtonTheme
                    .style
                    ?.textStyle
                    ?.resolve(Set()),
              );
            },
          ),
        ),
      );
    });
  }
}
