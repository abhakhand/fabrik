import 'package:fabrik_utils/fabrik_utils.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fabrik Utils Demo',
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final duration = Duration(seconds: 3665);
    final splittedDuration = splitDuration(duration.inSeconds);

    return Scaffold(
      appBar: AppBar(title: const Text('Fabrik Utils Demo')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'String Extensions:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('hello world'.titleCase),
            Text('FABRIK Utils'.camelCase),
            Text('nice_button'.pascalCase),

            const SizedBox(height: 24),
            const Text(
              'DateTime Extensions:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('Today: ${now.isToday}'),
            Text('Is Weekend: ${now.isWeekend}'),
            Text('Time Ago: ${now.subtract(Duration(minutes: 5)).timeAgo}'),

            const SizedBox(height: 24),
            const Text(
              'Duration Utils:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('Formatted: ${formatDuration(duration)}'),
            Text(
              'Split: ${splittedDuration.hours}:${splittedDuration.minutes}:${splittedDuration.seconds}',
            ),

            const SizedBox(height: 24),
            const Text(
              'Debounce / Throttle:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ThrottleExample(),
            DebounceExample(),

            const SizedBox(height: 24),
            const Text(
              'Scroll Utils (check logs):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () {
                final controller = ScrollController(initialScrollOffset: 1000);
                print(isApproachingScrollEnd(controller));
              },
              child: const Text('Check Scroll End'),
            ),
          ],
        ),
      ),
    );
  }
}

class ThrottleExample extends StatefulWidget {
  const ThrottleExample({super.key});

  @override
  State<ThrottleExample> createState() => _ThrottleExampleState();
}

class _ThrottleExampleState extends State<ThrottleExample> {
  final throttle = Throttle<void>(duration: const Duration(seconds: 1));

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        throttle.add(() => print('Throttled tap at ${DateTime.now()}'));
      },
      child: const Text('Throttled Tap'),
    );
  }
}

class DebounceExample extends StatefulWidget {
  const DebounceExample({super.key});

  @override
  State<DebounceExample> createState() => _DebounceExampleState();
}

class _DebounceExampleState extends State<DebounceExample> {
  final debounce = Debounce<void>(duration: const Duration(milliseconds: 500));

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        debounce.add(() => print('Debounced tap at ${DateTime.now()}'));
      },
      child: const Text('Debounced Tap'),
    );
  }
}
