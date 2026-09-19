// example/example.dart
import 'package:custom_scaffold/custom_scaffold.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const CustomScaffoldDemoApp());
}

class CustomScaffoldDemoApp extends StatefulWidget {
  const CustomScaffoldDemoApp({super.key});

  @override
  State<CustomScaffoldDemoApp> createState() => _CustomScaffoldDemoAppState();
}

class _CustomScaffoldDemoAppState extends State<CustomScaffoldDemoApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void _toggleTheme(ThemeMode mode) {
    setState(() {
      _themeMode = mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CustomScaffold Demo',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorSchemeSeed: Colors.deepPurple,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.deepPurple,
      ),
      home: DemoScreen(
        currentThemeMode: _themeMode,
        onThemeChanged: _toggleTheme,
      ),
    );
  }
}

class DemoScreen extends StatefulWidget {
  final ThemeMode currentThemeMode;
  final ValueChanged<ThemeMode> onThemeChanged;

  const DemoScreen({
    super.key,
    required this.currentThemeMode,
    required this.onThemeChanged,
  });

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  int _selectedIndex = 0;
  bool _useGradient = true;
  bool _enableBlur = false;
  bool _isLoading = false;
  bool _useSafeArea = true;

  void _triggerLoading() {
    setState(() => _isLoading = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      // Standard Scaffold properties
      appBar: AppBar(
        title: const Text('CustomScaffold v2.0 Demo'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Simulate API Call',
            onPressed: _triggerLoading,
          ),
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            ),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.deepPurple),
              child: Text(
                'Navigation Drawer',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
            ),
            ListTile(
              leading: Icon(Icons.palette),
              title: Text('Theme settings'),
            ),
          ],
        ),
      ),
      endDrawer: Drawer(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Theme Selector',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                SegmentedButton<ThemeMode>(
                  segments: const [
                    ButtonSegment(
                      value: ThemeMode.system,
                      label: Text('Auto'),
                      icon: Icon(Icons.brightness_auto),
                    ),
                    ButtonSegment(
                      value: ThemeMode.light,
                      label: Text('Light'),
                      icon: Icon(Icons.light_mode),
                    ),
                    ButtonSegment(
                      value: ThemeMode.dark,
                      label: Text('Dark'),
                      icon: Icon(Icons.dark_mode),
                    ),
                  ],
                  selected: {widget.currentThemeMode},
                  onSelectionChanged: (newSelection) {
                    widget.onThemeChanged(newSelection.first);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      // Background & Glassmorphism
      gradient: _useGradient
          ? const LinearGradient(
              colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )
          : null,
      backgroundColor: _useGradient ? null : Colors.grey[200],
      blurSigma: _enableBlur ? 16.0 : null,
      blurColor: _enableBlur ? Colors.black26 : null,
      animateThemeChange: true,

      // Loading overlay
      isLoading: _isLoading,
      loadingWidget: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(color: Colors.white),
          SizedBox(height: 16),
          Text(
            'Fetching data...',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),

      // Layout constraints
      useSafeArea: _useSafeArea,
      maxWidth: 600,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),

      // Navigation & FAB
      floatingActionButton: FloatingActionButton(
        onPressed: _triggerLoading,
        tooltip: 'Trigger Loading',
        child: const Icon(Icons.hourglass_top),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard), label: 'Controls'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'About'),
        ],
      ),

      // Main content
      child: ListView(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            color: const Color(0xD9FFFFFF),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Interactive Controls',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  SwitchListTile(
                    title: const Text('Gradient Background'),
                    subtitle:
                        const Text('Toggle between gradient and solid color'),
                    value: _useGradient,
                    onChanged: (val) => setState(() => _useGradient = val),
                  ),
                  SwitchListTile(
                    title: const Text('Frosted Glass Blur'),
                    subtitle: const Text('Apply BackdropFilter blurSigma'),
                    value: _enableBlur,
                    onChanged: (val) => setState(() => _enableBlur = val),
                  ),
                  SwitchListTile(
                    title: const Text('Use SafeArea'),
                    subtitle: const Text('Guard against notch and bottom bar'),
                    value: _useSafeArea,
                    onChanged: (val) => setState(() => _useSafeArea = val),
                  ),
                  const SizedBox(height: 12),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: _triggerLoading,
                      icon: const Icon(Icons.play_arrow),
                      label: const Text('Test Loading Overlay (2s)'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
