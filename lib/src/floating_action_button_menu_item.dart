import 'package:flutter/material.dart';

/// An item within a [FloatingActionButtonMenu].
///
/// Material 3 Expressive FAB menu items must include both an icon and a label
/// rendered together in a unified pill-shaped container.
class FloatingActionButtonMenuItem extends StatelessWidget {
  /// Callback when the item is pressed.
  final VoidCallback onPressed;

  /// The icon widget to display.
  final Widget icon;

  /// The label widget to display.
  final Widget label;

  /// The background color of the item's container.
  final Color? containerColor;

  /// The color of the icon and label text.
  final Color? contentColor;

  /// Whether the label should be on the right side of the icon.
  /// Defaults to true (icon on left, label on right) as seen in the
  /// standard M3 Expressive layout.
  final bool labelOnRight;

  const FloatingActionButtonMenuItem({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.label,
    this.containerColor,
    this.contentColor,
    this.labelOnRight = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final color = containerColor ?? theme.colorScheme.secondaryContainer;
    final onColor = contentColor ?? theme.colorScheme.onSecondaryContainer;

    final labelWidget = DefaultTextStyle(
      style: theme.textTheme.labelLarge!.copyWith(
        color: onColor,
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
      child: label,
    );

    final iconWidget = IconTheme.merge(
      data: IconThemeData(color: onColor, size: 24),
      child: icon,
    );

    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 56.0),
      child: Material(
        color: color,
        shape: const StadiumBorder(),
        clipBehavior: Clip.antiAlias,
        elevation: 0,
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 8.0,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!labelOnRight) ...[labelWidget, const SizedBox(width: 8)],
                iconWidget,
                if (labelOnRight) ...[const SizedBox(width: 8), labelWidget],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
