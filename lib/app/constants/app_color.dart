import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF1E3A8A);
  static const Color accent = Color(0xFF38BDF8);
  static const Color secondary = Color(0xFF64748B);
  static const Color backgroundTop = Color(0xFFDBEAFE);  // Light Blue
  static const Color backgroundBottom = Color(0xFFFFFFFF); // White
  static const Color backgroundAlt = Color(0xFFF7FBFF);
// Soft pastel blue alternative
  static const Color card = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF475569);
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);

  // 🌈 Gradient for background use
  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [backgroundTop, backgroundBottom],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}