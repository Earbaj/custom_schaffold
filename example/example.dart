// example/example.dart
import 'package:custom_scaffold/custom_scaffold.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Scaffold Example',
      home: CustomScaffold(
        appBar: AppBar(
          title: const Text('Custom Scaffold Example'),
        ),
        backgroundColor: Colors.lightBlue[50],
        isDark: false,
        lightBackgroundAsset: 'assets/light_background.png',
        darkBackgroundAsset: 'assets/dark_background.png',
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
        bottomNav: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
        child: const Center(
          child:  Text(
            'Hello from Custom Scaffold!',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
