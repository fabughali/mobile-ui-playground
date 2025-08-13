import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../state/ui_state.dart';
import '../../../models/ui_instruction.dart';
import '../../../core/app_constants.dart';

class SpacingControlsSection extends ConsumerWidget {
  const SpacingControlsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uiState = ref.watch(uIStateProvider);
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
                  Icons.space_bar,
                  size: 20,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Spacing Controls',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Spacing Presets
            _buildSpacingPresets(context, uiState, uiStateNotifier, theme),
            
            const SizedBox(height: 16),
            
            // Current Spacing Display
            _buildCurrentSpacing(context, uiState, theme),
          ],
        ),
      ),
    );
  }

  Widget _buildSpacingPresets(
    BuildContext context,
    UIStateData uiState,
    UIState uiStateNotifier,
    ThemeData theme,
  ) {
    const spacingOptions = [
      {'name': 'Tight', 'value': 8.0, 'icon': Icons.compress},
      {'name': 'Normal', 'value': 16.0, 'icon': Icons.space_bar},
      {'name': 'Loose', 'value': 24.0, 'icon': Icons.expand},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Layout Spacing',
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: spacingOptions.map((option) {
            final isSelected = uiState.layoutSpacing == option['value'];
            return _buildSpacingOption(
              context,
              option,
              isSelected,
              () => uiStateNotifier.applyInstruction(
                UIInstruction(
                  component: 'layout',
                  property: 'spacing',
                  value: option['value'] as double,
                ),
              ),
              theme,
            );
          }).toList(),
        ),
        
        const SizedBox(height: 16),
        
        // Manual Input Section
        _buildManualSpacingInput(context, uiState, uiStateNotifier, theme),
      ],
    );
  }

  Widget _buildSpacingOption(
    BuildContext context,
    Map<String, dynamic> option,
    bool isSelected,
    VoidCallback onTap,
    ThemeData theme,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected 
              ? theme.colorScheme.primary 
              : theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected 
                ? theme.colorScheme.primary 
                : theme.colorScheme.outline,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              option['icon'] as IconData,
              size: 16,
              color: isSelected 
                  ? theme.colorScheme.onPrimary 
                  : theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 6),
            Text(
              option['name'] as String,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: isSelected 
                    ? theme.colorScheme.onPrimary 
                    : theme.colorScheme.onSurfaceVariant,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildManualSpacingInput(
    BuildContext context,
    UIStateData uiState,
    UIState uiStateNotifier,
    ThemeData theme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Custom Spacing',
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: TextEditingController(
                  text: uiState.layoutSpacing.round().toString(),
                ),
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Spacing (px)',
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
                onSubmitted: (value) {
                  final spacing = double.tryParse(value);
                  if (spacing != null && spacing >= 0 && spacing <= 100) {
                    uiStateNotifier.applyInstruction(
                      UIInstruction(
                        component: 'layout',
                        property: 'spacing',
                        value: spacing,
                      ),
                    );
                  }
                },
              ),
            ),
            const SizedBox(width: 16),
            SizedBox(
              width: 80,
              child: ElevatedButton(
                onPressed: () {
                  final controller = TextEditingController();
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Set Custom Spacing'),
                      content: TextField(
                        controller: controller,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Spacing (px)',
                          border: OutlineInputBorder(),
                        ),
                        autofocus: true,
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            final spacing = double.tryParse(controller.text);
                            if (spacing != null && spacing >= 0 && spacing <= 100) {
                              uiStateNotifier.applyInstruction(
                                UIInstruction(
                                  component: 'layout',
                                  property: 'spacing',
                                  value: spacing,
                                ),
                              );
                              Navigator.of(context).pop();
                            }
                          },
                          child: const Text('Apply'),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text('Set'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCurrentSpacing(
    BuildContext context,
    UIStateData uiState,
    ThemeData theme,
  ) {
    final currentSpacing = uiState.layoutSpacing;
    String spacingName = 'Normal';
    
    if (currentSpacing == AppConstants.layoutSpacingMap['tight']) {
      spacingName = 'Tight';
    } else if (currentSpacing == AppConstants.layoutSpacingMap['loose']) {
      spacingName = 'Loose';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Current Spacing',
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                '$spacingName (${currentSpacing.toInt()}px)',
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
