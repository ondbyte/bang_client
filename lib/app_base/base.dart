import 'package:bang_client/app_base/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

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
  final Object? err;
  final StackTrace? st;
  final Function()? retry;
  const ErrorTextWidget(
      {super.key, required this.err, required this.st, this.retry});

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
    final err = widget.err;
    var text = "";
    if (err is GrpcError) {
      switch (err.codeName) {
        case "UNAVAILABLE":
          text = "server unavailable";
        default:
      }
    }
    if (text == "") {
      text = "unknown error";
    }
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text),
          if (widget.retry != null)
            PrimaryButton(
              onPressed: widget.retry!,
              text: "Retry",
            )
        ],
      ),
    );
  }
}
