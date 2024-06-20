import 'package:bang_client/app_base/bottom_info.dart';
import 'package:bang_client/app_base/primary_button.dart';
import 'package:bang_client/app_base/timer_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pinput/pinput.dart';

class OtpEnterScreen extends StatefulWidget {
  final Function(String otp) onVerify;
  final Function() onChangePhoneNumber, onResendOtp;
  final String phoneNumber;
  final DateTime resendEnableAt;
  const OtpEnterScreen({
    super.key,
    required this.onVerify,
    required this.phoneNumber,
    required this.onChangePhoneNumber,
    required this.resendEnableAt,
    required this.onResendOtp,
  });

  @override
  State<OtpEnterScreen> createState() => _OtEnterScreenState();
}

class _OtEnterScreenState extends State<OtpEnterScreen> {
  late final Duration resendDuration;
  var resendEnabled = false;
  @override
  void initState() {
    resendDuration = widget.resendEnableAt.difference(DateTime.now());
    super.initState();
  }

  String _otp = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Builder(
        builder: (context) {
          return PrimaryButton(
            onPressed: () {
              if (_otp == "") {
                showMsg(context, "please enter the otp");
                return;
              }
              widget.onVerify(_otp);
            },
            text: "Verify",
          );
        },
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 10,
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
                          widget.phoneNumber,
                          style: const TextStyle(
                            fontSize: 22,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      GestureDetector(
                        onTap: widget.onChangePhoneNumber,
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
                  textStyle: const TextStyle(
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
                  _otp = otp;
                },
              ),
            ),
            const Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: SizedBox(),
            ),
            if (resendEnabled)
              GestureDetector(
                onTap: widget.onResendOtp,
                child: const Text(
                  "resend otp",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            if (!resendEnabled)
              TimerText(
                totalDuration: resendDuration,
                tickDuration: const Duration(milliseconds: 1),
                format: DateFormat.ms(),
                tick: Tick.down,
                onDone: () {
                  setState(() {
                    resendEnabled = true;
                  });
                },
                builder: (context, timeStr) {
                  return Text("resend otp in $timeStr");
                },
              ),
            const Flexible(
              flex: 60,
              fit: FlexFit.tight,
              child: SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
