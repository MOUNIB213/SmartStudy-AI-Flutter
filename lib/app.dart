import 'package:flutter/material.dart';
import 'features/home/home_screen.dart';
import 'features/settings/settings_screen.dart';

class SmartStudyApp extends StatefulWidget {
  const SmartStudyApp({super.key});

  @override
  State<SmartStudyApp> createState() => _SmartStudyAppState();
}

class _SmartStudyAppState extends State<SmartStudyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void _setThemeMode(ThemeMode mode) => setState(() => _themeMode = mode);

  @override
  Widget build(BuildContext context) {
    const seed = Color(0xFF6750A4);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SmartStudy AI',
      themeMode: _themeMode,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: seed),
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF8F7FC),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: seed,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      home: HomeScreen(
        onOpenSettings: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => SettingsScreen(
              currentTheme: _themeMode,
              onThemeChanged: _setThemeMode,
            ),
          ),
        ),
      ),
    );
  }
}
