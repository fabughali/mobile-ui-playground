import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../state/ui_state.dart';
import '../../../models/ui_instruction.dart';
import '../../../core/extensions/color_opacity_extensions.dart';

// Helper function to convert Color to hex string
String _colorToHex(Color color) {
  // Ensure the color values are properly clamped and converted
  final r = color.red.clamp(0, 255);
  final g = color.green.clamp(0, 255);
  final b = color.blue.clamp(0, 255);
  
  final hex = '#${r.toRadixString(16).padLeft(2, '0')}${g.toRadixString(16).padLeft(2, '0')}${b.toRadixString(16).padLeft(2, '0')}'.toUpperCase();
  
  return hex;
}

class ColorControlsSection extends ConsumerWidget {
  const ColorControlsSection({super.key});

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
                  Icons.palette,
                  size: 20,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Color Controls',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // AppBar Color (formerly Background Color)
            _buildColorControl(
              context,
              'AppBar Color',
              uiState.appBarColor,
              (color) => uiStateNotifier.applyInstruction(
                UIInstruction(
                  component: 'appBar',
                  property: 'color',
                  value: color,
                ),
              ),
              uiStateNotifier,
              theme,
              isTransparent: uiState.appBarColorTransparent,
              onTransparencyChanged: (transparent) => uiStateNotifier.applyInstruction(
                UIInstruction(
                  component: 'appBar',
                  property: 'transparent',
                  value: transparent,
                ),
              ),
              component: 'appBar',
            ),
            
            const SizedBox(height: 16),
            
            // Background Color (new control)
            _buildColorControl(
              context,
              'Background Color',
              uiState.backgroundColor,
              (color) => uiStateNotifier.applyInstruction(
                UIInstruction(
                  component: 'background',
                  property: 'color',
                  value: color,
                ),
              ),
              uiStateNotifier,
              theme,
              isTransparent: uiState.backgroundColorTransparent,
              onTransparencyChanged: (transparent) => uiStateNotifier.applyInstruction(
                UIInstruction(
                  component: 'background',
                  property: 'transparent',
                  value: transparent,
                ),
              ),
              component: 'background',
            ),
            
            const SizedBox(height: 16),
            
            // Button Color
            _buildColorControl(
              context,
              'Button Color',
              uiState.buttonColor,
              (color) => uiStateNotifier.applyInstruction(
                UIInstruction(
                  component: 'button',
                  property: 'color',
                  value: color,
                ),
              ),
              uiStateNotifier,
              theme,
              isTransparent: uiState.buttonColorTransparent,
              onTransparencyChanged: (transparent) => uiStateNotifier.applyInstruction(
                UIInstruction(
                  component: 'button',
                  property: 'transparent',
                  value: transparent,
                ),
              ),
              component: 'button',
            ),
            
            const SizedBox(height: 16),
            
            // Card Color
            _buildColorControl(
              context,
              'Card Color',
              uiState.cardColor,
              (color) => uiStateNotifier.applyInstruction(
                UIInstruction(
                  component: 'card',
                  property: 'color',
                  value: color,
                ),
              ),
              uiStateNotifier,
              theme,
              isTransparent: uiState.cardColorTransparent,
              onTransparencyChanged: (transparent) => uiStateNotifier.applyInstruction(
                UIInstruction(
                  component: 'card',
                  property: 'transparent',
                  value: transparent,
                ),
              ),
              component: 'card',
            ),
            
            const SizedBox(height: 16),
            
            // Font Color
            _buildColorControl(
              context,
              'Font Color',
              uiState.fontColor,
              (color) => uiStateNotifier.applyInstruction(
                UIInstruction(
                  component: 'font',
                  property: 'color',
                  value: color,
                ),
              ),
              uiStateNotifier,
              theme,
              isTransparent: uiState.fontColorTransparent,
              onTransparencyChanged: (transparent) => uiStateNotifier.applyInstruction(
                UIInstruction(
                  component: 'font',
                  property: 'transparent',
                  value: transparent,
                ),
              ),
              component: 'font',
            ),
            
            const SizedBox(height: 16),
            
            // Shadow Color
            _buildColorControl(
              context,
              'Shadow Color',
              uiState.shadowColor,
              (color) => uiStateNotifier.applyInstruction(
                UIInstruction(
                  component: 'shadow',
                  property: 'color',
                  value: color,
                ),
              ),
              uiStateNotifier,
              theme,
              isTransparent: uiState.shadowColorTransparent,
              onTransparencyChanged: (transparent) => uiStateNotifier.applyInstruction(
                UIInstruction(
                  component: 'shadow',
                  property: 'transparent',
                  value: transparent,
                ),
              ),
              component: 'shadow',
            ),
            
            const SizedBox(height: 16),
            
            // Text Field Background Color
            _buildColorControl(
              context,
              'Text Field Background',
              uiState.textFieldBackgroundColor,
              (color) => uiStateNotifier.applyInstruction(
                UIInstruction(
                  component: 'avatar',
                  property: 'textFieldBackgroundColor',
                  value: color,
                ),
              ),
              uiStateNotifier,
              theme,
              isTransparent: uiState.textFieldBackgroundColorTransparent,
              onTransparencyChanged: (transparent) => uiStateNotifier.applyInstruction(
                UIInstruction(
                  component: 'avatar',
                  property: 'textFieldBackgroundColorTransparent',
                  value: transparent,
                ),
              ),
              component: 'textFieldBackgroundColor',
            ),
            
            const SizedBox(height: 16),
            
            // Text Field Border Color
            _buildColorControl(
              context,
              'Text Field Border',
              uiState.textFieldBorderColor,
              (color) => uiStateNotifier.applyInstruction(
                UIInstruction(
                  component: 'avatar',
                  property: 'textFieldBorderColor',
                  value: color,
                ),
              ),
              uiStateNotifier,
              theme,
              isTransparent: uiState.textFieldBorderColorTransparent,
              onTransparencyChanged: (transparent) => uiStateNotifier.applyInstruction(
                UIInstruction(
                  component: 'avatar',
                  property: 'textFieldBorderColorTransparent',
                  value: transparent,
                ),
              ),
              component: 'textFieldBorderColor',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorControl(
    BuildContext context,
    String label,
    Color currentColor,
    Function(Color) onColorChanged,
    UIState uiStateNotifier,
    ThemeData theme,
    {
      required bool isTransparent,
      required Function(bool) onTransparencyChanged,
      required String component,
    }
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isTransparent ? Colors.transparent : currentColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: theme.colorScheme.outline,
                  width: 1,
                ),
              ),
              child: isTransparent
                  ? Stack(
                      alignment: Alignment.center,
                      children: [
                        // Transparent pattern
                        CustomPaint(
                          painter: TransparentPatternPainter(
                            color: theme.colorScheme.outline.withAlpha(50),
                          ),
                          size: const Size(40, 40),
                        ),
                        // Visibility icon
                        Icon(
                          Icons.visibility_off,
                          color: theme.colorScheme.outline,
                          size: 20,
                        ),
                      ],
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                isTransparent ? 'Transparent' : _colorToHex(currentColor),
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: isTransparent ? theme.colorScheme.outline : null,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Transparency checkbox
                Checkbox(
                  value: isTransparent,
                  onChanged: (value) {
                    onTransparencyChanged(value ?? false);
                  },
                ),
                const SizedBox(width: 4),
                Text(
                  'Trans',
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 8),
                // Color picker button
                IconButton(
                  icon: const Icon(Icons.color_lens),
                  onPressed: isTransparent ? null : () => _showColorPicker(
                    context,
                    currentColor,
                    onColorChanged,
                    theme,
                    component,
                  ),
                  tooltip: 'Color Picker',
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

    void _showColorPicker(
    BuildContext context,
    Color currentColor,
    Function(Color) onColorChanged,
    ThemeData theme,
    String component,
  ) {
    Color selectedColor = currentColor;
    
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text('Color Picker'),
            content: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 350,
                maxHeight: 500,
              ),
              child: SingleChildScrollView(
                child: _ColorPickerWidget(
                  initialColor: selectedColor,
                  onColorChanged: (color) {
                    setState(() {
                      selectedColor = color;
                    });
                    // Apply color change immediately for real-time preview
                    onColorChanged(color);
                  },
                  colorType: component,
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      ),
    );
  }



}

// Custom painter for transparent pattern
class TransparentPatternPainter extends CustomPainter {
  final Color color;
  
  TransparentPatternPainter({required this.color});
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;
    
    // Draw diagonal lines to indicate transparency
    for (int i = 0; i < size.width; i += 4) {
      canvas.drawLine(
        Offset(i.toDouble(), 0),
        Offset(i.toDouble(), size.height),
        paint,
      );
    }
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ColorPickerWidget extends ConsumerStatefulWidget {
  final Color initialColor;
  final Function(Color) onColorChanged;
  final String colorType;

  const _ColorPickerWidget({
    required this.initialColor,
    required this.onColorChanged,
    required this.colorType,
  });

  @override
  ConsumerState<_ColorPickerWidget> createState() => _ColorPickerWidgetState();
}

class _ColorPickerWidgetState extends ConsumerState<_ColorPickerWidget> {
  late Color _currentColor;
  late double _currentHue;
  late TextEditingController _hexController;
  bool _isUserEditing = false;

  @override
  void initState() {
    super.initState();
    _currentColor = widget.initialColor;
    // Initialize hue from the initial color
    final hsv = HSVColor.fromColor(widget.initialColor);
    _currentHue = hsv.hue;
    _hexController = TextEditingController(
      text: _colorToHex(_currentColor),
    );
    
    // TEST: Verify HSV conversion works
    // final testRed = HSVColor.fromAHSV(1.0, 0.0, 1.0, 1.0).toColor();
    // final testGreen = HSVColor.fromAHSV(1.0, 120.0, 1.0, 1.0).toColor();
    // final testBlue = HSVColor.fromAHSV(1.0, 240.0, 1.0, 1.0).toColor();
  }



  @override
  void didUpdateWidget(_ColorPickerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    if (oldWidget.initialColor != widget.initialColor) {
      _currentColor = widget.initialColor;
      final hsv = HSVColor.fromColor(widget.initialColor);
      _currentHue = hsv.hue;
      _hexController.text = _colorToHex(_currentColor);
    }
  }





  @override
  void dispose() {
    _hexController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Watch the UI state to get the actual current color
    final uiState = ref.watch(uIStateProvider);
    
    // Get the actual current color based on component type
    Color actualColor;
    switch (widget.colorType) {
      case 'background':
        actualColor = uiState.backgroundColorTransparent ? Colors.transparent : uiState.backgroundColor;
        break;
      case 'button':
        actualColor = uiState.buttonColorTransparent ? Colors.transparent : uiState.buttonColor;
        break;
      case 'card':
        actualColor = uiState.cardColorTransparent ? Colors.transparent : uiState.cardColor;
        break;
      case 'shadow':
        actualColor = uiState.shadowColorTransparent ? Colors.transparent : uiState.shadowColor;
        break;
      case 'font':
        actualColor = uiState.fontColorTransparent ? Colors.transparent : uiState.fontColor;
        break;
      case 'textFieldBackgroundColor':
        actualColor = uiState.textFieldBackgroundColorTransparent ? Colors.transparent : uiState.textFieldBackgroundColor;
        break;
      case 'textFieldBorderColor':
        actualColor = uiState.textFieldBorderColorTransparent ? Colors.transparent : uiState.textFieldBorderColor;
        break;
      default:
        actualColor = widget.initialColor;
    }
    
    // Update current color if it changed in the UI state and user is not actively editing
    if (_currentColor != actualColor && !_isUserEditing) {
      _currentColor = actualColor;
      final hsv = HSVColor.fromColor(actualColor);
      _currentHue = hsv.hue;
      _hexController.text = _colorToHex(_currentColor);
    }
    
    return Column(
      children: [
        // Color Picker Panel
        _buildColorPickerPanel(),
        const SizedBox(height: 16),
      ],
    );
  }

    Widget _buildColorPickerPanel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Color Picker',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 16),
        
        // Color Type (Saturation/Value picker) - No round edges
        Container(
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: GestureDetector(
            onPanUpdate: (details) => _updateColorFromGradient(details),
            onTapDown: (details) => _updateColorFromGradient(details),
            child: CustomPaint(
              painter: _GradientPainter(
                hue: _currentHue,
                selectedColor: _currentColor,
              ),
            ),
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Color Range (Hue Bar) - No round edges
        Container(
          height: 30,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: GestureDetector(
            onPanUpdate: (details) => _updateHueFromBar(details),
            onTapDown: (details) => _updateHueFromBar(details),
            child: CustomPaint(
              painter: _HueBarPainter(
                selectedHue: _currentHue,
              ),
            ),
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Color Palette + Hex Value in same row
        Row(
          children: [
            // Color Palette showing current picked color
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: _currentColor,
                border: Border.all(
                  color: Colors.grey.shade300,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlphaValue(26), // 0.1 * 255 ≈ 26
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            // Hex value of current color (as TEXT only, not text field)
            Expanded(
              child: Text(
                _colorToHex(_currentColor),
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 16),
        
        // Hex Input Field where user can enter hex color value
        TextField(
          controller: _hexController,
          decoration: const InputDecoration(
            labelText: 'Hex',
            border: OutlineInputBorder(),
            hintText: '#F4D35E',
            prefixText: '#',
            helperText: 'Enter hex color value to apply it',
          ),
          style: const TextStyle(
            fontFamily: 'monospace',
            fontWeight: FontWeight.w600,
          ),
          onChanged: (value) {
            // Update color as user types (for real-time preview)
            if (value.startsWith('#') && value.length == 7) {
              _updateColorFromHex(value);
            }
          },
          onSubmitted: (value) => _updateColorFromHex(value),
          onEditingComplete: () => _updateColorFromHex(_hexController.text),
        ),
      ],
    );
  }





  void _updateColorFromGradient(dynamic details) {
    _isUserEditing = true;
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final localPosition = renderBox.globalToLocal(details.globalPosition);
    final size = renderBox.size;
    
    final saturation = (localPosition.dx / size.width).clamp(0.0, 1.0);
    final value = (1.0 - (localPosition.dy / size.height)).clamp(0.0, 1.0);
    
    final newColor = HSVColor.fromAHSV(1.0, _currentHue, saturation, value).toColor();
    
    setState(() {
      _currentColor = newColor;
    });
    
    _hexController.text = _colorToHex(newColor);
    widget.onColorChanged(newColor);
    _isUserEditing = false;
  }

  void _updateHueFromBar(dynamic details) {
    _isUserEditing = true;
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final localPosition = renderBox.globalToLocal(details.globalPosition);
    final size = renderBox.size;
    
    final newHue = (localPosition.dx / size.width * 360.0).clamp(0.0, 360.0);
    _currentHue = newHue;
    
    final hsv = HSVColor.fromColor(_currentColor);
    final saturation = hsv.saturation;
    final value = hsv.value;
    
    final newColor = HSVColor.fromAHSV(1.0, _currentHue, saturation, value).toColor();
    
    setState(() {
      _currentColor = newColor;
    });
    
    _hexController.text = _colorToHex(newColor);
    widget.onColorChanged(newColor);
    _isUserEditing = false;
  }



  void _updateColorFromHex(String hexValue) {
    _isUserEditing = true;
    String cleanHex = hexValue.startsWith('#') ? hexValue.substring(1) : hexValue;
    
    if (cleanHex.length == 6) {
      try {
        final color = Color(int.parse(cleanHex, radix: 16) + 0xFF000000);
        _updateColor(color);
      } catch (e) {
        // Invalid hex value, ignore
      }
    }
    _isUserEditing = false;
  }

  void _updateColor(Color newColor) {
    if (_currentColor != newColor) {
      setState(() {
        _currentColor = newColor;
        _hexController.text = _colorToHex(newColor);
      });
      widget.onColorChanged(newColor);
    }
  }
}



class _GradientPainter extends CustomPainter {
  final double hue;
  final Color selectedColor;

  _GradientPainter({required this.hue, required this.selectedColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    
    // Draw saturation/value gradient
    for (int y = 0; y < size.height; y += 2) {
      for (int x = 0; x < size.width; x += 2) {
        final saturation = x / size.width;
        final value = 1.0 - (y / size.height);
        final color = HSVColor.fromAHSV(1.0, hue, saturation, value).toColor();
        paint.color = color;
        canvas.drawCircle(Offset(x.toDouble(), y.toDouble()), 1.0, paint);
      }
    }
    
    // Draw selection indicator
    final hsv = HSVColor.fromColor(selectedColor);
    final x = hsv.saturation * size.width;
    final y = (1.0 - hsv.value) * size.height;
    
    final selectionPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    
    canvas.drawCircle(Offset(x, y), 6.0, selectionPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _HueBarPainter extends CustomPainter {
  final double selectedHue;

  _HueBarPainter({required this.selectedHue});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    
    // Draw hue spectrum
    for (int x = 0; x < size.width; x++) {
      final hue = (x / size.width) * 360.0;
      final color = HSVColor.fromAHSV(1.0, hue, 1.0, 1.0).toColor();
      paint.color = color;
      canvas.drawLine(
        Offset(x.toDouble(), 0),
        Offset(x.toDouble(), size.height),
        paint,
      );
    }
    
    // Draw selection indicator
    final x = (selectedHue / 360.0) * size.width;
    final selectionPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;
    
    canvas.drawCircle(Offset(x, size.height / 2), 8.0, selectionPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}


