import 'package:flutter/material.dart';

const forest = Color(0xFF174B3A);
const leaf = Color(0xFF2F7658);
const ink = Color(0xFF202A24);
const muted = Color(0xFF778078);
const paper = Color(0xFFF5F6F0);

ThemeData buildAppTheme() => ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: paper,
  colorScheme: ColorScheme.fromSeed(seedColor: forest, primary: forest, surface: paper),
  textTheme: const TextTheme(
    headlineMedium: TextStyle(color: ink, fontSize: 32, fontWeight: FontWeight.w800, height: 1.08, letterSpacing: -1),
    titleLarge: TextStyle(color: ink, fontSize: 20, fontWeight: FontWeight.w700),
    bodyMedium: TextStyle(color: muted, fontSize: 14),
  ),
);
