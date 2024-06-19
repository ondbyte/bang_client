import 'package:bang_client/storage/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class AppThemes {
  static final lightTheme = ThemeData(
    primaryColor: Colors.black,
    scaffoldBackgroundColor: Colors.white,
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
      color: Colors.black87,
      elevation: 4,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(2)),
        gapPadding: 8,
        borderSide: BorderSide(
          style: BorderStyle.solid,
          color: Colors.black,
          width: 3,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(3)),
        gapPadding: 8,
        borderSide: BorderSide(
          style: BorderStyle.solid,
          color: Colors.black,
          width: 4,
        ),
      ),
    ),
    colorScheme: ColorScheme.light(),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        shape: const WidgetStatePropertyAll(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(3))),
        ),
        textStyle: WidgetStateProperty.resolveWith(
          (states) {
            return const TextStyle(color: Colors.white);
          },
        ),
        backgroundColor: WidgetStateProperty.resolveWith(
          (states) {
            if (states.contains(WidgetState.pressed)) {
              return Colors.grey.shade600;
            }
            return Colors.grey.shade900;
          },
        ),
      ),
    ),
  );

  static final darkTheme = ThemeData(
    primaryColor: Colors.grey[850],
    scaffoldBackgroundColor: Colors.grey[900],
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
      color: Colors.grey[850],
    ),
    colorScheme: ColorScheme.dark(),
  );
}
