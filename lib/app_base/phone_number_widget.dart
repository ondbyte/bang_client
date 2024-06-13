import 'package:flutter/material.dart';
import 'package:the_country_number_widgets/the_country_number_widgets.dart';

// returns the validated number
class PhoneNumberInputWidget extends StatefulWidget {
  final Function(String number) onChanged;
  const PhoneNumberInputWidget({super.key, required this.onChanged});

  @override
  State<PhoneNumberInputWidget> createState() => _PhoneNumberInputWidgetState();
}

class _PhoneNumberInputWidgetState extends State<PhoneNumberInputWidget> {
  @override
  Widget build(BuildContext context) {
    return TheCountryNumberInput(
      TheNumber(dialCode: "+91"),
      onChanged: (p0) {
        widget.onChanged(p0.internationalNumber);
      },
      showDialCode: true,
    );
  }
}
