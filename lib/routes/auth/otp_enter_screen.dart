import 'package:bang_client/app_base/bottom_info.dart';
import 'package:bang_client/app_base/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OtpEnterScreen extends StatefulWidget {
  final Function(String) onVerify;
  final Function() onChangePhoneNumber;
  final String phoneNumber;
  const OtpEnterScreen(
      {super.key,
      required this.onVerify,
      required this.phoneNumber,
      required this.onChangePhoneNumber});

  @override
  State<OtpEnterScreen> createState() => _OtEnterScreenState();
}

class _OtEnterScreenState extends State<OtpEnterScreen> {
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
                  _otp = otp;
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
  }
}
