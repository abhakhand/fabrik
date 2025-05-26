import 'package:fabrik_theme/fabrik_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = FabrikColors.custom(
      lightPrimary: Colors.green,
      darkPrimary: Colors.greenAccent,
    );

    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.system,
      theme: FabrikThemeBuilder.light(fontFamily: 'Roboto', colors: colors),
      darkTheme: FabrikThemeBuilder.dark(fontFamily: 'Roboto', colors: colors),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = FabrikTheme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Fabrik Theme Example')),
      body: Center(
        child: Column(
          spacing: FabrikSpacing.x5,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hello, Fabrik!',
              style: theme.typography.titleXL,
              textScaler: FabrikTextScaler.linear(context),
            ),
            Text(
              'This is a sample text using Fabrik Typography.',
              style: theme.typography.bodyLarge.copyWith(
                color: theme.colors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
