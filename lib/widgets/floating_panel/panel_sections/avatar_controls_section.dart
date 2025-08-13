import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math';
import '../../../state/ui_state.dart';
import '../../../models/ui_instruction.dart';


class AvatarControlsSection extends ConsumerWidget {
  const AvatarControlsSection({super.key});

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
                  Icons.person,
                  size: 20,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Avatar Controls',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Avatar Visibility Toggle
            _buildAvatarVisibilityToggle(context, uiState, uiStateNotifier, theme),
            
            const SizedBox(height: 16),
            
            // Avatar Shape Selector
            _buildShapeSelector(context, uiState, uiStateNotifier, theme),
            
            const SizedBox(height: 16),
            
                    // Shape-specific controls
        if (uiState.avatarShape.toLowerCase() == 'circle')
          _buildCircleDiameterControl(context, uiState, uiStateNotifier, theme),
        
        if (uiState.avatarShape.toLowerCase() == 'rounded')
          _buildRoundedEdgesControl(context, uiState, uiStateNotifier, theme),
        
        if (uiState.avatarShape.toLowerCase() == 'square')
          _buildRectangleDimensionsControl(context, uiState, uiStateNotifier, theme),
        
        if (uiState.avatarShape.toLowerCase() == 'hexagon')
          _buildPolygonControl(context, uiState, uiStateNotifier, theme),
            
            const SizedBox(height: 16),
            
            // Avatar Preview
            _buildAvatarPreview(context, uiState, theme),
          ],
        ),
      ),
    );
  }

  Widget _buildCircleDiameterControl(
    BuildContext context,
    UIStateData uiState,
    UIState uiStateNotifier,
    ThemeData theme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Circle Diameter',
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        
        // Slider for circle diameter
        Slider(
          value: uiState.avatarDiameter.clamp(40.0, 120.0),
          min: 40.0,
          max: 120.0,
          divisions: 80,
          label: '${uiState.avatarDiameter.round()}px',
          onChanged: (value) {
            uiStateNotifier.applyInstruction(
              UIInstruction(
                component: 'avatar',
                property: 'diameter',
                value: value,
              ),
            );
          },
        ),
        
        // Manual input for circle diameter
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: TextEditingController(
                  text: uiState.avatarDiameter.round().toString(),
                ),
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  hintText: 'Diameter (px)',
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (value) {
                  final diameter = double.tryParse(value);
                  if (diameter != null && diameter >= 40 && diameter <= 120) {
                    uiStateNotifier.applyInstruction(
                      UIInstruction(
                        component: 'avatar',
                        property: 'diameter',
                        value: diameter,
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
        
        // Current value display
        Text(
          'Current: ${uiState.avatarDiameter.round()}px',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildRectangleDimensionsControl(
    BuildContext context,
    UIStateData uiState,
    UIState uiStateNotifier,
    ThemeData theme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Rectangle Dimensions',
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        
        // Width control with slider and input
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Width',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Slider(
              value: uiState.avatarWidth.clamp(40.0, 120.0),
              min: 40.0,
              max: 120.0,
              divisions: 80,
              label: '${uiState.avatarWidth.round()}px',
              onChanged: (value) {
                uiStateNotifier.applyInstruction(
                  UIInstruction(
                    component: 'avatar',
                    property: 'width',
                    value: value,
                  ),
                );
              },
            ),
            TextField(
              controller: TextEditingController(
                text: uiState.avatarWidth.round().toString(),
              ),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                hintText: 'Width (px)',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) {
                final width = double.tryParse(value);
                if (width != null && width >= 40 && width <= 120) {
                  uiStateNotifier.applyInstruction(
                    UIInstruction(
                      component: 'avatar',
                      property: 'width',
                      value: width,
                    ),
                  );
                }
              },
            ),
          ],
        ),
        
        const SizedBox(height: 16),
        
        // Height control with slider and input
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Height',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Slider(
              value: uiState.avatarHeight.clamp(40.0, 120.0),
              min: 40.0,
              max: 120.0,
              divisions: 80,
              label: '${uiState.avatarHeight.round()}px',
              onChanged: (value) {
                uiStateNotifier.applyInstruction(
                  UIInstruction(
                    component: 'avatar',
                    property: 'height',
                    value: value,
                  ),
                );
              },
            ),
            TextField(
              controller: TextEditingController(
                text: uiState.avatarHeight.round().toString(),
              ),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                hintText: 'Height (px)',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) {
                final height = double.tryParse(value);
                if (height != null && height >= 40 && height <= 120) {
                  uiStateNotifier.applyInstruction(
                    UIInstruction(
                      component: 'avatar',
                      property: 'height',
                      value: height,
                    ),
                  );
                }
              },
            ),
          ],
        ),
        
        // Current values display
        const SizedBox(height: 8),
        Text(
          'Current: ${uiState.avatarWidth.round()} × ${uiState.avatarHeight.round()}px',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildPolygonControl(
    BuildContext context,
    UIStateData uiState,
    UIState uiStateNotifier,
    ThemeData theme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Polygon Properties',
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        
        // Corner count control with slider and input
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Number of Corners',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Slider(
              value: uiState.avatarCornerCount.toDouble().clamp(3.0, 12.0),
              min: 3.0,
              max: 12.0,
              divisions: 9,
              label: '${uiState.avatarCornerCount}',
              onChanged: (value) {
                uiStateNotifier.applyInstruction(
                  UIInstruction(
                    component: 'avatar',
                    property: 'cornerCount',
                    value: value.round(),
                  ),
                );
              },
            ),
            TextField(
              controller: TextEditingController(
                text: uiState.avatarCornerCount.toString(),
              ),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                hintText: 'Corners (3-12)',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) {
                final corners = int.tryParse(value);
                if (corners != null && corners >= 3 && corners <= 12) {
                  uiStateNotifier.applyInstruction(
                    UIInstruction(
                      component: 'avatar',
                      property: 'cornerCount',
                      value: corners,
                    ),
                  );
                }
              },
            ),
          ],
        ),
        
        const SizedBox(height: 16),
        
        // Diameter control with slider and input
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Diameter',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Slider(
              value: uiState.avatarDiameter.clamp(40.0, 120.0),
              min: 40.0,
              max: 120.0,
              divisions: 80,
              label: '${uiState.avatarDiameter.round()}px',
              onChanged: (value) {
                uiStateNotifier.applyInstruction(
                  UIInstruction(
                    component: 'avatar',
                    property: 'diameter',
                    value: value,
                  ),
                );
              },
            ),
            TextField(
              controller: TextEditingController(
                text: uiState.avatarDiameter.round().toString(),
              ),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                hintText: 'Diameter (px)',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) {
                final diameter = double.tryParse(value);
                if (diameter != null && diameter >= 40 && diameter <= 120) {
                  uiStateNotifier.applyInstruction(
                    UIInstruction(
                      component: 'avatar',
                      property: 'diameter',
                      value: diameter,
                    ),
                  );
                }
              },
            ),
          ],
        ),
        
        const SizedBox(height: 16),
        
        // Roundness control with slider and input
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Corner Roundness',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Slider(
              value: uiState.avatarHexagonRoundness.clamp(0.0, 20.0),
              min: 0.0,
              max: 20.0,
              divisions: 20,
              label: '${uiState.avatarHexagonRoundness.round()}px',
              onChanged: (value) {
                uiStateNotifier.applyInstruction(
                  UIInstruction(
                    component: 'avatar',
                    property: 'hexagonRoundness',
                    value: value,
                  ),
                );
              },
            ),
            TextField(
              controller: TextEditingController(
                text: uiState.avatarHexagonRoundness.round().toString(),
              ),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                hintText: 'Roundness (px)',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) {
                final roundness = double.tryParse(value);
                if (roundness != null && roundness >= 0 && roundness <= 20) {
                  uiStateNotifier.applyInstruction(
                    UIInstruction(
                      component: 'avatar',
                      property: 'hexagonRoundness',
                      value: roundness,
                    ),
                  );
                }
              },
            ),
          ],
        ),
        
        // Current values display
        const SizedBox(height: 8),
        Text(
          'Current: ${uiState.avatarCornerCount} corners, ${uiState.avatarDiameter.round()}px diameter, ${uiState.avatarHexagonRoundness.round()}px roundness',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildShapeSelector(
    BuildContext context,
    UIStateData uiState,
    UIState uiStateNotifier,
    ThemeData theme,
  ) {
    const shapes = [
      {'name': 'Circle', 'value': 'circle', 'icon': Icons.circle},
      {'name': 'Rounded', 'value': 'rounded', 'icon': Icons.rounded_corner},
      {'name': 'Square', 'value': 'square', 'icon': Icons.crop_square},
      {'name': 'Hexagon', 'value': 'hexagon', 'icon': Icons.hexagon},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Avatar Shape',
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: shapes.map((shape) {
            final isSelected = uiState.avatarShape.toLowerCase() == shape['value'];
            return _buildShapeOption(
              context,
              shape,
              isSelected,
                             () => uiStateNotifier.applyInstruction(
                 UIInstruction(
                   component: 'avatar',
                   property: 'shape',
                   value: shape['value'] as String,
                 ),
               ),
              theme,
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildShapeOption(
    BuildContext context,
    Map<String, dynamic> shape,
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
              shape['icon'] as IconData,
              size: 16,
              color: isSelected 
                  ? theme.colorScheme.onPrimary 
                  : theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 6),
            Text(
              shape['name'] as String,
              style: theme.textTheme.bodySmall?.copyWith(
                color: isSelected 
                    ? theme.colorScheme.onPrimary 
                    : theme.colorScheme.onSurfaceVariant,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoundedEdgesControl(
    BuildContext context,
    UIStateData uiState,
    UIState uiStateNotifier,
    ThemeData theme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Rounded Edges',
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        
        // Slider for rounded edges
        Slider(
          value: uiState.avatarRoundedRadius.clamp(0.0, 50.0),
          min: 0.0,
          max: 50.0,
          divisions: 50,
          label: '${uiState.avatarRoundedRadius.round()}px',
          onChanged: (value) {
            uiStateNotifier.applyInstruction(
              UIInstruction(
                component: 'avatar',
                property: 'roundedRadius',
                value: value,
              ),
            );
          },
        ),
        
        // Manual input for rounded edges
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: TextEditingController(
                  text: uiState.avatarRoundedRadius.round().toString(),
                ),
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  hintText: 'Radius (px)',
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (value) {
                  final radius = double.tryParse(value);
                  if (radius != null && radius >= 0 && radius <= 50) {
                    uiStateNotifier.applyInstruction(
                      UIInstruction(
                        component: 'avatar',
                        property: 'roundedRadius',
                        value: radius,
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
        
        // Current value display
        Text(
          'Current: ${uiState.avatarRoundedRadius.round()}px',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildAvatarPreview(
    BuildContext context,
    UIStateData uiState,
    ThemeData theme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Preview',
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Center(
          child: _buildAvatarShape(
            uiState.avatarShape,
            60.0,
            theme,
            uiState,
          ),
        ),
      ],
    );
  }

  Widget _buildAvatarShape(String shape, double size, ThemeData theme, UIStateData uiState) {
    switch (shape.toLowerCase()) {
      case 'circle':
        return CircleAvatar(
          radius: uiState.avatarDiameter / 2,
          backgroundColor: theme.colorScheme.primary,
          child: Icon(
            Icons.person,
            size: uiState.avatarDiameter * 0.6,
            color: theme.colorScheme.onPrimary,
          ),
        );
      
      case 'rounded':
        return Container(
          width: uiState.avatarDiameter,
          height: uiState.avatarDiameter,
          decoration: BoxDecoration(
            color: theme.colorScheme.primary,
            borderRadius: BorderRadius.circular(uiState.avatarRoundedRadius),
          ),
          child: Icon(
            Icons.person,
            size: uiState.avatarDiameter * 0.6,
            color: theme.colorScheme.onPrimary,
          ),
        );
      
      case 'square':
        return Container(
          width: uiState.avatarWidth,
          height: uiState.avatarHeight,
          decoration: BoxDecoration(
            color: theme.colorScheme.primary,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Icon(
            Icons.person,
            size: min(uiState.avatarWidth, uiState.avatarHeight) * 0.6,
            color: theme.colorScheme.onPrimary,
          ),
        );
      
      case 'hexagon':
        return ClipPath(
          key: ValueKey('polygon_${uiState.avatarCornerCount}_${uiState.avatarHexagonRoundness}_${uiState.avatarDiameter}'),
          clipper: PolygonClipper(
            cornerCount: uiState.avatarCornerCount,
            roundness: uiState.avatarHexagonRoundness,
          ),
          child: Container(
            width: uiState.avatarDiameter,
            height: uiState.avatarDiameter,
            color: theme.colorScheme.primary,
            child: Icon(
              Icons.person,
              size: uiState.avatarDiameter * 0.6,
              color: theme.colorScheme.onPrimary,
            ),
          ),
        );
      
      default:
        return CircleAvatar(
          radius: uiState.avatarDiameter / 2,
          backgroundColor: theme.colorScheme.primary,
          child: Icon(
            Icons.person,
            size: uiState.avatarDiameter * 0.6,
            color: theme.colorScheme.onPrimary,
          ),
        );
    }
  }

  Widget _buildAvatarVisibilityToggle(
    BuildContext context,
    UIStateData uiState,
    UIState uiStateNotifier,
    ThemeData theme,
  ) {
    return Row(
      children: [
        Checkbox(
          value: uiState.avatarVisible,
          onChanged: (value) {
            uiStateNotifier.applyInstruction(
              UIInstruction(
                component: 'avatar',
                property: 'visible',
                value: value ?? true,
              ),
            );
          },
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            'Show Avatar',
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 8),
        // Visual indicator
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: uiState.avatarVisible 
                ? theme.colorScheme.primary 
                : Colors.transparent,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: theme.colorScheme.outline,
              width: 1,
            ),
          ),
          child: uiState.avatarVisible
              ? Icon(
                  Icons.person,
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

class PolygonClipper extends CustomClipper<Path> {
  final int cornerCount;
  final double roundness;
  
  const PolygonClipper({
    required this.cornerCount,
    this.roundness = 0.0,
  });
  
  @override
  Path getClip(Size size) {
    final path = Path();
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final radius = size.width / 2;
    
    if (roundness <= 0) {
      // Sharp polygon
      for (int i = 0; i < cornerCount; i++) {
        final angle = (i * 2 * 3.14159 / cornerCount) - (3.14159 / cornerCount);
        final x = centerX + radius * cos(angle);
        final y = centerY + radius * sin(angle);
        
        if (i == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }
    } else {
      // Rounded polygon with proper corner rounding
      for (int i = 0; i < cornerCount; i++) {
        final angle = (i * 2 * 3.14159 / cornerCount) - (3.14159 / cornerCount);
        final nextAngle = ((i + 1) * 2 * 3.14159 / cornerCount) - (3.14159 / cornerCount);
        
        final x = centerX + radius * cos(angle);
        final y = centerY + radius * sin(angle);
        final nextX = centerX + radius * cos(nextAngle);
        final nextY = centerY + radius * sin(nextAngle);
        
        if (i == 0) {
          path.moveTo(x, y);
        }
        
        // Create smooth rounded corners using cubic bezier curves
        // Control points are positioned to create rounded corners at vertices
        final control1X = x + roundness * cos(angle + 3.14159 / (cornerCount * 2));
        final control1Y = y + roundness * sin(angle + 3.14159 / (cornerCount * 2));
        final control2X = nextX + roundness * cos(nextAngle - 3.14159 / (cornerCount * 2));
        final control2Y = nextY + roundness * sin(nextAngle - 3.14159 / (cornerCount * 2));
        
        path.cubicTo(control1X, control1Y, control2X, control2Y, nextX, nextY);
      }
    }
    
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    if (oldClipper is! PolygonClipper) return true;
    return oldClipper.cornerCount != cornerCount || 
           oldClipper.roundness != roundness;
  }
}
