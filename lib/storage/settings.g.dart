// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SettingsImpl _$$SettingsImplFromJson(Map<String, dynamic> json) =>
    _$SettingsImpl(
      accessToken: json['accessToken'] as String?,
      sessionToken: json['sessionToken'] as String?,
      userName: json['userName'] as String?,
      theme: $enumDecodeNullable(_$ThemeModeEnumMap, json['theme']),
    );

Map<String, dynamic> _$$SettingsImplToJson(_$SettingsImpl instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'sessionToken': instance.sessionToken,
      'userName': instance.userName,
      'theme': _$ThemeModeEnumMap[instance.theme],
    };

const _$ThemeModeEnumMap = {
  ThemeMode.system: 'system',
  ThemeMode.light: 'light',
  ThemeMode.dark: 'dark',
};
