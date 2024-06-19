import 'package:bang_client/app_base/base_notifier.dart';
import 'package:bang_client/app_base/bottom_info.dart';
import 'package:bang_client/app_base/phone_number_widget.dart';
import 'package:bang_client/app_base/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:the_country_number_widgets/the_country_number_widgets.dart';

class PhoneNumberEnterScreen extends StatefulWidget {
  final Function(String) onValidNumberEntered;
  final NoState state;
  const PhoneNumberEnterScreen(
      {super.key, required this.onValidNumberEntered, required this.state});

  @override
  State<PhoneNumberEnterScreen> createState() => _PhoneNumberEnterScreenState();
}

class _PhoneNumberEnterScreenState extends State<PhoneNumberEnterScreen> {
  var number = TheCountryNumber().parseNumber(dialCode: "+91");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Builder(
        builder: (context) {
          return PrimaryButton(
            onPressed: () {
              if (number.isValidLength) {
                widget.onValidNumberEntered(number.internationalNumber);
              } else {
                showMsg(context, "enter a valid phone number");
              }
            },
            text: "Send OTP",
          );
        },
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
  }
}
