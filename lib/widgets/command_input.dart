import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state/ui_state.dart';
import '../services/command_parser.dart';
import '../services/crm_service.dart';
import '../core/app_constants.dart';
import '../core/app_theme.dart';
import '../core/app_colors.dart';

class CommandInput extends ConsumerStatefulWidget {
  const CommandInput({super.key});

  @override
  ConsumerState<CommandInput> createState() => _CommandInputState();
}

class _CommandInputState extends ConsumerState<CommandInput> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isProcessing = false;
  String _lastCommand = '';
  bool _showHelp = false;

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final uiState = ref.watch(uIStateProvider);
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingM),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withAlpha(20),
            blurRadius: AppTheme.elevationL,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_showHelp) _buildHelpSection(theme),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  decoration: InputDecoration(
                    hintText: 'Try: "background blue" or "avatar circle && spacing tight"',
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.spacingM,
                      vertical: AppTheme.spacingM,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(_showHelp ? Icons.help_outline : Icons.help),
                      onPressed: () {
                        setState(() {
                          _showHelp = !_showHelp;
                        });
                      },
                    ),
                  ),
                  onSubmitted: (_) => _processCommand(uiState),
                  textInputAction: TextInputAction.send,
                  textCapitalization: TextCapitalization.sentences,
                ),
              ),
              const SizedBox(width: AppTheme.spacingS),
              _isProcessing
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : IconButton(
                      onPressed: () => _processCommand(uiState),
                      icon: const Icon(Icons.send),
                      style: IconButton.styleFrom(
                        backgroundColor: uiState.buttonColor,
                        foregroundColor: AppColors.cardBackground,
                      ),
                    ),
            ],
          ),
          if (_lastCommand.isNotEmpty) ...[
            const SizedBox(height: AppTheme.spacingS),
            Row(
              children: [
                                  Icon(
                    _isProcessing ? Icons.hourglass_empty : Icons.check_circle,
                    color: _isProcessing 
                        ? theme.colorScheme.tertiary 
                        : theme.colorScheme.primary,
                    size: 16,
                  ),
                const SizedBox(width: AppTheme.spacingS),
                Expanded(
                  child: Text(
                    'Last command: $_lastCommand',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildHelpSection(ThemeData theme) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spacingM),
      padding: const EdgeInsets.all(AppTheme.spacingM),
      decoration: BoxDecoration(
                 color: theme.colorScheme.primaryContainer.withAlpha(20),
         borderRadius: BorderRadius.circular(AppTheme.radiusM),
         border: Border.all(
           color: theme.colorScheme.primaryContainer.withAlpha(40),
         ),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.4,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    AppConstants.helpTitle,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${AppConstants.totalSupportedCommands}+ Commands',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppTheme.spacingS),
              Text(
                AppConstants.helpSubtitle,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: AppTheme.spacingS),
              Wrap(
                spacing: AppTheme.spacingS,
                runSpacing: AppTheme.spacingXS,
                children: AppConstants.commandExamples.map((command) => 
                  _buildHelpChip(command, theme),
                ).toList(),
              ),
              const SizedBox(height: AppTheme.spacingM),
              
              // Command Combination Hints
              Container(
                padding: const EdgeInsets.all(AppTheme.spacingM),
                decoration: BoxDecoration(
                  color: theme.colorScheme.secondaryContainer.withAlpha(30),
                  borderRadius: BorderRadius.circular(AppTheme.radiusS),
                  border: Border.all(
                    color: theme.colorScheme.secondaryContainer.withAlpha(50),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.link,
                          size: 16,
                          color: theme.colorScheme.secondary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          AppConstants.commandCombinationTitle,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.secondary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppTheme.spacingXS),
                    Text(
                      AppConstants.commandCombinationHint,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingXS),
                    ...AppConstants.commandCombinationExamples.map((example) => 
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(
                          '• $example',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingXS),
                    Text(
                      'Examples:',
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.secondary,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingXS),
                    ...AppConstants.commandCombinationUsage.map((usage) => 
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(
                          '• "$usage"',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHelpChip(String command, ThemeData theme) {
    return ActionChip(
      label: Text(command),
      onPressed: () {
        _controller.text = command;
        _focusNode.requestFocus();
      },
      backgroundColor: theme.colorScheme.primaryContainer,
      labelStyle: TextStyle(color: theme.colorScheme.onPrimaryContainer),
    );
  }

  Future<void> _processCommand(UIStateData uiState) async {
    final command = _controller.text.trim();
    if (command.isEmpty) return;

    setState(() {
      _isProcessing = true;
      _lastCommand = command;
    });

    try {
      // Parse the command
      final instruction = CommandParser.parseCommand(command);
      
      if (instruction != null) {
        // Apply the instruction
        ref.read(uIStateProvider.notifier).applyInstruction(instruction);
        
        // Show success feedback
        _showSuccessMessage(command);
        
        // Save command to CRM history
        await CRMService.saveCommandHistory(command, true);
        
      } else {
        // Check for special commands
        if (command.toLowerCase().contains('save')) {
          await _handleSaveLayout(uiState, command);
        } else if (command.toLowerCase().contains('load')) {
          await _handleLoadLayout(uiState, command);
        } else {
          // Show error for unknown command
          _showErrorMessage('${AppConstants.errorUnknownCommand}: $command');
          
          // Save failed command to CRM history
          await CRMService.saveCommandHistory(command, false);
        }
      }
    } catch (e) {
      _showErrorMessage('Error: $e');
      
      // Save failed command to CRM history
      await CRMService.saveCommandHistory(command, false);
    } finally {
      setState(() {
        _isProcessing = false;
      });
      
      _controller.clear();
      _focusNode.unfocus();
    }
  }

  void _showSuccessMessage(String command) {
    final theme = Theme.of(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Applied: $command'),
        backgroundColor: theme.colorScheme.primary,
        duration: AppConstants.snackBarDurationShort,
      ),
    );
  }

  void _showErrorMessage(String message) {
    final theme = Theme.of(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: theme.colorScheme.error,
        duration: AppConstants.snackBarDurationNormal,
      ),
    );
  }

  Future<void> _handleSaveLayout(UIStateData uiState, String command) async {
    final layoutName = command.toLowerCase().contains('theme') 
        ? 'My Theme' 
        : 'Layout ${DateTime.now().millisecond}';
    
    final success = await CRMService.saveLayout(uiState, layoutName);
    
    if (mounted) {
              final theme = Theme.of(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              success 
                  ? 'Layout saved as "$layoutName"' 
                  : AppConstants.errorSaveFailed,
            ),
            backgroundColor: success 
                ? theme.colorScheme.primary 
                : theme.colorScheme.error,
            duration: AppConstants.snackBarDurationNormal,
          ),
        );
    }
  }

  Future<void> _handleLoadLayout(UIStateData uiState, String command) async {
    final savedLayouts = await CRMService.getSavedLayouts();
    
    if (savedLayouts.isEmpty) {
      if (mounted) {
        final theme = Theme.of(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(AppConstants.errorNoLayouts),
            backgroundColor: theme.colorScheme.tertiary,
            duration: AppConstants.snackBarDurationNormal,
          ),
        );
      }
      return;
    }

    // For demo, load the first available layout
    final layoutName = savedLayouts.first;
    final loadedState = await CRMService.loadLayout(layoutName);
    
    if (loadedState != null) {
      // Apply the loaded state
      ref.read(uIStateProvider.notifier).fromJson(loadedState.toJson());
      
      if (mounted) {
        final theme = Theme.of(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Loaded layout: $layoutName'),
            backgroundColor: theme.colorScheme.primary,
            duration: AppConstants.snackBarDurationNormal,
          ),
        );
      }
    } else {
      if (mounted) {
        final theme = Theme.of(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${AppConstants.errorLoadFailed}: $layoutName'),
            backgroundColor: theme.colorScheme.error,
            duration: AppConstants.snackBarDurationNormal,
          ),
        );
      }
    }
  }
}
