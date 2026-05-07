import 'package:flutter/material.dart';
import 'package:fab_menu_expressive/fab_menu_expressive.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FAB Menu Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _expanded = false;

  void _onMenuItemPressed(String action) {
    debugPrint('Pressed $action');
    setState(() {
      _expanded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('M3 Expressive FAB Menu')),
      body: const Center(child: Text('Tap the FAB to open the menu')),
      floatingActionButton: FloatingActionButtonMenu(
        expanded: _expanded,
        button: ToggleFloatingActionButton(
          checked: _expanded,
          onCheckedChange: (checked) {
            setState(() {
              _expanded = checked;
            });
          },
          child: AnimatedRotation(
            turns: _expanded ? 0.125 : 0,
            duration: const Duration(milliseconds: 200),
            child: const Icon(Icons.add),
          ),
        ),
        children: [
          FloatingActionButtonMenuItem(
            onPressed: () => _onMenuItemPressed('Document'),
            icon: const Icon(Icons.email),
            label: const Text('Document'),
          ),
          FloatingActionButtonMenuItem(
            onPressed: () => _onMenuItemPressed('Message'),
            icon: const Icon(Icons.chat_bubble_outline),
            label: const Text('Message'),
          ),
          FloatingActionButtonMenuItem(
            onPressed: () => _onMenuItemPressed('Folder'),
            icon: const Icon(Icons.folder_shared_outlined),
            label: const Text('Folder'),
          ),
        ],
      ),
    );
  }
}
