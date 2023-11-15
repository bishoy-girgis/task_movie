import 'dart:ui';

import 'package:flutter/material.dart';

final appTheme = ThemeData(
  scaffoldBackgroundColor: const Color(0XFF121312),
  primaryColor: const Color(0XFFFFBB3B), // yellow
  accentColor: const Color(0XFF282A28), // grey
  backgroundColor: const Color(0XFF121312),
  textTheme: const TextTheme(
    bodySmall: TextStyle(
      color: Color(0XFFB5B4B4),
      fontSize: 12,
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: TextStyle(
      color: Color(0XFFCBCBCB),
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),
    bodyLarge: TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    headlineMedium: TextStyle(
      color: Colors.white,
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
  ),
);
