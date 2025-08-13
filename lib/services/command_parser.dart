import 'package:flutter/material.dart';
import '../models/ui_instruction.dart';

class CommandParser {
  static final Map<String, UIInstruction> _commandMap = {
    // Background commands
    'make background blue': UIInstruction(component: 'background', property: 'color', value: Colors.blue),
    'make background red': UIInstruction(component: 'background', property: 'color', value: Colors.red),
    'make background green': UIInstruction(component: 'background', property: 'color', value: Colors.green),
    'make background purple': UIInstruction(component: 'background', property: 'color', value: Colors.purple),
    'make background orange': UIInstruction(component: 'background', property: 'color', value: Colors.orange),
    'background blue': UIInstruction(component: 'background', property: 'color', value: Colors.blue),
    'background red': UIInstruction(component: 'background', property: 'color', value: Colors.red),
    'background green': UIInstruction(component: 'background', property: 'color', value: Colors.green),
    
    // Title commands
    'change title red': UIInstruction(component: 'title', property: 'color', value: Colors.red),
    'change title blue': UIInstruction(component: 'title', property: 'color', value: Colors.blue),
    'change title green': UIInstruction(component: 'title', property: 'color', value: Colors.green),
    'title red': UIInstruction(component: 'title', property: 'color', value: Colors.red),
    'title blue': UIInstruction(component: 'title', property: 'color', value: Colors.blue),
    'title green': UIInstruction(component: 'title', property: 'color', value: Colors.green),
    
    // Avatar commands
    'hide avatar': UIInstruction(component: 'avatar', property: 'visibility', value: false),
    'show avatar': UIInstruction(component: 'avatar', property: 'visibility', value: true),
    'make avatar bigger': UIInstruction(component: 'avatar', property: 'size', value: 120.0),
    'make avatar smaller': UIInstruction(component: 'avatar', property: 'size', value: 60.0),
    'avatar bigger': UIInstruction(component: 'avatar', property: 'size', value: 120.0),
    'avatar smaller': UIInstruction(component: 'avatar', property: 'size', value: 60.0),
    
    // Form commands
    'add email': UIInstruction(component: 'form', property: 'fields', value: 'Email'),
    'add phone': UIInstruction(component: 'form', property: 'fields', value: 'Phone'),
    'add address': UIInstruction(component: 'form', property: 'fields', value: 'Address'),
    'add age': UIInstruction(component: 'form', property: 'fields', value: 'Age'),
    'remove email': UIInstruction(component: 'form', property: 'remove', value: 'Email'),
    'remove phone': UIInstruction(component: 'form', property: 'remove', value: 'Phone'),
    
    // Button commands
    'hide button': UIInstruction(component: 'button', property: 'visibility', value: false),
    'show button': UIInstruction(component: 'button', property: 'visibility', value: true),
    'button red': UIInstruction(component: 'button', property: 'color', value: Colors.red),
    'button blue': UIInstruction(component: 'button', property: 'color', value: Colors.blue),
    'button green': UIInstruction(component: 'button', property: 'color', value: Colors.green),
    'change button text': UIInstruction(component: 'button', property: 'text', value: 'Updated'),
    'button tall': UIInstruction(component: 'button', property: 'height', value: 64.0),
    'button normal': UIInstruction(component: 'button', property: 'height', value: 48.0),
    'button short': UIInstruction(component: 'button', property: 'height', value: 32.0),
    
    // Reset command
    'reset': UIInstruction(component: 'all', property: 'reset'),
    'reset all': UIInstruction(component: 'all', property: 'reset'),
    'restore default': UIInstruction(component: 'all', property: 'reset'),
    
    // Phase 1 Enhancement Commands
    // Avatar shape commands
    'avatar circle': UIInstruction(component: 'avatar', property: 'shape', value: 'circle'),
    'avatar rounded': UIInstruction(component: 'avatar', property: 'shape', value: 'rounded'),
    'avatar square': UIInstruction(component: 'avatar', property: 'shape', value: 'square'),
    'avatar hexagon': UIInstruction(component: 'avatar', property: 'shape', value: 'hexagon'),
    
    // Animation speed commands
    'animation fast': UIInstruction(component: 'animation', property: 'speed', value: 'fast'),
    'animation normal': UIInstruction(component: 'animation', property: 'speed', value: 'normal'),
    'animation slow': UIInstruction(component: 'animation', property: 'speed', value: 'slow'),
    'fast animation': UIInstruction(component: 'animation', property: 'speed', value: 'fast'),
    'slow animation': UIInstruction(component: 'animation', property: 'speed', value: 'slow'),
    

    
    // Layout spacing commands
    'spacing tight': UIInstruction(component: 'layout', property: 'spacing', value: 'tight'),
    'spacing normal': UIInstruction(component: 'layout', property: 'spacing', value: 'normal'),
    'spacing loose': UIInstruction(component: 'layout', property: 'spacing', value: 'loose'),
    'tight spacing': UIInstruction(component: 'layout', property: 'spacing', value: 'tight'),
    'loose spacing': UIInstruction(component: 'layout', property: 'spacing', value: 'loose'),
    
    // Text field transparency commands
    'text field background transparent': UIInstruction(component: 'avatar', property: 'textFieldBackgroundColorTransparent', value: true),
    'text field background opaque': UIInstruction(component: 'avatar', property: 'textFieldBackgroundColorTransparent', value: false),
    'text field border transparent': UIInstruction(component: 'avatar', property: 'textFieldBorderColorTransparent', value: true),
    'text field border opaque': UIInstruction(component: 'avatar', property: 'textFieldBorderColorTransparent', value: false),
  };
  
  // Parse command and return UI instruction
  static UIInstruction? parseCommand(String command) {
    final normalizedCommand = command.toLowerCase().trim();
    
    // Exact match
    if (_commandMap.containsKey(normalizedCommand)) {
      final instruction = _commandMap[normalizedCommand];
      return instruction;
    }
    
    // Fuzzy matching for common patterns
    for (final entry in _commandMap.entries) {
      if (_isFuzzyMatch(normalizedCommand, entry.key)) {
        final instruction = entry.value;
        return instruction;
      }
    }
    
    return null;
  }
  
  // Simple fuzzy matching
  static bool _isFuzzyMatch(String input, String pattern) {
    final inputWords = input.split(' ');
    final patternWords = pattern.split(' ');
    
    // Check if most words match
    int matches = 0;
    for (final inputWord in inputWords) {
      for (final patternWord in patternWords) {
        if (inputWord.contains(patternWord) || patternWord.contains(inputWord)) {
          matches++;
          break;
        }
      }
    }
    
    // Return true if at least 70% of words match
    return matches >= (inputWords.length * 0.7).ceil();
  }
  
  // Get all available commands for help
  static List<String> getAvailableCommands() {
    return _commandMap.keys.toList();
  }
  
  // Get command examples for specific component
  static List<String> getCommandsForComponent(String component) {
    return _commandMap.entries
        .where((entry) => entry.value.component == component)
        .map((entry) => entry.key)
        .toList();
  }
}
