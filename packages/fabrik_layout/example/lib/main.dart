import 'package:flutter/material.dart';
import 'package:fabrik_layout/fabrik_layout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return FabrikLayout(enableTextScaling: true, child: child!);
      },
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    if (context.layout.isMobile) {
      return const DeviceView(title: 'Mobile Layout');
    }

    if (context.layout.isTablet) {
      return const DeviceView(title: 'Tablet Layout');
    }

    return const DeviceView(title: 'Desktop Layout');
  }
}

class DeviceView extends StatelessWidget {
  final String title;

  const DeviceView({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text(
          'Current device: $title',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
