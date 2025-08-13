import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../state/ui_state.dart';
import 'dart:convert'; // Added for jsonEncode and jsonDecode
import 'package:shared_preferences/shared_preferences.dart'; // Added for local storage

class QuickActionsSection extends ConsumerWidget {
  const QuickActionsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uiStateNotifier = ref.read(uIStateProvider.notifier);
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Header
            Row(
              children: [
                Icon(
                  Icons.flash_on,
                  size: 20,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Quick Actions',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Action Buttons
            _buildQuickActions(context, ref.read(uIStateProvider), uiStateNotifier, theme),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions(
    BuildContext context,
    UIStateData uiState,
    UIState uiStateNotifier,
    ThemeData theme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            // Reset Button
            ElevatedButton.icon(
              onPressed: () => _showResetConfirmation(context, uiStateNotifier),
              icon: const Icon(Icons.refresh, size: 16),
              label: const Text('Reset'),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.error,
                foregroundColor: theme.colorScheme.onError,
              ),
            ),
            
            // Save Layout Button
            ElevatedButton.icon(
              onPressed: () => _showSaveLayoutDialog(context, uiState, uiStateNotifier, theme),
              icon: const Icon(Icons.save, size: 16),
              label: const Text('Save'),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
              ),
            ),
            
            // Load Layout Button
            ElevatedButton.icon(
              onPressed: () async => await _showLoadLayoutDialog(context, uiStateNotifier, theme),
              icon: const Icon(Icons.folder_open, size: 16),
              label: const Text('Load'),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.secondary,
                foregroundColor: theme.colorScheme.onSecondary,
              ),
            ),
            
            // Export Button
            ElevatedButton.icon(
              onPressed: () => _exportLayout(context, uiState),
              icon: const Icon(Icons.download, size: 16),
              label: const Text('Export'),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.tertiary,
                foregroundColor: theme.colorScheme.onTertiary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showResetConfirmation(BuildContext context, UIState uiStateNotifier) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset to Default'),
        content: const Text(
          'Are you sure you want to reset all settings to their default values? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              uiStateNotifier.reset();
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Settings reset to default'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Theme.of(context).colorScheme.onError,
            ),
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }



  void _showSaveLayoutDialog(
    BuildContext context,
    UIStateData uiState,
    UIState uiStateNotifier,
    ThemeData theme,
  ) {
    final nameController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Save Layout'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Save your current layout configuration for later use.',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Layout Name',
                border: OutlineInputBorder(),
                hintText: 'e.g., Professional Theme',
              ),
              autofocus: true,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (nameController.text.trim().isNotEmpty) {
                await _saveLayout(nameController.text.trim(), uiState);
                if (context.mounted) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Layout "${nameController.text.trim()}" saved successfully!'),
                      backgroundColor: theme.colorScheme.primary,
                    ),
                  );
                }
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Future<void> _showLoadLayoutDialog(
    BuildContext context,
    UIState uiStateNotifier,
    ThemeData theme,
  ) async {
    final savedLayouts = await _getSavedLayouts();
    
    // Check if context is still mounted after async operation
    if (!context.mounted) return;
    
    if (savedLayouts.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('No Saved Layouts'),
          content: const Text('You haven\'t saved any layouts yet. Save a layout first to load it later.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Load Layout'),
        content: SizedBox(
          width: 300,
          height: 200,
          child: ListView.builder(
            itemCount: savedLayouts.length,
            itemBuilder: (context, index) {
              final layout = savedLayouts[index];
              return ListTile(
                leading: const Icon(Icons.folder),
                title: Text(layout['name'] as String),
                subtitle: Text('Saved on ${layout['date'] as String}'),
                onTap: () {
                  _loadLayout(layout['data'] as Map<String, dynamic>, uiStateNotifier);
                  Navigator.of(context).pop();
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Layout "${layout['name']}" loaded successfully!'),
                        backgroundColor: theme.colorScheme.primary,
                      ),
                    );
                  }
                },
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  Future<void> _saveLayout(String name, UIStateData uiState) async {
    final layoutData = {
      'name': name,
      'date': DateTime.now().toIso8601String(),
      'data': uiState.toJson(),
    };
    
    final savedLayouts = await _getSavedLayouts();
    savedLayouts.add(layoutData);
    
    // Save to local storage (in a real app, this would go to a database or cloud)
    final prefs = await SharedPreferences.getInstance();
    final layoutsJson = jsonEncode(savedLayouts);
    prefs.setString('saved_layouts', layoutsJson);
  }

  Future<List<Map<String, dynamic>>> _getSavedLayouts() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final layoutsJson = prefs.getString('saved_layouts');
      if (layoutsJson != null) {
        final List<dynamic> layouts = jsonDecode(layoutsJson);
        return layouts.cast<Map<String, dynamic>>();
      }
      return <Map<String, dynamic>>[];
    } catch (e) {
      return <Map<String, dynamic>>[];
    }
  }

  void _loadLayout(Map<String, dynamic> layoutData, UIState uiStateNotifier) {
    try {
      uiStateNotifier.fromJson(layoutData);
    } catch (e) {
      // Handle error
    }
  }

  void _exportLayout(BuildContext context, UIStateData uiState) {
    final layoutString = const JsonEncoder.withIndent('  ').convert(uiState.toJson());
    
    // In a real app, this would save to a file or share
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Layout Exported'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Your layout has been exported. Copy the JSON below:'),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              height: 200,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: SingleChildScrollView(
                child: SelectableText(
                  layoutString,
                  style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
