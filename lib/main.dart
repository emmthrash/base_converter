import 'package:flutter/material.dart';

import 'screens/about_screen.dart';
import 'screens/converter_screen.dart';
import 'screens/learn_practice_screen.dart';
import 'screens/manual_screen.dart';
import 'screens/settings_screen.dart';

void main() {
  runApp(const BaseConverterApp());
}

class BaseConverterApp extends StatefulWidget {
  const BaseConverterApp({super.key});

  @override
  State<BaseConverterApp> createState() => _BaseConverterAppState();
}

class _BaseConverterAppState extends State<BaseConverterApp> {
  bool darkMode = false;

  void changeTheme(bool value) {
    setState(() {
      darkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Base Converter',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
      home: HomeScreen(
        darkMode: darkMode,
        onDarkModeChanged: changeTheme,
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final bool darkMode;
  final ValueChanged<bool> onDarkModeChanged;

  const HomeScreen({
    super.key,
    required this.darkMode,
    required this.onDarkModeChanged,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  final List<String> titles = [
    'Base Converter',
    'User Manual',
    'Learn & Practice',
    'About',
    'Settings',
  ];

  @override
  Widget build(BuildContext context) {
    final screens = [
      const ConverterScreen(),
      const ManualScreen(),
      const LearnPracticeScreen(),
      const AboutScreen(),
      SettingsScreen(
        darkMode: widget.darkMode,
        onDarkModeChanged: widget.onDarkModeChanged,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          titles[selectedIndex],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      drawer: Drawer(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                DrawerHeader(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.swap_horiz_rounded,
                        size: 50,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Base Converter',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                ListTile(
                  leading: const Icon(Icons.calculate_rounded),
                  title: const Text('Converter'),
                  selected: selectedIndex == 0,
                  onTap: () {
                    setState(() {
                      selectedIndex = 0;
                    });
                    Navigator.pop(context);
                  },
                ),

                ListTile(
                  leading: const Icon(Icons.menu_book_rounded),
                  title: const Text('User Manual'),
                  selected: selectedIndex == 1,
                  onTap: () {
                    setState(() {
                      selectedIndex = 1;
                    });
                    Navigator.pop(context);
                  },
                ),

                ListTile(
                  leading: const Icon(Icons.school_rounded),
                  title: const Text('Learn & Practice'),
                  selected: selectedIndex == 2,
                  onTap: () {
                    setState(() {
                      selectedIndex = 2;
                    });
                    Navigator.pop(context);
                  },
                ),

                ListTile(
                  leading: const Icon(Icons.info_outline_rounded),
                  title: const Text('About'),
                  selected: selectedIndex == 3,
                  onTap: () {
                    setState(() {
                      selectedIndex = 3;
                    });
                    Navigator.pop(context);
                  },
                ),

                ListTile(
                  leading: const Icon(Icons.settings_rounded),
                  title: const Text('Settings'),
                  selected: selectedIndex == 4,
                  onTap: () {
                    setState(() {
                      selectedIndex = 4;
                    });
                    Navigator.pop(context);
                  },
                ),

                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Version 1.0.0',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: screens[selectedIndex],
    );
  }
}
