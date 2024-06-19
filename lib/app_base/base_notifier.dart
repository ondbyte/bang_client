import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final loadingProvider = StateProvider((ref) => false);

abstract class BaseState {}

class NoState extends BaseState {}

abstract class BaseNotifier extends Notifier<BaseState> {
  void ResetState() {
    state = NoState();
  }

  void loading(bool b) {
    ref.read(loadingProvider.notifier).state = b;
  }
}
