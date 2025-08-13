import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../state/ui_state.dart';
import '../../../models/ui_instruction.dart';
import '../../../core/app_constants.dart';

class AnimationControlsSection extends ConsumerWidget {
  const AnimationControlsSection({super.key});

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
                  Icons.animation,
                  size: 20,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Animation Controls',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Animation Speed
            _buildAnimationSpeedControls(context, uiState, uiStateNotifier, theme),
            
            const SizedBox(height: 16),
            
            // Current Speed Display
            _buildCurrentSpeedDisplay(context, uiState, theme),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimationSpeedControls(
    BuildContext context,
    UIStateData uiState,
    UIState uiStateNotifier,
    ThemeData theme,
  ) {
    const speedOptions = [
      {'name': 'Fast', 'value': Duration(milliseconds: 150), 'icon': Icons.speed},
      {'name': 'Normal', 'value': Duration(milliseconds: 300), 'icon': Icons.timer},
      {'name': 'Slow', 'value': Duration(milliseconds: 600), 'icon': Icons.slow_motion_video},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Animation Speed',
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: speedOptions.map((option) {
            final isSelected = uiState.animationSpeed == option['value'];
            return _buildSpeedOption(
              context,
              option,
              isSelected,
              () => uiStateNotifier.applyInstruction(
                UIInstruction(
                  component: 'animation',
                  property: 'speed',
                  value: option['value'] as Duration,
                ),
              ),
              theme,
            );
          }).toList(),
        ),
        
        const SizedBox(height: 16),
        
        // Animation Curve Selection
        _buildAnimationCurveSelector(context, uiState, uiStateNotifier, theme),
      ],
    );
  }

  Widget _buildAnimationCurveSelector(
    BuildContext context,
    UIStateData uiState,
    UIState uiStateNotifier,
    ThemeData theme,
  ) {
    const curveOptions = [
      {'name': 'Linear', 'value': 'linear', 'icon': Icons.trending_flat},
      {'name': 'Ease In', 'value': 'easeIn', 'icon': Icons.trending_up},
      {'name': 'Ease Out', 'value': 'easeOut', 'icon': Icons.trending_down},
      {'name': 'Ease In Out', 'value': 'easeInOut', 'icon': Icons.trending_up},
      {'name': 'Bounce', 'value': 'bounce', 'icon': Icons.vertical_align_bottom},
      {'name': 'Elastic', 'value': 'elastic', 'icon': Icons.waves},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Animation Curve',
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: curveOptions.map((option) {
            final isSelected = uiState.animationCurve == option['value'];
            return _buildCurveOption(
              context,
              option,
              isSelected,
              () => uiStateNotifier.applyInstruction(
                UIInstruction(
                  component: 'animation',
                  property: 'curve',
                  value: option['value'] as String,
                ),
              ),
              theme,
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSpeedOption(
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

  Widget _buildCurveOption(
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

  Widget _buildCurrentSpeedDisplay(
    BuildContext context,
    UIStateData uiState,
    ThemeData theme,
  ) {
    final currentSpeed = uiState.animationSpeed;
    String speedName = 'Normal';
    
    if (currentSpeed == AppConstants.animationSpeedMap['fast']) {
      speedName = 'Fast';
    } else if (currentSpeed == AppConstants.animationSpeedMap['slow']) {
      speedName = 'Slow';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Current Speed',
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w600,
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
                '$speedName (${currentSpeed.inMilliseconds}ms)',
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
