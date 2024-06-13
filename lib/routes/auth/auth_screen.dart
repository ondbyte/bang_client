import 'package:bang_client/app_base/base.dart';
import 'package:bang_client/app_base/phone_number_widget.dart';
import 'package:bang_client/routes/auth/auth_provider.dart';
import 'package:bang_client/routes/auth/states.dart';
import 'package:bang_client/storage/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    final asyncSettings = ref.watch(settingsNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: asyncSettings.when(
        data: (settings) {
          final authState = ref.watch(authNotifierProvider);
          if (authState is NoAuthState) {
            return PhoneNumberInputWidget(
              onChanged: (number) {
                print(number);
              },
            );
          }
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
