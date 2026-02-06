import 'package:flutter/material.dart';
import 'dart:ui';

class AuthStyles {
  // Panel/Glassmorphism styles
  static const double panelBorderRadius = 16;
  static const double panelPadding = 24;
  static const double panelBlurSigma = 10;
  static const double panelOpacity = 0.6;

  // Input field styles
  static const double inputBorderRadius = 12;
  static const Color inputFillColor = Colors.white;
  static const Color inputTextColor = Colors.black87;
  static const Color inputLabelColor = Colors.black87;

  // Text styles
  static const TextStyle hintTextStyle = TextStyle(
    color: Colors.black,
    fontSize: 14,
  );

  // Link/Interactive text colors
  static const Color linkColor = Color(0xFF8B0000); // Dark red

  // Background styles
  static const double backgroundBlurSigma = 1.5;
  static const double backgroundOverlayOpacity = 0.5;

  // Helper methods
  static BoxDecoration panelDecoration = BoxDecoration(
    color: Colors.white.withOpacity(panelOpacity),
    borderRadius: BorderRadius.circular(panelBorderRadius),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.2),
        blurRadius: 20,
        offset: const Offset(0, 10),
      ),
    ],
  );

  static InputDecoration inputDecoration({required String label}) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: inputLabelColor),
      filled: true,
      fillColor: inputFillColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(inputBorderRadius),
      ),
    );
  }
}
