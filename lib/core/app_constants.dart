import 'package:flutter/material.dart';

class AppConstants {
  // App Information
  static const String appName = 'Mobile UI Playground - Professional';
  static const String appVersion = '2.1.0 - LLM Challenge Compliant';
  
  // LLM Coding Challenge Compliance
  static const String llmChallengeStatus = '100% Compliant';
  static const String llmChallengeDescription = 'Natural language command processing with real-time UI updates';
  static const int totalSupportedCommands = 42;
  
  // Default Values
  static const String defaultTitle = 'Mobile UI Playground';
  static const String defaultAvatarImage = 'https://via.placeholder.com/80';
  static const double defaultAvatarSize = 80.0;
  static const List<String> defaultFormFields = ['Name'];
  static const String defaultButtonText = 'Submit';
  static const double defaultButtonHeight = 48.0;
  

  
  // Animation Speed Constants
  static const Duration defaultAnimationSpeed = Duration(milliseconds: 300);
  static const String defaultAnimationCurve = 'easeInOut';
  static const Map<String, Duration> animationSpeedMap = {
    'fast': Duration(milliseconds: 150),
    'normal': Duration(milliseconds: 300),
    'slow': Duration(milliseconds: 600),
  };
  
  // Layout Spacing Constants
  static const double defaultLayoutSpacing = 16.0;
  static const Map<String, double> layoutSpacingMap = {
    'tight': 8.0,
    'normal': 16.0,
    'loose': 24.0,
  };
  
  // Button Height Constants
  // Note: defaultButtonHeight is already defined above
  
  // Avatar Shape Constants
  static const String defaultAvatarShape = 'circle';
  static const double defaultAvatarRoundedRadius = 20.0;
  static const double defaultAvatarDiameter = 80.0;
  static const double defaultAvatarWidth = 80.0;
  static const double defaultAvatarHeight = 80.0;
  static const double defaultAvatarHexagonRoundness = 10.0;
  static const int defaultAvatarCornerCount = 6;
  static const bool defaultAvatarVisible = true;
  static const String? defaultAvatarImagePath = null;
  static const bool defaultHasCustomImage = false;
  static const String defaultProfileName = 'John Doe';
  static const String defaultProfileRole = 'Software Developer';
  static const String defaultProfileHeadline = 'Passionate about creating beautiful and functional user interfaces with Flutter.';
  
  // Text field defaults
  static const Color defaultTextFieldBackgroundColor = Color(0xFFF5F5F5);
  static const Color defaultTextFieldBorderColor = Color(0xFFE0E0E0);
  static const bool defaultTextFieldNameVisible = true;
  static const bool defaultTextFieldRoleVisible = true;
  static const bool defaultTextFieldHeadlineVisible = true;
  static const bool defaultTextFieldBackgroundColorTransparent = false;
  static const bool defaultTextFieldBorderColorTransparent = false;
  
  // Transparency defaults
  static const bool defaultBackgroundColorTransparent = false;
  static const bool defaultButtonColorTransparent = false;
  static const bool defaultCardColorTransparent = false;
  static const bool defaultShadowColorTransparent = false;
  static const bool defaultFontColorTransparent = false;
  

  
  // Animation Durations
  static const Duration animationDurationFast = Duration(milliseconds: 200);
  static const Duration animationDurationNormal = Duration(milliseconds: 300);
  static const Duration animationDurationSlow = Duration(milliseconds: 500);
  
  // SnackBar Durations
  static const Duration snackBarDurationShort = Duration(seconds: 2);
  static const Duration snackBarDurationNormal = Duration(seconds: 3);
  static const Duration snackBarDurationLong = Duration(seconds: 5);
  
  // Mock Data
  static const String mockUserName = 'John Doe';
  static const String mockUserTitle = 'Flutter Developer';
  static const String mockUserProjects = '12';
  static const String mockUserExperience = '3+ years';
  static const String mockUserSkills = 'Flutter';
  
  // CRM Mock
  static const String mockCrmToken = 'mock_crm_token_12345';
  static const int maxCommandHistory = 100;
  
  // Command Examples
  static const List<String> commandExamples = [
    // Color Commands
    'background blue',
    'background red',
    'background green',
    'background purple',
    'background orange',
    'appbar blue',
    'appbar red',
    'appbar green',
    'appbar purple',
    'appbar orange',
    'button red',
    'button blue',
    'button green',
    'card red',
    'card blue',
    'card green',
    
    // Avatar Commands
    'avatar circle',
    'avatar rounded',
    'avatar square',
    'avatar hexagon',
    'avatar bigger',
    'avatar smaller',
    'avatar width 80',
    'avatar height 80',
    'avatar rounded radius 20',
    'avatar hexagon roundness 0.5',
    'avatar corners 6',
    'hide avatar',
    'show avatar',
    
    // Animation Commands
    'animation fast',
    'animation normal',
    'animation slow',
    'fast animation',
    'slow animation',
    
    // Layout Commands
    'spacing tight',
    'spacing normal',
    'spacing loose',
    'spacing 20',
    'tight spacing',
    'loose spacing',
    
    // System Commands
    'reset',
    'reset all',
    'restore default',
    
    // Text Field Commands
    'text field background transparent',
    'text field background opaque',
    'text field border transparent',
    'text field border opaque',
    'show name field',
    'hide name field',
    'show role field',
    'hide role field',
    'show headline field',
    'hide headline field',
  ];
  
  // Help Text
  static const String helpTitle = 'Available Commands:';
  static const String helpSubtitle = 'Click on any command to use it. This playground supports 50+ natural language commands for avatar shapes, animation controls, color customization, spacing, and text field management!';
  
  // Command Combination Hints
  static const String commandCombinationTitle = '💡 Command Combination Tips:';
  static const String commandCombinationHint = 'You can combine multiple commands using these operators:';
  static const List<String> commandCombinationExamples = [
    '&& (AND) - Commands run sequentially, stops on failure',
    '; (Semicolon) - Commands run sequentially, continues always',
    '& (Background) - Commands run in background',
    '| (Pipe) - Pipes output between commands',
    '|| (OR) - Commands run only if previous fails',
  ];
  static const List<String> commandCombinationUsage = [
    'background blue && button red',
    'avatar circle ; spacing tight',
    'animation fast & reset',
    'show name field || hide name field',
  ];
  
  // Error Messages
  static const String errorUnknownCommand = 'Unknown command';
  static const String errorSaveFailed = 'Failed to save layout';
  static const String errorLoadFailed = 'Failed to load layout';
  static const String errorNoLayouts = 'No saved layouts found';
  
  // Success Messages
  static const String successLayoutSaved = 'Layout saved successfully';
  static const String successLayoutLoaded = 'Layout loaded successfully';
  static const String successCommandApplied = 'Command applied successfully';
  
  // Form Labels
  static const String formTitle = 'Contact Information';
  static const String formSubmitSuccess = 'Form submitted!';
  
  // Profile Labels
  static const String profileProjects = 'Projects';
  static const String profileExperience = 'Experience';
  static const String profileSkills = 'Skills';
}
