import 'dart:async';
import 'dart:convert';

import 'package:bang_client/storage/settings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsNotifier extends AsyncNotifier<Settings> {
  static const settingsKey = "settings";

  @override
  FutureOr<Settings> build() async {
    return ReadFromStorage();
  }

  FutureOr<Settings> ReadFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final settingsStr = prefs.getString(settingsKey);
    if (settingsStr == null) {
      return Settings(accessToken: null, sessionToken: null, userName: null,theme: null);
    }
    final m = jsonDecode(settingsStr);
    final data = AsyncData(Settings.fromJson(m));
    return data.value;
  }

  Future<void> UpdateSettings(Settings s) async {
    final prefs = await SharedPreferences.getInstance();
    final prevState = state;
    state = AsyncData(s);
    final set = await prefs.setString(settingsKey, jsonEncode(s));
    if (!set) {
      state = prevState;
    }
  }
}

final settingsNotifierProvider =
    AsyncNotifierProvider<SettingsNotifier, Settings>(SettingsNotifier.new);
