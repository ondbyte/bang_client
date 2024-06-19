import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// returns the validated number
class PhoneNumberInputWidget extends StatefulWidget {
  final Function(String number) onChanged;
  const PhoneNumberInputWidget({super.key, required this.onChanged});

  @override
  State<PhoneNumberInputWidget> createState() => _PhoneNumberInputWidgetState();
}

class _PhoneNumberInputWidgetState extends State<PhoneNumberInputWidget> {
  final _phoneNumberController = TextEditingController();

  @override
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        controller: _phoneNumberController,
        keyboardType: TextInputType.phone,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          FilteringTextInputFormatter.singleLineFormatter
        ],
        onChanged: widget.onChanged,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 32,
        ),
        decoration: const InputDecoration(
          prefix: Text("+"),
          labelText: 'Phone Number',
          hintText: '91-1234567899',
          labelStyle: TextStyle(color: Colors.black),
          helperText:
              "include your country code aswell, ex: '91' if from India",
          helperStyle: TextStyle(color: Colors.black),
          /* focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(3)),
            gapPadding: 8,
            borderSide: BorderSide(
              style: BorderStyle.solid,
              color: Colors.black,
              width: 4,
            ),
          ), */
          /* enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(2)),
            gapPadding: 8,
            borderSide: BorderSide(
              style: BorderStyle.solid,
              color: Colors.black,
              width: 3,
            ),
          ), */
        ),
      ),
    );
  }
}
