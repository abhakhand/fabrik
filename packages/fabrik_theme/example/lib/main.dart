import 'package:fabrik_theme/fabrik_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fabrik Theme Example',
      themeMode: ThemeMode.system,
      theme: FabrikTheme.create(
        brightness: Brightness.light,
        colors: AppThemeColors.light,
        fontFamily: 'Roboto',
      ),
      darkTheme: FabrikTheme.create(
        brightness: Brightness.dark,
        colors: AppThemeColors.dark,
        fontFamily: 'Roboto',
      ),
      home: const HomePage(),
    );
  }
}

/// Example application color definitions.
class AppThemeColors {
  static const light = AppColors(
    primary: Color(0xFF2E7D32),
    onPrimary: Color(0xFFFFFFFF),
    accent: Color(0xFF66BB6A),
    onAccent: Color(0xFFFFFFFF),
    surface: Color(0xFFF6F6F6),
    onSurface: Color(0xFF000000),
    textPrimary: Color(0xFF111111),
    textSecondary: Color(0xFF444444),
    textTertiary: Color(0xFF777777),
  );

  static const dark = AppColors(
    primary: Color(0xFF81C784),
    onPrimary: Color(0xFF000000),
    accent: Color(0xFFA5D6A7),
    onAccent: Color(0xFF000000),
    surface: Color(0xFF1E1E1E),
    onSurface: Color(0xFFFFFFFF),
    textPrimary: Color(0xFFFFFFFF),
    textSecondary: Color(0xFFCCCCCC),
    textTertiary: Color(0xFF999999),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Fabrik Theme',
          style: context.typography.titleMediumPrimary,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Hello, Fabrik!',
              style: context.typography.headlineMediumPrimary,
            ),
            const SizedBox(height: 12),
            Text(
              'This text uses semantic typography and colors.',
              style: context.typography.bodyMediumSecondary,
            ),
          ],
        ),
      ),
    );
  }
}
