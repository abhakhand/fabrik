import 'package:fabrik_snackbar/fabrik_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<BuildContext> pumpHost(WidgetTester tester) async {
  await tester.pumpWidget(
    const MaterialApp(home: Scaffold(body: SizedBox.expand())),
  );
  return tester.element(find.byType(SizedBox));
}

void main() {
  group('swipe dismissal completes promptly', () {
    // Regression guard: the swipe path used to run the full 400ms slide-out
    // animation on a widget Dismissible had already removed, leaving the
    // overlay entry mounted and delaying onDismissed by ~800ms.
    testWidgets('fires onDismissed without waiting for a slide-out', (
      tester,
    ) async {
      final context = await pumpHost(tester);
      var dismissed = false;

      FabrikSnackbar.custom(
        context,
        config: FabrikSnackbarConfig(
          title: 'Swipe',
          duration: const Duration(seconds: 30),
          onDismissed: () => dismissed = true,
        ),
      );
      await tester.pumpAndSettle();

      await tester.drag(find.byType(Dismissible), const Offset(0, 600));

      // Dismissible's own resize animation is ~300ms. Once that has ticked
      // through, dismissal must already be complete rather than waiting on a
      // further slide-out of a widget that is no longer on screen.
      var elapsed = Duration.zero;
      const step = Duration(milliseconds: 20);
      const budget = Duration(milliseconds: 360);
      while (!dismissed && elapsed < budget) {
        await tester.pump(step);
        elapsed += step;
      }

      expect(
        dismissed,
        isTrue,
        reason: 'onDismissed should fire once Dismissible finishes resizing',
      );
      expect(find.text('Swipe'), findsNothing);

      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    });

    testWidgets('a swipe and an expiring timer dismiss only once', (
      tester,
    ) async {
      final context = await pumpHost(tester);
      var dismissCount = 0;

      FabrikSnackbar.custom(
        context,
        config: FabrikSnackbarConfig(
          title: 'Race',
          duration: const Duration(milliseconds: 600),
          onDismissed: () => dismissCount++,
        ),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      // Swipe just before the auto-dismiss timer would fire.
      await tester.drag(find.byType(Dismissible), const Offset(0, 600));
      await tester.pump(const Duration(milliseconds: 200));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      expect(dismissCount, 1);
      expect(tester.takeException(), isNull);
    });

    testWidgets('rapid successive swipes do not throw', (tester) async {
      final context = await pumpHost(tester);

      for (var i = 0; i < 3; i++) {
        FabrikSnackbar.custom(
          context,
          config: FabrikSnackbarConfig(
            title: 'Item $i',
            duration: const Duration(seconds: 30),
          ),
        );
      }
      await tester.pumpAndSettle();

      for (var i = 0; i < 3; i++) {
        final remaining = find.byType(Dismissible);
        if (remaining.evaluate().isEmpty) break;
        await tester.drag(remaining.first, const Offset(0, 600));
        await tester.pump(const Duration(milliseconds: 400));
      }
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
    });
  });

  group('missing Overlay degrades gracefully', () {
    // Regression guard: the previous `Overlay.of(...)` + `!mounted` check was
    // unreachable, because `Overlay.of` throws when there is no Overlay.
    testWidgets('FabrikSnackbar returns without throwing', (tester) async {
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: SizedBox.expand(),
        ),
      );
      final context = tester.element(find.byType(SizedBox));

      FabrikSnackbar.success(context, title: 'No overlay');
      await tester.pump();

      expect(tester.takeException(), isNull);
      expect(find.text('No overlay'), findsNothing);
    });

    testWidgets('FabrikToast returns without throwing', (tester) async {
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: SizedBox.expand(),
        ),
      );
      final context = tester.element(find.byType(SizedBox));

      FabrikToast.show(context, message: 'No overlay');
      await tester.pump();

      expect(tester.takeException(), isNull);
      expect(find.text('No overlay'), findsNothing);
    });
  });

  group('title and message styling', () {
    testWidgets('applies a custom titleStyle and messageStyle', (tester) async {
      final context = await pumpHost(tester);

      FabrikSnackbar.success(
        context,
        title: 'Styled',
        message: 'Body',
        titleStyle: const TextStyle(fontSize: 28, color: Colors.amber),
        messageStyle: const TextStyle(fontSize: 9, color: Colors.cyan),
      );
      await tester.pumpAndSettle();

      final title = tester.widget<Text>(find.text('Styled'));
      final message = tester.widget<Text>(find.text('Body'));

      expect(title.style?.fontSize, 28);
      expect(title.style?.color, Colors.amber);
      expect(message.style?.fontSize, 9);
      expect(message.style?.color, Colors.cyan);

      await tester.pumpAndSettle(const Duration(seconds: 4));
    });

    testWidgets('falls back to the documented defaults', (tester) async {
      final context = await pumpHost(tester);

      FabrikSnackbar.success(context, title: 'Default', message: 'Body');
      await tester.pumpAndSettle();

      final title = tester.widget<Text>(find.text('Default'));
      final message = tester.widget<Text>(find.text('Body'));

      expect(title.style, FabrikSnackbarDefaults.defaultTitleStyle);
      expect(title.style?.fontSize, FabrikSnackbarDefaults.defaultTitleFontSize);
      expect(
        title.style?.fontWeight,
        FabrikSnackbarDefaults.defaultTitleFontWeight,
      );
      expect(title.style?.color, FabrikSnackbarDefaults.defaultTextColor);

      expect(message.style, FabrikSnackbarDefaults.defaultMessageStyle);
      expect(
        message.style?.fontSize,
        FabrikSnackbarDefaults.defaultMessageFontSize,
      );

      await tester.pumpAndSettle(const Duration(seconds: 4));
    });

    testWidgets('styles work through FabrikSnackbarConfig too', (tester) async {
      final context = await pumpHost(tester);

      FabrikSnackbar.custom(
        context,
        config: const FabrikSnackbarConfig(
          title: 'Config',
          titleStyle: TextStyle(fontSize: 20, color: Colors.black),
        ),
      );
      await tester.pumpAndSettle();

      expect(
        tester.widget<Text>(find.text('Config')).style?.fontSize,
        20,
      );

      await tester.pumpAndSettle(const Duration(seconds: 4));
    });

    testWidgets('every variant forwards the styles', (tester) async {
      const style = TextStyle(fontSize: 25, color: Colors.purple);

      for (final show in <void Function(BuildContext)>[
        (c) => FabrikSnackbar.success(c, title: 'V', titleStyle: style),
        (c) => FabrikSnackbar.error(c, title: 'V', titleStyle: style),
        (c) => FabrikSnackbar.info(c, title: 'V', titleStyle: style),
        (c) => FabrikSnackbar.warning(c, title: 'V', titleStyle: style),
      ]) {
        final context = await pumpHost(tester);
        show(context);
        await tester.pumpAndSettle();

        expect(tester.widget<Text>(find.text('V')).style?.fontSize, 25);

        await tester.pumpAndSettle(const Duration(seconds: 4));
      }
    });
  });
}
