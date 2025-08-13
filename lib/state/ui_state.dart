import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/ui_instruction.dart';
import '../core/app_constants.dart';
import '../core/app_colors.dart';

part 'ui_state.g.dart';

@riverpod
class UIState extends _$UIState {
  @override
  UIStateData build() {
    return const UIStateData(
      backgroundColor: AppColors.defaultBackgroundColor,
      backgroundColorTransparent: AppConstants.defaultBackgroundColorTransparent,
      appBarColor: AppColors.defaultAppBarColor,
      appBarColorTransparent: AppConstants.defaultBackgroundColorTransparent,
      buttonColor: AppColors.defaultButtonColor,
      buttonColorTransparent: AppConstants.defaultButtonColorTransparent,
      cardColor: AppColors.defaultCardColor,
      cardColorTransparent: AppConstants.defaultCardColorTransparent,
      shadowColor: AppColors.defaultShadowColor,
      shadowColorTransparent: AppConstants.defaultShadowColorTransparent,
      fontColor: AppColors.defaultFontColor,
      fontColorTransparent: AppConstants.defaultFontColorTransparent,
      animationSpeed: AppConstants.defaultAnimationSpeed,
      animationCurve: AppConstants.defaultAnimationCurve,
      layoutSpacing: AppConstants.defaultLayoutSpacing,
      avatarShape: AppConstants.defaultAvatarShape,
      avatarRoundedRadius: AppConstants.defaultAvatarRoundedRadius,
      avatarDiameter: AppConstants.defaultAvatarDiameter,
      avatarWidth: AppConstants.defaultAvatarWidth,
      avatarHeight: AppConstants.defaultAvatarHeight,
      avatarHexagonRoundness: AppConstants.defaultAvatarHexagonRoundness,
      avatarCornerCount: AppConstants.defaultAvatarCornerCount,
      avatarVisible: AppConstants.defaultAvatarVisible,
      avatarImagePath: AppConstants.defaultAvatarImagePath,
      hasCustomImage: AppConstants.defaultHasCustomImage,
      profileName: AppConstants.defaultProfileName,
      profileRole: AppConstants.defaultProfileRole,
      profileHeadline: AppConstants.defaultProfileHeadline,
      textFieldBackgroundColor: AppConstants.defaultTextFieldBackgroundColor,
      textFieldBorderColor: AppConstants.defaultTextFieldBorderColor,
      textFieldNameVisible: AppConstants.defaultTextFieldNameVisible,
      textFieldRoleVisible: AppConstants.defaultTextFieldRoleVisible,
      textFieldHeadlineVisible: AppConstants.defaultTextFieldHeadlineVisible,
      textFieldBackgroundColorTransparent: AppConstants.defaultTextFieldBackgroundColorTransparent,
      textFieldBorderColorTransparent: AppConstants.defaultTextFieldBorderColorTransparent,
    );
  }

  // Apply UI instruction
  void applyInstruction(UIInstruction instruction) {
    final currentState = state;
    
    switch (instruction.component) {
      case 'title':
        state = _applyTitleInstruction(currentState, instruction);
        break;
      case 'background':
        state = _applyBackgroundInstruction(currentState, instruction);
        break;
      case 'appBar':
        state = _applyAppBarInstruction(currentState, instruction);
        break;
      case 'avatar':
        state = _applyAvatarInstruction(currentState, instruction);
        break;
      case 'form':
        state = _applyFormInstruction(currentState, instruction);
        break;
      case 'button':
        state = _applyButtonInstruction(currentState, instruction);
        break;
      case 'card':
        state = _applyCardInstruction(currentState, instruction);
        break;
      case 'font':
        state = _applyFontInstruction(currentState, instruction);
        break;
      case 'shadow':
        state = _applyShadowInstruction(currentState, instruction);
        break;
      case 'all':
        if (instruction.property == 'reset') {
          reset();
        }
        break;
      // Phase 1 Enhancement Instructions
      case 'animation':
        state = _applyAnimationInstruction(currentState, instruction);
        break;
      case 'layout':
        state = _applyLayoutInstruction(currentState, instruction);
        break;
    }
  }

  UIStateData _applyTitleInstruction(
    UIStateData currentState,
    UIInstruction instruction,
  ) {
    // Title instruction handling removed as title properties are no longer part of UIStateData
    return currentState;
  }

  UIStateData _applyBackgroundInstruction(
    UIStateData currentState,
    UIInstruction instruction,
  ) {
    switch (instruction.property) {
      case 'color':
        if (instruction.value is Color) {
          return currentState.copyWith(backgroundColor: instruction.value);
        }
        break;
      case 'transparent':
        if (instruction.value is bool) {
          return currentState.copyWith(backgroundColorTransparent: instruction.value);
        }
        break;

    }
    return currentState;
  }

  UIStateData _applyAppBarInstruction(
    UIStateData currentState,
    UIInstruction instruction,
  ) {
    switch (instruction.property) {
      case 'color':
        if (instruction.value is Color) {
          return currentState.copyWith(appBarColor: instruction.value);
        }
        break;
      case 'transparent':
        if (instruction.value is bool) {
          return currentState.copyWith(appBarColorTransparent: instruction.value);
        }
        break;
    }
    return currentState;
  }

  UIStateData _applyAvatarInstruction(
    UIStateData currentState,
    UIInstruction instruction,
  ) {
    switch (instruction.property) {
      // Phase 1 Enhancement: Avatar Shape
      case 'shape':
        if (instruction.value is String) {
          return currentState.copyWith(avatarShape: instruction.value);
        }
        break;
      case 'roundedRadius':
        if (instruction.value is double) {
          return currentState.copyWith(avatarRoundedRadius: instruction.value);
        }
        break;
      // New avatar dimension controls
      case 'diameter':
        if (instruction.value is double) {
          return currentState.copyWith(avatarDiameter: instruction.value);
        }
        break;
      case 'width':
        if (instruction.value is double) {
          return currentState.copyWith(avatarWidth: instruction.value);
        }
        break;
      case 'height':
        if (instruction.value is double) {
          return currentState.copyWith(avatarHeight: instruction.value);
        }
        break;
      case 'hexagonRoundness':
        if (instruction.value is double) {
          return currentState.copyWith(avatarHexagonRoundness: instruction.value);
        }
        break;
      case 'cornerCount':
        if (instruction.value is int) {
          return currentState.copyWith(avatarCornerCount: instruction.value);
        }
        break;
      case 'visible':
        if (instruction.value is bool) {
          return currentState.copyWith(avatarVisible: instruction.value);
        }
        break;
      case 'image':
        if (instruction.value is String) {
          final newState = currentState.copyWith(
            avatarImagePath: instruction.value,
            hasCustomImage: true, // Automatically set hasCustomImage to true when image is provided
          );
          return newState;
        }
        break;
      case 'hasCustomImage':
        if (instruction.value is bool) {
          return currentState.copyWith(hasCustomImage: instruction.value);
        }
        break;
      case 'deleteImage':
        return currentState.copyWith(
          avatarImagePath: null,
          hasCustomImage: false,
        );
      case 'profileName':
        if (instruction.value is String) {
          return currentState.copyWith(profileName: instruction.value);
        }
        break;
      case 'profileRole':
        if (instruction.value is String) {
          return currentState.copyWith(profileRole: instruction.value);
        }
        break;
      case 'profileHeadline':
        if (instruction.value is String) {
          return currentState.copyWith(profileHeadline: instruction.value);
        }
        break;
      case 'textFieldBackgroundColor':
        if (instruction.value is Color) {
          return currentState.copyWith(textFieldBackgroundColor: instruction.value);
        }
        break;
      case 'textFieldBorderColor':
        if (instruction.value is Color) {
          return currentState.copyWith(textFieldBorderColor: instruction.value);
        }
        break;
      case 'textFieldNameVisible':
        if (instruction.value is bool) {
          return currentState.copyWith(textFieldNameVisible: instruction.value);
        }
        break;
      case 'textFieldRoleVisible':
        if (instruction.value is bool) {
          return currentState.copyWith(textFieldRoleVisible: instruction.value);
        }
        break;
      case 'textFieldHeadlineVisible':
        if (instruction.value is bool) {
          return currentState.copyWith(textFieldHeadlineVisible: instruction.value);
        }
        break;
      case 'textFieldBackgroundColorTransparent':
        if (instruction.value is bool) {
          final newState = currentState.copyWith(textFieldBackgroundColorTransparent: instruction.value);
          return newState;
        }
        break;
      case 'textFieldBorderColorTransparent':
        if (instruction.value is bool) {
          final newState = currentState.copyWith(textFieldBorderColorTransparent: instruction.value);
          return newState;
        }
        break;
    }
    return currentState;
  }

  UIStateData _applyFormInstruction(
    UIStateData currentState,
    UIInstruction instruction,
  ) {
    // Form instruction handling removed as form properties are no longer part of UIStateData
    return currentState;
  }

  UIStateData _applyButtonInstruction(
    UIStateData currentState,
    UIInstruction instruction,
  ) {
    switch (instruction.property) {
      case 'color':
        if (instruction.value is Color) {
          return currentState.copyWith(buttonColor: instruction.value);
        }
        break;
      case 'transparent':
        if (instruction.value is bool) {
          return currentState.copyWith(buttonColorTransparent: instruction.value);
        }
        break;
      case 'height':
        if (instruction.value is double) {
          return currentState;
        }
        break;
    }
    return currentState;
  }

  UIStateData _applyCardInstruction(
    UIStateData currentState,
    UIInstruction instruction,
  ) {
    switch (instruction.property) {
      case 'color':
        if (instruction.value is Color) {
          return currentState.copyWith(cardColor: instruction.value);
        }
        break;
      case 'transparent':
        if (instruction.value is bool) {
          return currentState.copyWith(cardColorTransparent: instruction.value);
        }
        break;
    }
    return currentState;
  }

  UIStateData _applyFontInstruction(
    UIStateData currentState,
    UIInstruction instruction,
  ) {
    switch (instruction.property) {
      case 'color':
        if (instruction.value is Color) {
          final newState = currentState.copyWith(fontColor: instruction.value);
          return newState;
        }
        break;
      case 'transparent':
        if (instruction.value is bool) {
          final newState = currentState.copyWith(fontColorTransparent: instruction.value);
          return newState;
        }
        break;
    }
    return currentState;
  }

  UIStateData _applyShadowInstruction(
    UIStateData currentState,
    UIInstruction instruction,
  ) {
    switch (instruction.property) {
      case 'color':
        if (instruction.value is Color) {
          return currentState.copyWith(shadowColor: instruction.value);
        }
        break;
      case 'transparent':
        if (instruction.value is bool) {
          return currentState.copyWith(shadowColorTransparent: instruction.value);
        }
        break;
    }
    return currentState;
  }

  // Phase 1 Enhancement Methods
  UIStateData _applyAnimationInstruction(
    UIStateData currentState,
    UIInstruction instruction,
  ) {
    switch (instruction.property) {
      case 'speed':
        if (instruction.value is Duration) {
          return currentState.copyWith(animationSpeed: instruction.value);
        }
        break;
      case 'curve':
        if (instruction.value is String) {
          return currentState.copyWith(animationCurve: instruction.value);
        }
        break;
    }
    return currentState;
  }

  UIStateData _applyLayoutInstruction(
    UIStateData currentState,
    UIInstruction instruction,
  ) {
    switch (instruction.property) {
      case 'spacing':
        if (instruction.value is double) {
          return currentState.copyWith(layoutSpacing: instruction.value);
        } else if (instruction.value is String) {
          final spacing = instruction.value;
          final spacingValue = AppConstants.layoutSpacingMap[spacing];
          if (spacingValue != null) {
            return currentState.copyWith(layoutSpacing: spacingValue);
          }
        }
        break;
    }
    return currentState;
  }

  // Reset to default state
  void reset() {
    state = const UIStateData(
      backgroundColor: AppColors.defaultBackgroundColor,
      backgroundColorTransparent: AppConstants.defaultBackgroundColorTransparent,
      appBarColor: AppColors.defaultBackgroundColor,
      appBarColorTransparent: AppConstants.defaultBackgroundColorTransparent,
      buttonColor: AppColors.defaultButtonColor,
      buttonColorTransparent: AppConstants.defaultButtonColorTransparent,
      cardColor: AppColors.defaultCardColor,
      cardColorTransparent: AppConstants.defaultCardColorTransparent,
      shadowColor: AppColors.defaultShadowColor,
      shadowColorTransparent: AppConstants.defaultShadowColorTransparent,
      fontColor: AppColors.defaultFontColor,
      fontColorTransparent: AppConstants.defaultFontColorTransparent,
      animationSpeed: AppConstants.defaultAnimationSpeed,
      animationCurve: AppConstants.defaultAnimationCurve,
      layoutSpacing: AppConstants.defaultLayoutSpacing,
      avatarShape: AppConstants.defaultAvatarShape,
      avatarRoundedRadius: AppConstants.defaultAvatarRoundedRadius,
      avatarDiameter: AppConstants.defaultAvatarDiameter,
      avatarWidth: AppConstants.defaultAvatarWidth,
      avatarHeight: AppConstants.defaultAvatarHeight,
      avatarHexagonRoundness: AppConstants.defaultAvatarHexagonRoundness,
      avatarCornerCount: AppConstants.defaultAvatarCornerCount,
      avatarVisible: AppConstants.defaultAvatarVisible,
      avatarImagePath: AppConstants.defaultAvatarImagePath,
      hasCustomImage: AppConstants.defaultHasCustomImage,
      profileName: AppConstants.defaultProfileName,
      profileRole: AppConstants.defaultProfileRole,
      profileHeadline: AppConstants.defaultProfileHeadline,
      textFieldBackgroundColor: AppConstants.defaultTextFieldBackgroundColor,
      textFieldBorderColor: AppConstants.defaultTextFieldBorderColor,
      textFieldNameVisible: AppConstants.defaultTextFieldNameVisible,
      textFieldRoleVisible: AppConstants.defaultTextFieldRoleVisible,
      textFieldHeadlineVisible: AppConstants.defaultTextFieldHeadlineVisible,
      textFieldBackgroundColorTransparent: AppConstants.defaultTextFieldBackgroundColorTransparent,
      textFieldBorderColorTransparent: AppConstants.defaultTextFieldBorderColorTransparent,
    );
  }

  // Load state from JSON from CRM
  void fromJson(Map<String, dynamic> json) {
    state = UIStateData.fromJson(json);
  }


}

// Immutable state data class
class UIStateData {
  final Color backgroundColor;
  final bool backgroundColorTransparent;
  final Color appBarColor;
  final bool appBarColorTransparent;
  final Color buttonColor;
  final bool buttonColorTransparent;
  final Color cardColor;
  final bool cardColorTransparent;
  final Color shadowColor;
  final bool shadowColorTransparent;
  final Color fontColor;
  final bool fontColorTransparent;
  final Duration animationSpeed;
  final String animationCurve;
  final double layoutSpacing;
  final String avatarShape;
  final double avatarRoundedRadius;
  final double avatarDiameter;
  final double avatarWidth;
  final double avatarHeight;
  final double avatarHexagonRoundness;
  final int avatarCornerCount;
  final bool avatarVisible;
  final String? avatarImagePath;
  final bool hasCustomImage;
  final String profileName;
  final String profileRole;
  final String profileHeadline;
  final Color textFieldBackgroundColor;
  final Color textFieldBorderColor;
  final bool textFieldNameVisible;
  final bool textFieldRoleVisible;
  final bool textFieldHeadlineVisible;
  final bool textFieldBackgroundColorTransparent;
  final bool textFieldBorderColorTransparent;


  const UIStateData({
    required this.backgroundColor,
    required this.backgroundColorTransparent,
    required this.appBarColor,
    required this.appBarColorTransparent,
    required this.buttonColor,
    required this.buttonColorTransparent,
    required this.cardColor,
    required this.cardColorTransparent,
    required this.shadowColor,
    required this.shadowColorTransparent,
    required this.fontColor,
    required this.fontColorTransparent,
    required this.animationSpeed,
    required this.animationCurve,
    required this.layoutSpacing,
    required this.avatarShape,
    required this.avatarRoundedRadius,
    required this.avatarDiameter,
    required this.avatarWidth,
    required this.avatarHeight,
    required this.avatarHexagonRoundness,
    required this.avatarCornerCount,
    required this.avatarVisible,
    required this.avatarImagePath,
    required this.hasCustomImage,
    required this.profileName,
    required this.profileRole,
    required this.profileHeadline,
    required this.textFieldBackgroundColor,
    required this.textFieldBorderColor,
    required this.textFieldNameVisible,
    required this.textFieldRoleVisible,
    required this.textFieldHeadlineVisible,
    required this.textFieldBackgroundColorTransparent,
    required this.textFieldBorderColorTransparent,
  });

  UIStateData copyWith({
    Color? backgroundColor,
    bool? backgroundColorTransparent,
    Color? appBarColor,
    bool? appBarColorTransparent,
    Color? buttonColor,
    bool? buttonColorTransparent,
    Color? cardColor,
    bool? cardColorTransparent,
    Color? shadowColor,
    bool? shadowColorTransparent,
    Color? fontColor,
    bool? fontColorTransparent,
    Duration? animationSpeed,
    String? animationCurve,
    double? layoutSpacing,
    String? avatarShape,
    double? avatarRoundedRadius,
    double? avatarDiameter,
    double? avatarWidth,
    double? avatarHeight,
    double? avatarHexagonRoundness,
    int? avatarCornerCount,
    bool? avatarVisible,
    String? avatarImagePath,
    bool? hasCustomImage,
    String? profileName,
    String? profileRole,
    String? profileHeadline,
    Color? textFieldBackgroundColor,
    Color? textFieldBorderColor,
    bool? textFieldNameVisible,
    bool? textFieldRoleVisible,
    bool? textFieldHeadlineVisible,
    bool? textFieldBackgroundColorTransparent,
    bool? textFieldBorderColorTransparent,
  }) {
    return UIStateData(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      backgroundColorTransparent: backgroundColorTransparent ?? this.backgroundColorTransparent,
      appBarColor: appBarColor ?? this.appBarColor,
      appBarColorTransparent: appBarColorTransparent ?? this.appBarColorTransparent,
      buttonColor: buttonColor ?? this.buttonColor,
      buttonColorTransparent: buttonColorTransparent ?? this.buttonColorTransparent,
      cardColor: cardColor ?? this.cardColor,
      cardColorTransparent: cardColorTransparent ?? this.cardColorTransparent,
      shadowColor: shadowColor ?? this.shadowColor,
      shadowColorTransparent: shadowColorTransparent ?? this.shadowColorTransparent,
      fontColor: fontColor ?? this.fontColor,
      fontColorTransparent: fontColorTransparent ?? this.fontColorTransparent,
      animationSpeed: animationSpeed ?? this.animationSpeed,
      animationCurve: animationCurve ?? this.animationCurve,
      layoutSpacing: layoutSpacing ?? this.layoutSpacing,
      avatarShape: avatarShape ?? this.avatarShape,
      avatarRoundedRadius: avatarRoundedRadius ?? this.avatarRoundedRadius,
      avatarDiameter: avatarDiameter ?? this.avatarDiameter,
      avatarWidth: avatarWidth ?? this.avatarWidth,
      avatarHeight: avatarHeight ?? this.avatarHeight,
      avatarHexagonRoundness: avatarHexagonRoundness ?? this.avatarHexagonRoundness,
      avatarCornerCount: avatarCornerCount ?? this.avatarCornerCount,
      avatarVisible: avatarVisible ?? this.avatarVisible,
      avatarImagePath: avatarImagePath ?? this.avatarImagePath,
      hasCustomImage: hasCustomImage ?? this.hasCustomImage,
      profileName: profileName ?? this.profileName,
      profileRole: profileRole ?? this.profileRole,
      profileHeadline: profileHeadline ?? this.profileHeadline,
      textFieldBackgroundColor: textFieldBackgroundColor ?? this.textFieldBackgroundColor,
      textFieldBorderColor: textFieldBorderColor ?? this.textFieldBorderColor,
      textFieldNameVisible: textFieldNameVisible ?? this.textFieldNameVisible,
      textFieldRoleVisible: textFieldRoleVisible ?? this.textFieldRoleVisible,
      textFieldHeadlineVisible: textFieldHeadlineVisible ?? this.textFieldHeadlineVisible,
      textFieldBackgroundColorTransparent: textFieldBackgroundColorTransparent ?? this.textFieldBackgroundColorTransparent,
      textFieldBorderColorTransparent: textFieldBorderColorTransparent ?? this.textFieldBorderColorTransparent,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UIStateData &&
        other.backgroundColor == backgroundColor &&
        other.backgroundColorTransparent == backgroundColorTransparent &&
        other.appBarColor == appBarColor &&
        other.appBarColorTransparent == appBarColorTransparent &&
        other.buttonColor == buttonColor &&
        other.buttonColorTransparent == buttonColorTransparent &&
        other.cardColor == cardColor &&
        other.cardColorTransparent == cardColorTransparent &&
        other.shadowColor == shadowColor &&
        other.shadowColorTransparent == shadowColorTransparent &&
        other.fontColor == fontColor &&
        other.fontColorTransparent == fontColorTransparent &&
        other.animationSpeed == animationSpeed &&
        other.animationCurve == animationCurve &&
        other.layoutSpacing == layoutSpacing &&
        other.avatarShape == avatarShape &&
        other.avatarRoundedRadius == avatarRoundedRadius &&
        other.avatarDiameter == avatarDiameter &&
        other.avatarWidth == avatarWidth &&
        other.avatarHeight == avatarHeight &&
        other.avatarHexagonRoundness == avatarHexagonRoundness &&
        other.avatarCornerCount == avatarCornerCount &&
        other.avatarVisible == avatarVisible &&
        other.avatarImagePath == avatarImagePath &&
        other.hasCustomImage == hasCustomImage &&
        other.profileName == profileName &&
        other.profileRole == profileRole &&
        other.profileHeadline == profileHeadline &&
        other.textFieldBackgroundColor == textFieldBackgroundColor &&
        other.textFieldBorderColor == textFieldBorderColor &&
        other.textFieldNameVisible == textFieldNameVisible &&
        other.textFieldRoleVisible == textFieldRoleVisible &&
        other.textFieldHeadlineVisible == textFieldHeadlineVisible &&
        other.textFieldBackgroundColorTransparent == textFieldBackgroundColorTransparent &&
        other.textFieldBorderColorTransparent == textFieldBorderColorTransparent;
    }

  @override
  int get hashCode {
    return backgroundColor.hashCode ^
        backgroundColorTransparent.hashCode ^
        buttonColor.hashCode ^
        buttonColorTransparent.hashCode ^
        cardColor.hashCode ^
        cardColorTransparent.hashCode ^
        shadowColor.hashCode ^
        shadowColorTransparent.hashCode ^
        fontColor.hashCode ^
        fontColorTransparent.hashCode ^
        animationSpeed.hashCode ^
        animationCurve.hashCode ^
        layoutSpacing.hashCode ^
        avatarShape.hashCode ^
        avatarRoundedRadius.hashCode ^
        avatarDiameter.hashCode ^
        avatarWidth.hashCode ^
        avatarHeight.hashCode ^
        avatarHexagonRoundness.hashCode ^
        avatarCornerCount.hashCode ^
        avatarVisible.hashCode ^
        avatarImagePath.hashCode ^
        hasCustomImage.hashCode ^
        profileName.hashCode ^
        profileRole.hashCode ^
        profileHeadline.hashCode ^
        textFieldBackgroundColor.hashCode ^
        textFieldBorderColor.hashCode ^
        textFieldNameVisible.hashCode ^
        textFieldRoleVisible.hashCode ^
        textFieldHeadlineVisible.hashCode ^
                textFieldBackgroundColorTransparent.hashCode ^
        textFieldBorderColorTransparent.hashCode;
    }

  Map<String, dynamic> toJson() {
    return {
      'backgroundColor': backgroundColor.value,
      'backgroundColorTransparent': backgroundColorTransparent,
      'appBarColor': appBarColor.value,
      'appBarColorTransparent': appBarColorTransparent,
      'buttonColor': buttonColor.value,
      'buttonColorTransparent': buttonColorTransparent,
      'cardColor': cardColor.value,
      'cardColorTransparent': cardColorTransparent,
      'shadowColor': shadowColor.value,
      'shadowColorTransparent': shadowColorTransparent,
      'fontColor': fontColor.value,
      'fontColorTransparent': fontColorTransparent,
      'animationSpeed': animationSpeed.inMilliseconds,
      'animationCurve': animationCurve,
      'layoutSpacing': layoutSpacing,
      'avatarShape': avatarShape,
      'avatarRoundedRadius': avatarRoundedRadius,
      'avatarDiameter': avatarDiameter,
      'avatarWidth': avatarWidth,
      'avatarHeight': avatarHeight,
      'avatarHexagonRoundness': avatarHexagonRoundness,
      'avatarCornerCount': avatarCornerCount,
      'avatarVisible': avatarVisible,
      'avatarImagePath': avatarImagePath,
      'hasCustomImage': hasCustomImage,
      'profileName': profileName,
      'profileRole': profileRole,
      'profileHeadline': profileHeadline,
      'textFieldBackgroundColor': textFieldBackgroundColor.toARGB32(),
      'textFieldBorderColor': textFieldBorderColor.toARGB32(),
      'textFieldNameVisible': textFieldNameVisible,
      'textFieldRoleVisible': textFieldRoleVisible,
      'textFieldHeadlineVisible': textFieldHeadlineVisible,
      'textFieldBackgroundColorTransparent': textFieldBackgroundColorTransparent,
      'textFieldBorderColorTransparent': textFieldBorderColorTransparent,
    };
  }

  factory UIStateData.fromJson(Map<String, dynamic> json) {
    return UIStateData(
      backgroundColor: Color(json['backgroundColor'] as int),
      backgroundColorTransparent: json['backgroundColorTransparent'] as bool? ?? AppConstants.defaultBackgroundColorTransparent,
      appBarColor: Color(json['appBarColor'] as int? ?? AppColors.defaultBackgroundColor.value),
      appBarColorTransparent: json['appBarColorTransparent'] as bool? ?? AppConstants.defaultBackgroundColorTransparent,
      buttonColor: Color(json['buttonColor'] as int),
      buttonColorTransparent: json['buttonColorTransparent'] as bool? ?? AppConstants.defaultButtonColorTransparent,
      cardColor: Color(json['cardColor'] as int),
      cardColorTransparent: json['cardColorTransparent'] as bool? ?? AppConstants.defaultCardColorTransparent,
      shadowColor: Color(json['shadowColor'] as int),
      shadowColorTransparent: json['shadowColorTransparent'] as bool? ?? AppConstants.defaultShadowColorTransparent,
      fontColor: Color(json['fontColor'] as int? ?? AppColors.defaultFontColor.value),
      fontColorTransparent: json['fontColorTransparent'] as bool? ?? AppConstants.defaultFontColorTransparent,
      animationSpeed: Duration(milliseconds: json['animationSpeed'] as int? ?? AppConstants.defaultAnimationSpeed.inMilliseconds),
      animationCurve: json['animationCurve'] as String? ?? AppConstants.defaultAnimationCurve,
      layoutSpacing: (json['layoutSpacing'] as num?)?.toDouble() ?? AppConstants.defaultLayoutSpacing,
      avatarShape: json['avatarShape'] as String? ?? AppConstants.defaultAvatarShape,
      avatarRoundedRadius: (json['avatarRoundedRadius'] as num?)?.toDouble() ?? AppConstants.defaultAvatarRoundedRadius,
      avatarDiameter: (json['avatarDiameter'] as num?)?.toDouble() ?? AppConstants.defaultAvatarDiameter,
      avatarWidth: (json['avatarWidth'] as num?)?.toDouble() ?? AppConstants.defaultAvatarWidth,
      avatarHeight: (json['avatarHeight'] as num?)?.toDouble() ?? AppConstants.defaultAvatarHeight,
      avatarHexagonRoundness: (json['avatarHexagonRoundness'] as num?)?.toDouble() ?? AppConstants.defaultAvatarHexagonRoundness,
      avatarCornerCount: json['avatarCornerCount'] as int? ?? AppConstants.defaultAvatarCornerCount,
      avatarVisible: json['avatarVisible'] as bool? ?? AppConstants.defaultAvatarVisible,
      avatarImagePath: json['avatarImagePath'] as String? ?? AppConstants.defaultAvatarImagePath,
      hasCustomImage: json['hasCustomImage'] as bool? ?? AppConstants.defaultHasCustomImage,
      profileName: json['profileName'] as String? ?? AppConstants.defaultProfileName,
      profileRole: json['profileRole'] as String? ?? AppConstants.defaultProfileRole,
      profileHeadline: json['profileHeadline'] as String? ?? AppConstants.defaultProfileHeadline,
      textFieldBackgroundColor: Color(json['textFieldBackgroundColor'] as int? ?? AppConstants.defaultTextFieldBackgroundColor.value),
      textFieldBorderColor: Color(json['textFieldBorderColor'] as int? ?? AppConstants.defaultTextFieldBorderColor.value),
      textFieldNameVisible: json['textFieldNameVisible'] as bool? ?? AppConstants.defaultTextFieldNameVisible,
      textFieldRoleVisible: json['textFieldRoleVisible'] as bool? ?? AppConstants.defaultTextFieldRoleVisible,
      textFieldHeadlineVisible: json['textFieldHeadlineVisible'] as bool? ?? AppConstants.defaultTextFieldHeadlineVisible,
      textFieldBackgroundColorTransparent: json['textFieldBackgroundColorTransparent'] as bool? ?? AppConstants.defaultTextFieldBackgroundColorTransparent,
      textFieldBorderColorTransparent: json['textFieldBorderColorTransparent'] as bool? ?? AppConstants.defaultTextFieldBorderColorTransparent,
    );
  }
}
