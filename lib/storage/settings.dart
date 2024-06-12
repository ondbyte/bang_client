import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings.g.dart';
part 'settings.freezed.dart';

@freezed
class Settings with _$Settings {
  factory Settings({
    required String? accessToken,
    required String? sessionToken,
    required String? userName,
  }) = _Settings;

  factory Settings.fromJson(Map<String, dynamic> json) =>
      _$SettingsFromJson(json);
}
