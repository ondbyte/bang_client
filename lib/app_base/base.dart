import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class UnknownValueWidget extends StatelessWidget {
  const UnknownValueWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("unknown value"),
    );
  }
}

class ErrorTextWidget extends StatefulWidget {
  final Object err;
  final StackTrace st;
  const ErrorTextWidget({super.key, required this.err, required this.st});

  @override
  State<ErrorTextWidget> createState() => _ErrorTextWidgetState();
}

class _ErrorTextWidgetState extends State<ErrorTextWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.err);
    print(widget.st);
  }

  @override
  Widget build(BuildContext context) {
    return const Text("error encountered");
  }
}
