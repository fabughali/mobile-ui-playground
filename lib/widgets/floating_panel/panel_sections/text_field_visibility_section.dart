import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../state/ui_state.dart';
import '../../../models/ui_instruction.dart';

class TextFieldVisibilitySection extends ConsumerWidget {
  const TextFieldVisibilitySection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uiState = ref.watch(uIStateProvider);
    final uiStateNotifier = ref.read(uIStateProvider.notifier);
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.visibility,
                  color: theme.colorScheme.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Text Field Visibility',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Name Field Visibility
            _buildVisibilityToggle(
              context,
              'Name Field',
              uiState.textFieldNameVisible,
              (value) => uiStateNotifier.applyInstruction(
                UIInstruction(
                  component: 'avatar',
                  property: 'textFieldNameVisible',
                  value: value,
                ),
              ),
              theme,
            ),
            
            const SizedBox(height: 12),
            
            // Role Field Visibility
            _buildVisibilityToggle(
              context,
              'Role Field',
              uiState.textFieldRoleVisible,
              (value) => uiStateNotifier.applyInstruction(
                UIInstruction(
                  component: 'avatar',
                  property: 'textFieldRoleVisible',
                  value: value,
                ),
              ),
              theme,
            ),
            
            const SizedBox(height: 12),
            
            // Headline Field Visibility
            _buildVisibilityToggle(
              context,
              'Headline Field',
              uiState.textFieldHeadlineVisible,
              (value) => uiStateNotifier.applyInstruction(
                UIInstruction(
                  component: 'avatar',
                  property: 'textFieldHeadlineVisible',
                  value: value,
                ),
              ),
              theme,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVisibilityToggle(
    BuildContext context,
    String label,
    bool isVisible,
    Function(bool) onChanged,
    ThemeData theme,
  ) {
    return Row(
      children: [
        Checkbox(
          value: isVisible,
          onChanged: (value) => onChanged(value ?? true),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: isVisible ? theme.colorScheme.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: theme.colorScheme.outline,
              width: 1,
            ),
          ),
          child: isVisible
              ? Icon(
                  Icons.visibility,
                  size: 16,
                  color: theme.colorScheme.onPrimary,
                )
              : Icon(
                  Icons.visibility_off,
                  size: 16,
                  color: theme.colorScheme.outline,
                ),
        ),
      ],
    );
  }
}
