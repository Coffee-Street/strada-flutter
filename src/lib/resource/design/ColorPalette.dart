import 'package:flutter/material.dart';

class MainColorPalette {
  MainColorPalette._(); // this basically makes it so you can instantiate this class

  static const MaterialColor primaryColor = const MaterialColor(
    0xff0047bb,
    const <int, Color>{
      50: const Color(0x0f0047bb),
      100: const Color(0x1f0047bb),
      200: const Color(0x2f0047bb),
      300: const Color(0x3f0047bb),
      400: const Color(0x4f0047bb),
      500: const Color(0x5f0047bb),
      600: const Color(0x6f0047bb),
      700: const Color(0x7f0047bb),
      800: const Color(0x8f0047bb),
      900: const Color(0x9f0047bb),
    },
  );

  static const MaterialColor subColor = const MaterialColor(
    0xffd6d2d4,
    const <int, Color>{
      50: const Color(0x0fd6d2d4),
      100: const Color(0x1fd6d2d4),
      200: const Color(0x2fd6d2d4),
      300: const Color(0x3fd6d2d4),
      400: const Color(0x4fd6d2d4),
      500: const Color(0x5fd6d2d4),
      600: const Color(0x6fd6d2d4),
      700: const Color(0x7fd6d2d4),
      800: const Color(0x8fd6d2d4),
      900: const Color(0x9fd6d2d4),
    },
  );

  static const MaterialColor monoWhite = const MaterialColor(0xffffffff, {},);
  static const MaterialColor monoBlack = const MaterialColor(0xff333333, {},);
  static const MaterialColor monoDarkGray = const MaterialColor(0xff888888, {},);
  static const MaterialColor monoGray = const MaterialColor(0xffdddddd, {},);
}