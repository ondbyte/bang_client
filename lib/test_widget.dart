import 'package:bang_client/app_base/primary_button.dart';
import 'package:bang_client/app_base/theme.dart';
import 'package:bang_client/routes/auth/states.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pinput/pinput.dart';

class TestWidget extends StatefulWidget {
  const TestWidget({super.key});

  @override
  State<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  @override
  Widget build(BuildContext context) {
    final state = OtpSentState(OtpToken: "yadu", PhoneNumber: "+919964687717");
    return Theme(
      data: AppThemes.lightTheme,
      child: Builder(
        builder: (context) {
          return Scaffold(
            floatingActionButton: Builder(
              builder: (context) {
                return PrimaryButton(
                  onPressed: () {},
                  text: "Verify",
                );
              },
            ),
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 20,
                    fit: FlexFit.tight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Center(
                          child: Text(
                            "Please enter the OTP you recieved on",
                            style: TextStyle(
                              fontSize: 32,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Text(
                                state.PhoneNumber,
                                style: const TextStyle(
                                  fontSize: 22,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: const Text(
                                "change",
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Center(
                    child: Pinput(
                      defaultPinTheme: PinTheme(
                        height: 96,
                        width: 64,
                        textStyle: TextStyle(
                          fontSize: 64,
                          color: Colors.white,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          border: Border.fromBorderSide(
                            Theme.of(context)
                                .inputDecorationTheme
                                .enabledBorder!
                                .borderSide,
                          ),
                        ),
                      ),
                      onCompleted: (otp) {
                        print(otp);
                      },
                    ),
                  ),
                  const Flexible(
                    flex: 80,
                    fit: FlexFit.tight,
                    child: SizedBox(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
