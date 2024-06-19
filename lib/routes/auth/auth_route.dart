import 'package:bang_client/app_base/base.dart';
import 'package:bang_client/app_base/base_notifier.dart';
import 'package:bang_client/app_base/bottom_info.dart';
import 'package:bang_client/app_base/phone_number_widget.dart';
import 'package:bang_client/app_base/primary_button.dart';
import 'package:bang_client/routes/auth/auth_provider.dart';
import 'package:bang_client/routes/auth/otp_enter_screen.dart';
import 'package:bang_client/routes/auth/phone_enter_screen.dart';
import 'package:bang_client/routes/auth/states.dart';
import 'package:bang_client/storage/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_country_number_widgets/the_country_number_widgets.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    final asyncSettings = ref.watch(settingsNotifierProvider);
    return asyncSettings.when(
      data: (settings) {
        final authState = ref.watch(authNotifierProvider);
        final notifier = ref.read(authNotifierProvider.notifier);
        switch (authState) {
          case NoState noState:
            return PhoneNumberEnterScreen(
              onValidNumberEntered: (number) {
                notifier.SendOtp(number);
              },
              state: noState,
            );
          case OtpSentState oes:
            return OtpEnterScreen(
              onVerify: (otp) {},
              phoneNumber: oes.PhoneNumber,
              onChangePhoneNumber: () {
                notifier.ResetState();
              },
            );
          default:
            return UnknownValueWidget();
        }
        if (authState is ErrorState) {
          return Scaffold(
            body: ErrorTextWidget(
              err: authState.err,
              st: authState.st,
              retry: () {
                notifier.ResetState();
              },
            ),
          );
        }
      },
      error: (err, st) => ErrorTextWidget(
        err: err,
        st: st,
      ),
      loading: () => const LoadingWidget(),
    );
  }
}
