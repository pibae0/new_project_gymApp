import 'package:flutter/material.dart';

const cardBackgroundColor = Color(0xFF21222D);
const primartColor = Color(0xFF2697FF);
const secondaryColor = Color(0xFFFFFFFF);
const backgroundColors = Color(0xFF15131C);
const backgroundMenuColors = Color.fromARGB(255, 35, 33, 46);
const selectionColor = Color.fromARGB(255, 14, 15, 15);

class AppTheme {
  static const Color dark = Color(0xFF1E1E1E);
  static const Color medium = Color(0x7C232020);
  static const Color accent = Color(0xFFFFA500);
  static const Color textBox = Color(0xFF968F6D);

  static const Color disabledBackgroundColor = Colors.black12;
  static const Color disabledForegroundColor = Colors.white12;

  static const TextStyle inputStyle =
      TextStyle(color: Colors.white, fontSize: 18);
  static const TextStyle hintStyle = TextStyle(color: textBox);
  static const TextStyle splashStyle = TextStyle(
      color: accent,
      fontSize: 50,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.w300);
}
