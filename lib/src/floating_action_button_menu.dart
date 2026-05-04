import 'package:flutter/material.dart';
import 'floating_action_button_menu_item.dart';

/// A container for a Material 3 Expressive Floating Action Button Menu.
///
/// It manages the layout and staggered animations of [FloatingActionButtonMenuItem]s
/// when [expanded] is toggled.
class FloatingActionButtonMenu extends StatefulWidget {
  /// Whether the menu is currently expanded.
  final bool expanded;

  /// The main FAB that toggles the menu.
  /// Typically a [ToggleFloatingActionButton].
  final Widget button;

  /// The list of items to display in the menu.
  final List<FloatingActionButtonMenuItem> children;

  /// The alignment of the menu. Defaults to [Alignment.bottomRight].
  final Alignment alignment;

  const FloatingActionButtonMenu({
    super.key,
    required this.expanded,
    required this.button,
    required this.children,
    this.alignment = Alignment.bottomRight,
  });

  @override
  State<FloatingActionButtonMenu> createState() =>
      _FloatingActionButtonMenuState();
}

class _FloatingActionButtonMenuState extends State<FloatingActionButtonMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      value: widget.expanded ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 250),
      reverseDuration: const Duration(milliseconds: 200),
      vsync: this,
    );
  }

  @override
  void didUpdateWidget(FloatingActionButtonMenu oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.expanded != oldWidget.expanded) {
      if (widget.expanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final crossAxisAlignment = widget.alignment.x > 0
        ? CrossAxisAlignment.end
        : widget.alignment.x < 0
        ? CrossAxisAlignment.start
        : CrossAxisAlignment.center;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: crossAxisAlignment,
      children: [
        ...List.generate(widget.children.length, (index) {
          // Reverse index so the top item is the last to animate in and first to animate out
          final childIndex = widget.children.length - 1 - index;

          final step = 1.0 / widget.children.length;
          final start = childIndex * step * 0.5;
          final end = start + 0.5;

          final animation = CurvedAnimation(
            parent: _controller,
            curve: Interval(start, end, curve: Curves.easeOutCubic),
          );

          final child = widget.children[index];

          return Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: animation.drive(
                  Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero),
                ),
                child: child,
              ),
            ),
          );
        }),
        widget.button,
      ],
    );
  }
}
