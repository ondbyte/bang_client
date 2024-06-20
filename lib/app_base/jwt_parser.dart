import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

Map<String, dynamic> getClaimsFromJwt(String token) {
  final splitted = token.split(".");
  if (splitted.length != 3) {
    throw const FormatException(
        "token should have 3 components separated by '.'");
  }

  String payload = splitted[1];
  // Add padding if necessary
  while (payload.length % 4 != 0) {
    payload += '=';
  }

  return jsonDecode(utf8.decode(base64Decode(payload)));
}
