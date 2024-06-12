import 'package:bang_client/app_base/base.dart';
import 'package:bang_client/storage/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthWidget extends ConsumerStatefulWidget {
  const AuthWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthWidgetState();
}

class _AuthWidgetState extends ConsumerState<AuthWidget> {
  @override
  Widget build(BuildContext context) {
    final asyncSettings = ref.watch(settingsNotifierProvider);
    final authNotifier = ref.watch(authN);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: asyncSettings.when(
        data: (settings) {
          
        },
        error: (err, st) => ErrorTextWidget(
          err: err,
          st: st,
        ),
        loading: () => const LoadingWidget(),
      ),
    );
  }
}
