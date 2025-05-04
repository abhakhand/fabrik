import 'package:fabrik_snackbar/fabrik_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FabrikSnackbar', () {
    testWidgets('displays success snackbar with title and message', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder:
                (context) => Scaffold(
                  body: Center(
                    child: ElevatedButton(
                      onPressed: () {
                        FabrikSnackbar.success(
                          context,
                          title: 'Test Title',
                          message: 'Test Message',
                        );
                      },
                      child: const Text('Show Snackbar'),
                    ),
                  ),
                ),
          ),
        ),
      );

      await tester.tap(find.text('Show Snackbar'));
      await tester.pump();

      expect(find.text('Test Title'), findsOneWidget);
      expect(find.text('Test Message'), findsOneWidget);

      // Wait for snackbar to auto dismiss
      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle();

      expect(find.text('Test Title'), findsNothing);
      expect(find.text('Test Message'), findsNothing);
    });
  });
}
