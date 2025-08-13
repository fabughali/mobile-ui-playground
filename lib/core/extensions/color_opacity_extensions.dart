import 'package:flutter/material.dart';

extension ColorOpacityExtensions on Color {
  /// Returns a color with the given alpha value
  /// Use this instead of deprecated withOpacity()
  Color withAlpha(double alpha) {
    assert(alpha >= 0.0 && alpha <= 1.0);
    return Color.fromARGB((alpha * 255).round(), red, green, blue);
  }

  /// Returns a color with the given alpha value (0-255)
  Color withAlphaValue(int alpha) {
    assert(alpha >= 0 && alpha <= 255);
    return Color.fromARGB(alpha, red, green, blue);
  }

  /// Returns a color with 10% opacity
  Color get opacity10 => withAlpha(0.1);

  /// Returns a color with 20% opacity
  Color get opacity20 => withAlpha(0.2);

  /// Returns a color with 30% opacity
  Color get opacity30 => withAlpha(0.3);

  /// Returns a color with 40% opacity
  Color get opacity40 => withAlpha(0.4);

  /// Returns a color with 50% opacity
  Color get opacity50 => withAlpha(0.5);

  /// Returns a color with 60% opacity
  Color get opacity60 => withAlpha(0.6);

  /// Returns a color with 70% opacity
  Color get opacity70 => withAlpha(0.7);

  /// Returns a color with 80% opacity
  Color get opacity80 => withAlpha(0.8);

  /// Returns a color with 90% opacity
  Color get opacity90 => withAlpha(0.9);
}
