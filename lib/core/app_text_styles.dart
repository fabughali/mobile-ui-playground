import 'package:flutter/material.dart';

/// Centralized const TextStyle objects for better performance
class AppTextStyles {
  // Title styles
  static const TextStyle titleBold = TextStyle(
    fontWeight: FontWeight.bold,
  );
  
  static const TextStyle titleMediumBold = TextStyle(
    fontWeight: FontWeight.bold,
  );
  
  // Button styles
  static const TextStyle buttonBold = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  
  // Form field styles
  static const TextStyle formFieldMedium = TextStyle(
    fontWeight: FontWeight.w500,
  );
  
  // Dialog styles
  static const TextStyle dialogBody = TextStyle();
  static const TextStyle dialogTitle = TextStyle();
}
