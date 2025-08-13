import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import '../state/ui_state.dart';
import '../models/ui_instruction.dart';




class ProfileCard extends ConsumerWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uiState = ref.watch(uIStateProvider);
    final theme = Theme.of(context);

    return AnimatedContainer(
      duration: uiState.animationSpeed,
      margin: EdgeInsets.all(uiState.layoutSpacing),
      child: Card(
        elevation: 4,
        shadowColor: uiState.shadowColorTransparent ? Colors.transparent : uiState.shadowColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: uiState.cardColorTransparent ? Colors.transparent : uiState.cardColor,
        child: Stack(
          children: [
            // Background Pattern
            
            
            // Card Content
            Padding(
              padding: EdgeInsets.all(uiState.layoutSpacing),
              child: Column(
                children: [
                  // Avatar Section
                  if (uiState.avatarVisible) _buildAvatar(context, uiState, theme),
                  
                  const SizedBox(height: 16),
                  
                  // Profile Info Section
                  _buildProfileInfo(context, uiState, theme),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar(BuildContext context, UIStateData uiState, ThemeData theme) {
    return Center(
      child: GestureDetector(
        onTap: () => _showImageSourceDialog(context, uiState),
        child: _buildAvatarShape(
          uiState.avatarShape,
          80.0, // Default size for backward compatibility
          theme,
          uiState,
        ),
      ),
    );
  }

  Widget _buildAvatarShape(String shape, double size, ThemeData theme, UIStateData uiState) {
    switch (shape.toLowerCase()) {
      case 'circle':
        return CircleAvatar(
          radius: uiState.avatarDiameter / 2,
          backgroundColor: uiState.buttonColorTransparent ? Colors.transparent : uiState.buttonColor,
          backgroundImage: uiState.hasCustomImage && uiState.avatarImagePath != null
              ? _buildBackgroundImage(uiState.avatarImagePath!)
              : null,
          child: uiState.hasCustomImage && uiState.avatarImagePath != null
              ? null
              : Icon(
                  Icons.person,
                  size: uiState.avatarDiameter * 0.6,
                  color: uiState.fontColorTransparent ? Colors.transparent : uiState.fontColor,
                ),
        );
      
      case 'rounded':
        return Container(
          width: uiState.avatarDiameter,
          height: uiState.avatarDiameter,
          decoration: BoxDecoration(
            color: uiState.buttonColorTransparent ? Colors.transparent : uiState.buttonColor,
            borderRadius: BorderRadius.circular(uiState.avatarRoundedRadius),
            image: uiState.hasCustomImage && uiState.avatarImagePath != null
                ? DecorationImage(
                    image: _buildBackgroundImage(uiState.avatarImagePath!),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: uiState.hasCustomImage && uiState.avatarImagePath != null
              ? null
              : Icon(
                  Icons.person,
                  size: uiState.avatarDiameter * 0.6,
                  color: uiState.fontColorTransparent ? Colors.transparent : uiState.fontColor,
                ),
        );
      
      case 'square':
        return Container(
          width: uiState.avatarWidth,
          height: uiState.avatarHeight,
          decoration: BoxDecoration(
            color: uiState.buttonColorTransparent ? Colors.transparent : uiState.buttonColor,
            borderRadius: BorderRadius.circular(4),
            image: uiState.hasCustomImage && uiState.avatarImagePath != null
                ? DecorationImage(
                    image: _buildBackgroundImage(uiState.avatarImagePath!),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: uiState.hasCustomImage && uiState.avatarImagePath != null
              ? null
              : Icon(
                  Icons.person,
                  size: min(uiState.avatarWidth, uiState.avatarHeight) * 0.6,
                  color: uiState.fontColorTransparent ? Colors.transparent : uiState.fontColor,
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
            decoration: BoxDecoration(
              color: uiState.buttonColorTransparent ? Colors.transparent : uiState.buttonColor,
              image: uiState.hasCustomImage && uiState.avatarImagePath != null
                  ? DecorationImage(
                      image: _buildBackgroundImage(uiState.avatarImagePath!),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: uiState.hasCustomImage && uiState.avatarImagePath != null
                ? null
                : Icon(
                    Icons.person,
                    size: uiState.avatarDiameter * 0.6,
                    color: uiState.fontColorTransparent ? Colors.transparent : uiState.fontColor,
                  ),
          ),
        );
      
      default:
        return CircleAvatar(
          radius: uiState.avatarDiameter / 2,
          backgroundColor: uiState.buttonColorTransparent ? Colors.transparent : uiState.buttonColor,
          backgroundImage: uiState.hasCustomImage && uiState.avatarImagePath != null
              ? _buildBackgroundImage(uiState.avatarImagePath!)
              : null,
          child: uiState.hasCustomImage && uiState.avatarImagePath != null
              ? null
              : Icon(
                  Icons.person,
                  size: uiState.avatarDiameter * 0.6,
                  color: uiState.fontColorTransparent ? Colors.transparent : uiState.fontColor,
                ),
        );
    }
  }

  Widget _buildProfileInfo(BuildContext context, UIStateData uiState, ThemeData theme) {
    return Column(
      children: [
        if (uiState.textFieldNameVisible)
          Text(
            uiState.profileName,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: uiState.fontColorTransparent ? Colors.transparent : uiState.fontColor,
            ),
          ),
        const SizedBox(height: 8),
        if (uiState.textFieldRoleVisible)
          Text(
            uiState.profileRole,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: uiState.fontColorTransparent ? Colors.transparent : uiState.fontColor,
            ),
          ),
        const SizedBox(height: 16),
        if (uiState.textFieldHeadlineVisible)
          Text(
            uiState.profileHeadline,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: uiState.fontColorTransparent ? Colors.transparent : uiState.fontColor,
            ),
            textAlign: TextAlign.center,
          ),
      ],
    );
  }



  void _showImageSourceDialog(BuildContext context, UIStateData uiState) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Avatar Image'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (uiState.hasCustomImage)
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('Remove Current Image'),
                subtitle: const Text('Reset avatar to default'),
                onTap: () {
                  Navigator.of(context).pop();
                  _deleteAvatarImage(context);
                },
              ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from Gallery'),
              subtitle: const Text('Select an image from your device'),
                              onTap: () {
                  Navigator.of(context).pop();
                  _pickImageFromGallery(context);
                },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take Photo'),
              subtitle: const Text('Use camera to take a new photo'),
                              onTap: () {
                  Navigator.of(context).pop();
                  _pickImageFromCamera(context);
                },
            ),
          ],
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

  Future<void> _pickImageFromGallery(BuildContext context) async {
    // Get the uiStateNotifier before async operations
    final uiStateNotifier = ProviderScope.containerOf(context).read(uIStateProvider.notifier);
    
    try {
      final ImagePicker picker = ImagePicker();
      
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 85,
      );
      
      if (image != null && context.mounted) {
        
        // Convert image to data URL for web compatibility
        final bytes = await image.readAsBytes();
        
        final base64String = base64Encode(bytes);
        final dataUrl = 'data:image/jpeg;base64,$base64String';
        
        _updateAvatarImage(uiStateNotifier, dataUrl);
      }
    } catch (e) {
      // Handle error
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error picking image: $e')),
        );
      }
    }
  }

  Future<void> _pickImageFromCamera(BuildContext context) async {
    // Get the uiStateNotifier before async operations
    final uiStateNotifier = ProviderScope.containerOf(context).read(uIStateProvider.notifier);
    
    try {
      final ImagePicker picker = ImagePicker();
      
      final XFile? image = await picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 85,
      );
      
      if (image != null && context.mounted) {
        
        // Convert image to data URL for web compatibility
        final bytes = await image.readAsBytes();
        
        final base64String = base64Encode(bytes);
        final dataUrl = 'data:image/jpeg;base64,$base64String';
        
        _updateAvatarImage(uiStateNotifier, dataUrl);
      }
    } catch (e) {
      // Handle error
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error taking photo: $e')),
        );
      }
    }
  }

  void _updateAvatarImage(UIState uiStateNotifier, String imagePath) {
    print('🖼️ Updating avatar image...');
    print('📁 Image path: ${imagePath.substring(0, 50)}...'); // Show first 50 chars
    print('🔧 Has custom image before: ${uiStateNotifier.state.hasCustomImage}');
    print('🖼️ Avatar image path before: ${uiStateNotifier.state.avatarImagePath}');
    
    // Create a single instruction that updates both properties at once
    uiStateNotifier.applyInstruction(
      UIInstruction(
        component: 'avatar',
        property: 'image',
        value: imagePath,
      ),
    );
    
    print('✅ Avatar image update instruction applied');
    print('🔧 Has custom image after: ${uiStateNotifier.state.hasCustomImage}');
    print('🖼️ Avatar image path after: ${uiStateNotifier.state.avatarImagePath}');
  }

  void _deleteAvatarImage(BuildContext context) {
    final uiStateNotifier = ProviderScope.containerOf(context).read(uIStateProvider.notifier);
    uiStateNotifier.applyInstruction(
      UIInstruction(
        component: 'avatar',
        property: 'deleteImage',
        value: null,
      ),
    );
  }

  ImageProvider _buildBackgroundImage(String imagePath) {
    if (imagePath.startsWith('data:')) {
      // Handle data URL - extract base64 data
      try {
        final dataUri = Uri.parse(imagePath);
        
        if (dataUri.data != null) {
          final bytes = dataUri.data!.contentAsBytes();
          return MemoryImage(bytes);
        }
        
        // Fallback: try to parse manually if Uri.parse fails
        final parts = imagePath.split(',');
        if (parts.length == 2) {
          final base64Data = parts[1];
          final bytes = base64Decode(base64Data);
          return MemoryImage(bytes);
        }
      } catch (e) {
        print('Error parsing data URL: $e');
        print('Image path: $imagePath');
      }
      
      // Return a placeholder if parsing fails
      return const AssetImage('assets/placeholder.png');
    }
    
    // Fallback to asset image for backward compatibility
    return AssetImage(imagePath);
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

// Background Pattern Painters
class DotsPatternPainter extends CustomPainter {
  final Color color;
  final double dotSize;
  final double spacing;

  DotsPatternPainter({
    required this.color,
    required this.dotSize,
    required this.spacing,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    for (double x = spacing; x < size.width; x += spacing) {
      for (double y = spacing; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), dotSize / 2, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class StripesPatternPainter extends CustomPainter {
  final Color color;
  final double stripeWidth;
  final double spacing;

  StripesPatternPainter({
    required this.color,
    required this.stripeWidth,
    required this.spacing,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawRect(
        Rect.fromLTWH(x, 0, stripeWidth, size.height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class GridPatternPainter extends CustomPainter {
  final Color color;
  final double gridSize;

  GridPatternPainter({
    required this.color,
    required this.gridSize,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    for (double x = 0; x < size.width; x += gridSize) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += gridSize) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class WavesPatternPainter extends CustomPainter {
  final Color color;
  final double waveHeight;
  final double waveLength;

  WavesPatternPainter({
    required this.color,
    required this.waveHeight,
    required this.waveLength,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final path = Path();
    path.moveTo(0, size.height / 2);

    for (double x = 0; x < size.width; x += waveLength / 4) {
      final y = size.height / 2 + 
          waveHeight * sin((x / waveLength) * 2 * 3.14159);
      path.lineTo(x, y);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
