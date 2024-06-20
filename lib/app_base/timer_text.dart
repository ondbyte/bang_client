import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum Tick {
  down,
  up,
}

class TimerText extends StatefulWidget {
  final Duration totalDuration;
  final Duration tickDuration;
  final DateFormat format;
  final Tick tick;
  final Function(BuildContext context, String timeStr) builder;
  final Function()? onDone;
  const TimerText({
    super.key,
    required this.totalDuration,
    required this.tickDuration,
    required this.format,
    required this.builder,
    required this.tick,
    this.onDone,
  });

  @override
  State<TimerText> createState() => _TimerTextState();
}

class _TimerTextState extends State<TimerText> {
  late Timer _timer;
  DateTime _time = DateTime(0, 0, 0);
  String _text = "";

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    var min = DateTime(0, 0, 0);
    var max = min.add(widget.totalDuration);
    if (widget.tick == Tick.down) {
      _time = _time.add(widget.totalDuration);
    }
    _timer = Timer.periodic(widget.tickDuration, (timer) {
      setState(() {
        if (widget.tick == Tick.down) {
          _time = _time.subtract(widget.tickDuration);
          if (_time.isBefore(min)) {
            _timer.cancel();
            _text = widget.format.format(min);
            widget.onDone?.call();
          }
        } else {
          _time = _time.add(widget.tickDuration);
          if (_time.isAfter(max)) {
            _timer.cancel();
            _text = widget.format.format(max);
            widget.onDone?.call();
          }
        }
        _text = widget.format.format(_time);
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _text);
  }
}
