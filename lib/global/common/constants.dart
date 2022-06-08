import 'package:flutter/material.dart';

// Colors
const cPrimary = Color(0xFF464C6E);
const cPrimaryLight = Color(0xFF5F6791);
const cPrimaryDark = Color(0xFF272B45);
const cAccent = Color(0xFF855CFF);
const cText = Color(0xFFD2D6EF);

// Gradient colors
const cPrimaryGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    cPrimary,
    cPrimaryDark,
  ],
);

const cPrimaryDarkGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    cPrimaryLight,
    cPrimaryDark,
  ],
);

// Text styles
const heading = TextStyle(
  color: cText,
  fontSize: 32,
);
