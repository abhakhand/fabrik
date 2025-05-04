import 'package:fabrik_snackbar/fabrik_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'FabrikToast.show displays message and dismisses after duration',
    (tester) async {
      const toastMessage = 'This is a toast!';

      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: SizedBox())),
      );

      FabrikToast.show(
        tester.element(find.byType(SizedBox)),
        message: toastMessage,
        duration: const Duration(milliseconds: 500),
      );

      // Wait for overlay insertion
      await tester.pump();
      expect(find.text(toastMessage), findsOneWidget);

      // Let the toast duration pass
      await tester.pump(const Duration(milliseconds: 600));
      expect(find.text(toastMessage), findsNothing);
    },
  );
}
