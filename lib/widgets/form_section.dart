import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state/ui_state.dart';
import '../models/ui_instruction.dart';





class FormSection extends ConsumerStatefulWidget {
  const FormSection({super.key});

  @override
  ConsumerState<FormSection> createState() => _FormSectionState();
}

class _FormSectionState extends ConsumerState<FormSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _roleController = TextEditingController();
  final _headlineController = TextEditingController();
  bool _isUpdating = false;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with current values
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final uiState = ref.read(uIStateProvider);
      _nameController.text = uiState.profileName;
      _roleController.text = uiState.profileRole;
      _headlineController.text = uiState.profileHeadline;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _roleController.dispose();
    _headlineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        child: Padding(
          padding: EdgeInsets.all(uiState.layoutSpacing),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Profile Editor',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: uiState.fontColorTransparent ? Colors.transparent : uiState.fontColor,
                  ),
                ),
              const SizedBox(height: 16),
              if (uiState.textFieldNameVisible) ...[
                _buildFormField(context, 'Name', Icons.person, uiState, _nameController),
                const SizedBox(height: 16),
              ],
              if (uiState.textFieldRoleVisible) ...[
                _buildFormField(context, 'Role', Icons.work, uiState, _roleController),
                const SizedBox(height: 16),
              ],
              if (uiState.textFieldHeadlineVisible) ...[
                _buildFormField(context, 'Headline', Icons.description, uiState, _headlineController),
                const SizedBox(height: 16),
              ],
              const SizedBox(height: 24),
              _buildSubmitButton(context, uiState),
            ],
          ),
        ),
      ),
    ));
  }

  Widget _buildFormField(
    BuildContext context,
    String label,
    IconData icon,
    UIStateData uiState,
    TextEditingController controller,
  ) {
    // Determine the actual colors based on transparency flags
    final actualBackgroundColor = uiState.textFieldBackgroundColorTransparent 
        ? Colors.transparent 
        : uiState.textFieldBackgroundColor;
    final actualBorderColor = uiState.textFieldBorderColorTransparent 
        ? Colors.transparent 
        : uiState.textFieldBorderColor;
    
    // Use app font color for all text elements, respecting transparency
    final textColor = uiState.fontColorTransparent 
        ? Colors.transparent 
        : uiState.fontColor;
    
    return TextFormField(
      controller: controller,
      style: TextStyle(
        color: textColor, // Input text color
        fontSize: 16,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: textColor, // Label text color
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        hintText: 'Enter $label', // Add hint text
        hintStyle: TextStyle(
          color: textColor.withAlpha(150), // Hint text color (slightly transparent)
          fontSize: 14,
        ),
        prefixIcon: Icon(
          icon, 
          color: textColor, // Icon color
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: actualBorderColor,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: actualBorderColor,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: actualBorderColor,
            width: 2,
          ),
        ),
        filled: true,
        fillColor: actualBackgroundColor,
      ),
      minLines: 1,
      maxLines: label == 'Headline' ? 3 : 1,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return '$label is required';
        }
        return null;
      },
    );
  }

  Widget _buildSubmitButton(BuildContext context, UIStateData uiState) {
    final theme = Theme.of(context);
    
    // Use app font color for button text, respecting transparency
    final textColor = uiState.fontColorTransparent 
        ? Colors.transparent 
        : uiState.fontColor;
    
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isUpdating ? null : _handleUpdateProfile,
        style: ElevatedButton.styleFrom(
          backgroundColor: uiState.buttonColorTransparent ? Colors.transparent : uiState.buttonColor,
          foregroundColor: textColor, // Button text color
          padding: EdgeInsets.symmetric(
            vertical: uiState.layoutSpacing,
            horizontal: uiState.layoutSpacing,
          ),
          minimumSize: const Size(1000, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 1,
        ),
        child: _isUpdating
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(textColor),
                ),
              )
            : Text(
                'Update Profile',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }

  void _handleUpdateProfile() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isUpdating = true;
    });

    try {
      final uiStateNotifier = ref.read(uIStateProvider.notifier);
      final uiState = ref.read(uIStateProvider);
      
      // Update profile name (only if visible)
      if (uiState.textFieldNameVisible) {
        uiStateNotifier.applyInstruction(
          UIInstruction(
            component: 'avatar',
            property: 'profileName',
            value: _nameController.text.trim(),
          ),
        );
      }

      // Update profile role (only if visible)
      if (uiState.textFieldRoleVisible) {
        uiStateNotifier.applyInstruction(
          UIInstruction(
            component: 'avatar',
            property: 'profileRole',
            value: _roleController.text.trim(),
          ),
        );
      }

      // Update profile headline (only if visible)
      if (uiState.textFieldHeadlineVisible) {
        uiStateNotifier.applyInstruction(
          UIInstruction(
            component: 'avatar',
            property: 'profileHeadline',
            value: _headlineController.text.trim(),
          ),
        );
      }

      // Show success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile updated successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error updating profile: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isUpdating = false;
        });
      }
    }
  }
}
