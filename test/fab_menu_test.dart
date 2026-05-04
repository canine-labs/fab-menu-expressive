import 'package:flutter_test/flutter_test.dart';
import 'package:fab_menu_expressive/fab_menu_expressive.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('FABMenu toggles expanded state', (WidgetTester tester) async {
    bool expanded = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          floatingActionButton: FloatingActionButtonMenu(
            expanded: expanded,
            button: ToggleFloatingActionButton(
              checked: expanded,
              onCheckedChange: (val) => expanded = val,
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

    expect(find.byType(ToggleFloatingActionButton), findsOneWidget);
    // Initially not expanded, items should be hidden or at 0 opacity
    // In our implementation they are always in the tree but with opacity 0

    await tester.tap(find.byType(ToggleFloatingActionButton));
    expect(expanded, isTrue);
  });
}
