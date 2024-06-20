import 'package:bang_client/routes/auth/err_state.dart';
import 'package:flutter/material.dart';

class ErrScreen extends StatefulWidget {
  final ErrorState errState;
  final WidgetBuilder buttons;
  const ErrScreen({super.key, required this.errState, required this.buttons});

  @override
  State<ErrScreen> createState() => _ErrScreenState();
}

class _ErrScreenState extends State<ErrScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Flexible(
              flex: 40,
              fit: FlexFit.tight,
              child: SizedBox(),
            ),
            Flexible(
              flex: 40,
              fit: FlexFit.tight,
              child: AspectRatio(
                aspectRatio: 1,
                child: SizedBox(
                  width: 512,
                  height: 512,
                  child: Image.asset("assets/undraw_Air_support_re_nybl.png"),
                ),
              ),
            ),
            const Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: SizedBox(),
            ),
            Text(
              widget.errState.getUserPresentableErr(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: SizedBox(),
            ),
            widget.buttons(context),
            const Flexible(
              flex: 40,
              fit: FlexFit.tight,
              child: SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
