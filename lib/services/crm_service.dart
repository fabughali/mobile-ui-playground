import 'dart:convert';
import 'package:flutter/material.dart';
import '../state/ui_state.dart';

class CRMService {
  static const String _mockToken = 'mock_crm_token_12345';
  
  // Mock storage for demo purposes
  static Map<String, dynamic> _mockStorage = {};
  static List<Map<String, dynamic>> _commandHistory = [];
  
  // Save current layout to CRM
  static Future<bool> saveLayout(UIStateData uiState, String layoutName) async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 500));
      
      final layoutData = {
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'name': layoutName,
        'timestamp': DateTime.now().toIso8601String(),
        'uiState': uiState.toJson(),
        'token': _mockToken,
      };
      
      // Store in mock storage
      _mockStorage[layoutName] = layoutData;
      
      // Log the save operation
      _logCommand('Save layout: $layoutName');
      
      return true;
    } catch (e) {
      debugPrint('Error saving layout: $e');
      return false;
    }
  }
  
  // Load layout from CRM
  static Future<UIStateData?> loadLayout(String layoutName) async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 500));
      
      // Check if layout exists in mock storage
      if (!_mockStorage.containsKey(layoutName)) {
        return null;
      }
      
      final layoutData = _mockStorage[layoutName];
      
      // Log the load operation
      _logCommand('Load layout: $layoutName');
      
      return UIStateData.fromJson(layoutData['uiState']);
    } catch (e) {
      debugPrint('Error loading layout: $e');
      return null;
    }
  }
  
  // Get list of saved layouts
  static Future<List<String>> getSavedLayouts() async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 300));
      
      return _mockStorage.keys.toList();
    } catch (e) {
      debugPrint('Error getting saved layouts: $e');
      return [];
    }
  }
  
  // Save command to history
  static Future<bool> saveCommandHistory(String command, bool success) async {
    try {
      final historyEntry = {
        'command': command,
        'success': success,
        'timestamp': DateTime.now().toIso8601String(),
        'token': _mockToken,
      };
      
      _commandHistory.add(historyEntry);
      
      // Keep only last 100 commands
      if (_commandHistory.length > 100) {
        _commandHistory.removeRange(0, _commandHistory.length - 100);
      }
      
      return true;
    } catch (e) {
      debugPrint('Error saving command history: $e');
      return false;
    }
  }
  
  // Get command history
  static Future<List<Map<String, dynamic>>> getCommandHistory() async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 200));
      
      return List.from(_commandHistory.reversed);
    } catch (e) {
      debugPrint('Error getting command history: $e');
      return [];
    }
  }
  
  // Delete saved layout
  static Future<bool> deleteLayout(String layoutName) async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 300));
      
      if (_mockStorage.containsKey(layoutName)) {
        _mockStorage.remove(layoutName);
        _logCommand('Delete layout: $layoutName');
        return true;
      }
      
      return false;
    } catch (e) {
      debugPrint('Error deleting layout: $e');
      return false;
    }
  }
  
  // Export all data as JSON (for Pieces integration)
  static String exportData() {
    final exportData = {
      'layouts': _mockStorage,
      'commandHistory': _commandHistory,
      'exportTimestamp': DateTime.now().toIso8601String(),
    };
    
    return jsonEncode(exportData);
  }
  
  // Import data from JSON (for Pieces integration)
  static bool importData(String jsonData) {
    try {
      final data = jsonDecode(jsonData) as Map<String, dynamic>;
      
      if (data.containsKey('layouts')) {
        _mockStorage = Map<String, dynamic>.from(data['layouts']);
      }
      
      if (data.containsKey('commandHistory')) {
        _commandHistory = List<Map<String, dynamic>>.from(data['commandHistory']);
      }
      
      return true;
    } catch (e) {
      debugPrint('Error importing data: $e');
      return false;
    }
  }
  
  // Log command for history
  static void _logCommand(String command) {
    _commandHistory.add({
      'command': command,
      'success': true,
      'timestamp': DateTime.now().toIso8601String(),
      'token': _mockToken,
    });
  }
  
  // Get mock token for demo
  static String getMockToken() {
    return _mockToken;
  }
  
  // Check if service is available
  static Future<bool> isAvailable() async {
    try {
      // Simulate network check
      await Future.delayed(const Duration(milliseconds: 100));
      return true;
    } catch (e) {
      return false;
    }
  }
}
