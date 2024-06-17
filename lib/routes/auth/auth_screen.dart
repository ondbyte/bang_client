import 'package:bang_client/app_base/base.dart';
import 'package:bang_client/app_base/base_notifier.dart';
import 'package:bang_client/app_base/phone_number_widget.dart';
import 'package:bang_client/app_base/primary_button.dart';
import 'package:bang_client/routes/auth/auth_provider.dart';
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
  TheNumber number = TheNumber();

  @override
  Widget build(BuildContext context) {
    final asyncSettings = ref.watch(settingsNotifierProvider);
    return asyncSettings.when(
      data: (settings) {
        final authState = ref.watch(authNotifierProvider);
        final notifier = ref.read(authNotifierProvider.notifier);
        switch (authState.runtimeType) {
          case NoneState _:
            return Scaffold(
              floatingActionButton: PrimaryButton(
                onPressed: () {
                  if (number.isValidLength) {
                    notifier.SendOtp(number.internationalNumber);
                  }
                },
                text: "Send OTP",
                loading: authState.loading,
              ),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 64,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      PhoneNumberInputWidget(
                        onChanged: (num) {
                          number = TheCountryNumber()
                              .parseNumber(internationalNumber: "+$num");
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          default:
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
        return UnknownValueWidget();
      },
      error: (err, st) => ErrorTextWidget(
        err: err,
        st: st,
      ),
      loading: () => const LoadingWidget(),
    );
  }
}
