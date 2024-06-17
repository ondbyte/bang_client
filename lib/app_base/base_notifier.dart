import 'package:riverpod_annotation/riverpod_annotation.dart';

class BaseState {
  bool loading;

  BaseState({this.loading = false});
}

class NoState extends BaseState {}

abstract class BaseNotifier extends Notifier<BaseState> {
  void ResetState() {
    state = NoState();
  }

  // sets the state as loading
  void loading() {
    state.loading = true;
    state = state;
  }
}
