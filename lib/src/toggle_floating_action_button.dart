import 'package:flutter/material.dart';

enum FABSize { small, medium, large }

/// A toggleable Floating Action Button that follows Material 3 Expressive guidelines.
class ToggleFloatingActionButton extends StatelessWidget {
  /// Whether the button is currently checked (expanded).
  final bool checked;

  /// Callback when the checked state changes.
  final ValueChanged<bool> onCheckedChange;

  /// The widget to display inside the button.
  /// Typically an [Icon] that animates based on [checked].
  final Widget child;

  /// The background color of the FAB.
  final Color? containerColor;

  /// The color of the content (icon/label) inside the FAB.
  final Color? contentColor;

  /// The size of the FAB.
  final FABSize size;

  const ToggleFloatingActionButton({
    super.key,
    required this.checked,
    required this.onCheckedChange,
    required this.child,
    this.containerColor,
    this.contentColor,
    this.size = FABSize.medium,
  });

  @override
  Widget build(BuildContext context) {
    return switch (size) {
      FABSize.large => FloatingActionButton.large(
        onPressed: () => onCheckedChange(!checked),
        backgroundColor: containerColor,
        foregroundColor: contentColor,
        shape: checked == true ? const CircleBorder() : null,
        child: child,
      ),
      FABSize.medium => FloatingActionButton(
        onPressed: () => onCheckedChange(!checked),
        backgroundColor: containerColor,
        foregroundColor: contentColor,
        shape: checked == true ? const CircleBorder() : null,
        child: child,
      ),
      FABSize.small => FloatingActionButton.small(
        onPressed: () => onCheckedChange(!checked),
        backgroundColor: containerColor,
        foregroundColor: contentColor,
        shape: checked == true ? const CircleBorder() : null,
        child: child,
      ),
    };
  }
}
