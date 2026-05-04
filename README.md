# FAB Menu

A Flutter implementation of the Material 3 Expressive FAB Menu, replicating the component built by Google in Jetpack Compose.

This package provides a minimal, accurate, and animated implementation of the FAB Menu pattern, featuring unified pill-shaped menu items and staggered animations.

## Features

- **Material 3 Expressive Design**: Follows the latest Material 3 guidelines for FAB menus.
- **Unified Pill Items**: Menu items are rendered as cohesive pills combining icons and labels.
- **Staggered Animations**: Smooth staggered entry and exit animations for menu items.
- **Flexible Alignment**: Automatically adjusts layout based on screen position.
- **Minimal API**: Designed to be familiar to Jetpack Compose developers.

## Getting started

Add the dependency to your `pubspec.yaml`:

```yaml
dependencies:
  fab_menu_expressive: ^0.0.1
```

## Usage

```dart
import 'package:flutter/material.dart';
import 'package:fab_menu_expressive/fab_menu_expressive.dart';

class MyPage extends StatefulWidget {
  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButtonMenu(
        expanded: _expanded,
        button: ToggleFloatingActionButton(
          checked: _expanded,
          onCheckedChange: (checked) => setState(() => _expanded = checked),
          child: AnimatedRotation(
            turns: _expanded ? 0.125 : 0,
            duration: const Duration(milliseconds: 200),
            child: const Icon(Icons.add),
          ),
        ),
        children: [
          FloatingActionButtonMenuItem(
            onPressed: () => print('Document'),
            icon: const Icon(Icons.email),
            label: const Text('Document'),
          ),
          FloatingActionButtonMenuItem(
            onPressed: () => print('Message'),
            icon: const Icon(Icons.chat_bubble_outline),
            label: const Text('Message'),
          ),
        ],
      ),
    );
  }
}
```

## Additional information

For more details on the design principles behind this component, refer to the [Material 3 Expressive FAB Menu documentation](https://m3.material.io/components/floating-action-button/guidelines#81d1e43e-7b7c-4c6e-8d8a-6b8a7f7c6d5e).

Contributions and issues are welcome on the [GitHub repository](https://github.com/canine-labs/fab-menu).
