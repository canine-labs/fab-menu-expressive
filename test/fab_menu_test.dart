import 'package:flutter_test/flutter_test.dart';
import 'package:fab_menu_expressive/fab_menu_expressive.dart';
import 'package:flutter/material.dart';

Widget _buildMenu({
  required bool expanded,
  ValueChanged<bool>? onCheckedChange,
  VoidCallback? onItemPressed,
}) {
  return MaterialApp(
    home: Scaffold(
      floatingActionButton: FloatingActionButtonMenu(
        expanded: expanded,
        button: ToggleFloatingActionButton(
          checked: expanded,
          onCheckedChange: onCheckedChange ?? (_) {},
          child: const Icon(Icons.add),
        ),
        children: [
          FloatingActionButtonMenuItem(
            onPressed: onItemPressed ?? () {},
            icon: const Icon(Icons.edit),
            label: const Text('Edit'),
          ),
        ],
      ),
    ),
  );
}

void main() {
  testWidgets('FABMenu toggles expanded state and rebuilds', (tester) async {
    bool expanded = false;

    await tester.pumpWidget(
      StatefulBuilder(
        builder: (context, setState) => _buildMenu(
          expanded: expanded,
          onCheckedChange: (val) => setState(() => expanded = val),
        ),
      ),
    );

    expect(find.byType(ToggleFloatingActionButton), findsOneWidget);

    await tester.tap(find.byType(ToggleFloatingActionButton));
    await tester.pumpAndSettle();

    expect(expanded, isTrue);
    expect(find.byType(FloatingActionButtonMenuItem), findsOneWidget);
  });

  testWidgets('Collapsed menu items pass touches through to widgets below',
      (tester) async {
    bool tapReceived = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Align(
            alignment: Alignment.bottomRight,
            child: GestureDetector(
              onTap: () => tapReceived = true,
              behavior: HitTestBehavior.opaque,
              child: const SizedBox(width: 300, height: 300),
            ),
          ),
          floatingActionButton: FloatingActionButtonMenu(
            expanded: false,
            button: ToggleFloatingActionButton(
              checked: false,
              onCheckedChange: (_) {},
              child: const Icon(Icons.add),
            ),
            children: [
              FloatingActionButtonMenuItem(
                onPressed: () {},
                icon: const Icon(Icons.edit),
                label: const Text('Edit'),
              ),
            ],
          ),
        ),
      ),
    );

    // Tap in the region where collapsed (invisible) menu items sit.
    // IgnorePointer must let this through to the GestureDetector behind.
    await tester.tapAt(const Offset(700, 500));
    await tester.pump();

    expect(tapReceived, isTrue,
        reason: 'Collapsed menu items should not absorb taps');
  });

  testWidgets('Expanded menu items fire onPressed', (tester) async {
    bool pressed = false;

    await tester.pumpWidget(
      StatefulBuilder(
        builder: (context, setState) => MaterialApp(
          home: Scaffold(
            floatingActionButton: FloatingActionButtonMenu(
              expanded: true,
              button: ToggleFloatingActionButton(
                checked: true,
                onCheckedChange: (_) {},
                child: const Icon(Icons.add),
              ),
              children: [
                FloatingActionButtonMenuItem(
                  onPressed: () => pressed = true,
                  icon: const Icon(Icons.edit),
                  label: const Text('Edit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    await tester.tap(find.byType(FloatingActionButtonMenuItem));
    await tester.pump();

    expect(pressed, isTrue,
        reason: 'Expanded menu items must be tappable');
  });
}
