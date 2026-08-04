import 'package:fabrik_snackbar/fabrik_snackbar.dart';
import 'package:fabrik_snackbar/src/snackbar/fabrik_snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Pumps a host app and returns a context usable for showing snackbars.
Future<BuildContext> pumpHost(WidgetTester tester, {Size? size}) async {
  if (size != null) {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
  }

  await tester.pumpWidget(
    const MaterialApp(home: Scaffold(body: SizedBox.expand())),
  );

  return tester.element(find.byType(SizedBox));
}

/// The decorated container that paints the snackbar surface.
BoxDecoration surfaceDecoration(WidgetTester tester) {
  return tester
          .widget<Container>(
            find
                .descendant(
                  of: find.byType(Dismissible),
                  matching: find.byType(Container),
                )
                .first,
          )
          .decoration!
      as BoxDecoration;
}

/// Plain text of every [RichText] currently rendered inside the snackbar.
///
/// `find.text` only matches [Text] widgets, so rich content needs its spans
/// flattened before it can be asserted on.
List<String> richTextContents(WidgetTester tester) {
  return tester
      .widgetList<RichText>(
        find.descendant(
          of: find.byType(FabrikSnackbarRow),
          matching: find.byType(RichText),
        ),
      )
      .map((widget) => widget.text.toPlainText())
      .toList();
}

Container surfaceContainer(WidgetTester tester) {
  return tester.widget<Container>(
    find
        .descendant(
          of: find.byType(Dismissible),
          matching: find.byType(Container),
        )
        .first,
  );
}

void main() {
  group('FabrikSnackbar variants', () {
    testWidgets('success shows content with a check icon on green', (
      tester,
    ) async {
      final context = await pumpHost(tester);

      FabrikSnackbar.success(context, title: 'Saved', message: 'All good');
      await tester.pump();

      expect(find.text('Saved'), findsOneWidget);
      expect(find.text('All good'), findsOneWidget);
      expect(find.byIcon(Icons.check_circle_outline_rounded), findsOneWidget);
      expect(surfaceDecoration(tester).color, Colors.green);

      await tester.pumpAndSettle(const Duration(seconds: 4));
    });

    testWidgets('error shows an error icon on red', (tester) async {
      final context = await pumpHost(tester);

      FabrikSnackbar.error(context, title: 'Failed');
      await tester.pump();

      expect(find.byIcon(Icons.error_outline_rounded), findsOneWidget);
      expect(surfaceDecoration(tester).color, Colors.red);

      await tester.pumpAndSettle(const Duration(seconds: 4));
    });

    testWidgets('info shows an info icon on blue', (tester) async {
      final context = await pumpHost(tester);

      FabrikSnackbar.info(context, message: 'Heads up');
      await tester.pump();

      expect(find.byIcon(Icons.info_outline_rounded), findsOneWidget);
      expect(surfaceDecoration(tester).color, Colors.blue);

      await tester.pumpAndSettle(const Duration(seconds: 4));
    });

    testWidgets('warning shows a warning icon on orange', (tester) async {
      final context = await pumpHost(tester);

      FabrikSnackbar.warning(context, message: 'Careful');
      await tester.pump();

      expect(find.byIcon(Icons.warning_amber_rounded), findsOneWidget);
      expect(surfaceDecoration(tester).color, Colors.orange);

      await tester.pumpAndSettle(const Duration(seconds: 4));
    });

    testWidgets('accepts a title with no message', (tester) async {
      final context = await pumpHost(tester);

      FabrikSnackbar.success(context, title: 'Title only');
      await tester.pump();

      expect(find.text('Title only'), findsOneWidget);
      await tester.pumpAndSettle(const Duration(seconds: 4));
    });

    testWidgets('accepts a message with no title', (tester) async {
      final context = await pumpHost(tester);

      FabrikSnackbar.success(context, message: 'Message only');
      await tester.pump();

      expect(find.text('Message only'), findsOneWidget);
      await tester.pumpAndSettle(const Duration(seconds: 4));
    });
  });

  group('FabrikSnackbar content validation', () {
    testWidgets('asserts when no content at all is provided', (tester) async {
      final context = await pumpHost(tester);

      expect(
        () => FabrikSnackbar.success(context),
        throwsA(isA<AssertionError>()),
      );
    });

    testWidgets('asserts when both title and richTitle are provided', (
      tester,
    ) async {
      final context = await pumpHost(tester);

      expect(
        () => FabrikSnackbar.success(
          context,
          title: 'plain',
          richTitle: const TextSpan(text: 'rich'),
        ),
        throwsA(isA<AssertionError>()),
      );
    });

    testWidgets('asserts when both message and richMessage are provided', (
      tester,
    ) async {
      final context = await pumpHost(tester);

      expect(
        () => FabrikSnackbar.success(
          context,
          message: 'plain',
          richMessage: const TextSpan(text: 'rich'),
        ),
        throwsA(isA<AssertionError>()),
      );
    });

    test('config asserts on conflicting title fields', () {
      expect(
        () => FabrikSnackbarConfig(
          title: 'plain',
          richTitle: const TextSpan(text: 'rich'),
        ),
        throwsA(isA<AssertionError>()),
      );
    });

    test('config asserts on conflicting message fields', () {
      expect(
        () => FabrikSnackbarConfig(
          message: 'plain',
          richMessage: const TextSpan(text: 'rich'),
        ),
        throwsA(isA<AssertionError>()),
      );
    });
  });

  group('FabrikSnackbar auto-dismiss', () {
    testWidgets('removes itself after the default duration', (tester) async {
      final context = await pumpHost(tester);

      FabrikSnackbar.success(context, title: 'Bye');
      await tester.pump();
      expect(find.text('Bye'), findsOneWidget);

      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle();

      expect(find.text('Bye'), findsNothing);
    });

    testWidgets('honours a custom duration', (tester) async {
      final context = await pumpHost(tester);

      FabrikSnackbar.success(context, title: 'Quick', durationInSeconds: 1);
      await tester.pump();
      expect(find.text('Quick'), findsOneWidget);

      // Still visible just before the deadline.
      await tester.pump(const Duration(milliseconds: 900));
      expect(find.text('Quick'), findsOneWidget);

      await tester.pump(const Duration(milliseconds: 200));
      await tester.pumpAndSettle();
      expect(find.text('Quick'), findsNothing);
    });

    testWidgets('invokes onDismissed when it disappears', (tester) async {
      final context = await pumpHost(tester);
      var dismissed = false;

      FabrikSnackbar.custom(
        context,
        config: FabrikSnackbarConfig(
          title: 'Callback',
          duration: const Duration(milliseconds: 500),
          onDismissed: () => dismissed = true,
        ),
      );
      await tester.pump();
      expect(dismissed, isFalse);

      await tester.pump(const Duration(milliseconds: 600));
      await tester.pumpAndSettle();

      expect(dismissed, isTrue);
      expect(find.text('Callback'), findsNothing);
    });

    testWidgets('multiple snackbars can be stacked', (tester) async {
      final context = await pumpHost(tester);

      FabrikSnackbar.success(context, title: 'First');
      FabrikSnackbar.error(context, title: 'Second');
      await tester.pump();

      expect(find.text('First'), findsOneWidget);
      expect(find.text('Second'), findsOneWidget);

      await tester.pumpAndSettle(const Duration(seconds: 4));
      expect(find.text('First'), findsNothing);
      expect(find.text('Second'), findsNothing);
    });
  });

  group('FabrikSnackbar interaction', () {
    testWidgets('onTap fires when the snackbar body is tapped', (tester) async {
      final context = await pumpHost(tester);
      var tapped = false;

      FabrikSnackbar.custom(
        context,
        config: FabrikSnackbarConfig(
          title: 'Tap me',
          onTap: () => tapped = true,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Tap me'));
      expect(tapped, isTrue);

      await tester.pumpAndSettle(const Duration(seconds: 4));
    });

    testWidgets('swiping dismisses the snackbar', (tester) async {
      final context = await pumpHost(tester);
      var dismissed = false;

      FabrikSnackbar.custom(
        context,
        config: FabrikSnackbarConfig(
          title: 'Swipe me',
          duration: const Duration(seconds: 30),
          onDismissed: () => dismissed = true,
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Swipe me'), findsOneWidget);

      // Bottom position dismisses downward.
      await tester.drag(find.byType(Dismissible), const Offset(0, 400));
      await tester.pumpAndSettle();

      expect(dismissed, isTrue);
      expect(find.text('Swipe me'), findsNothing);
    });

    testWidgets('renders an action button and routes its taps', (tester) async {
      final context = await pumpHost(tester);
      var pressed = false;

      FabrikSnackbar.success(
        context,
        title: 'Undo?',
        actionButton: TextButton(
          onPressed: () => pressed = true,
          child: const Text('UNDO'),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('UNDO'), findsOneWidget);
      await tester.tap(find.text('UNDO'));
      expect(pressed, isTrue);

      await tester.pumpAndSettle(const Duration(seconds: 4));
    });
  });

  group('FabrikSnackbar content priority', () {
    testWidgets('richTitle wins over titleText', (tester) async {
      final context = await pumpHost(tester);

      FabrikSnackbar.custom(
        context,
        config: const FabrikSnackbarConfig(
          richTitle: TextSpan(text: 'rich wins'),
          titleText: Text('widget loses'),
        ),
      );
      await tester.pumpAndSettle();

      // richTitle renders via RichText, which find.text does not traverse.
      expect(richTextContents(tester), contains('rich wins'));
      expect(find.text('widget loses'), findsNothing);

      await tester.pumpAndSettle(const Duration(seconds: 4));
    });

    testWidgets('titleText wins over plain title', (tester) async {
      final context = await pumpHost(tester);

      FabrikSnackbar.custom(
        context,
        config: const FabrikSnackbarConfig(
          title: 'plain loses',
          titleText: Text('widget wins'),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('widget wins'), findsOneWidget);
      expect(find.text('plain loses'), findsNothing);

      await tester.pumpAndSettle(const Duration(seconds: 4));
    });

    testWidgets('richMessage wins over messageText', (tester) async {
      final context = await pumpHost(tester);

      FabrikSnackbar.custom(
        context,
        config: const FabrikSnackbarConfig(
          richMessage: TextSpan(text: 'rich msg'),
          messageText: Text('widget msg'),
        ),
      );
      await tester.pumpAndSettle();

      expect(richTextContents(tester), contains('rich msg'));
      expect(find.text('widget msg'), findsNothing);

      await tester.pumpAndSettle(const Duration(seconds: 4));
    });

    testWidgets('messageText wins over plain message', (tester) async {
      final context = await pumpHost(tester);

      FabrikSnackbar.custom(
        context,
        config: const FabrikSnackbarConfig(
          message: 'plain msg loses',
          messageText: Text('widget msg wins'),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('widget msg wins'), findsOneWidget);
      expect(find.text('plain msg loses'), findsNothing);

      await tester.pumpAndSettle(const Duration(seconds: 4));
    });
  });

  group('FabrikSnackbar styling', () {
    testWidgets('grounded style drops margin and corner radius', (
      tester,
    ) async {
      final context = await pumpHost(tester);

      FabrikSnackbar.custom(
        context,
        config: const FabrikSnackbarConfig(
          title: 'Grounded',
          style: FabrikSnackbarStyle.grounded,
        ),
      );
      await tester.pumpAndSettle();

      expect(surfaceContainer(tester).margin, EdgeInsets.zero);
      expect(surfaceDecoration(tester).borderRadius, BorderRadius.zero);

      await tester.pumpAndSettle(const Duration(seconds: 4));
    });

    testWidgets('floating style keeps the configured margin and radius', (
      tester,
    ) async {
      final context = await pumpHost(tester);
      const margin = EdgeInsets.all(24);
      const radius = BorderRadius.all(Radius.circular(20));

      FabrikSnackbar.custom(
        context,
        config: const FabrikSnackbarConfig(
          title: 'Floating',
          margin: margin,
          borderRadius: radius,
        ),
      );
      await tester.pumpAndSettle();

      expect(surfaceContainer(tester).margin, margin);
      expect(surfaceDecoration(tester).borderRadius, radius);

      await tester.pumpAndSettle(const Duration(seconds: 4));
    });

    testWidgets('a gradient replaces the flat background color', (
      tester,
    ) async {
      final context = await pumpHost(tester);
      const gradient = LinearGradient(colors: [Colors.red, Colors.blue]);

      FabrikSnackbar.custom(
        context,
        config: const FabrikSnackbarConfig(
          title: 'Gradient',
          backgroundGradient: gradient,
        ),
      );
      await tester.pumpAndSettle();

      final decoration = surfaceDecoration(tester);
      expect(decoration.gradient, gradient);
      expect(decoration.color, isNull);

      await tester.pumpAndSettle(const Duration(seconds: 4));
    });

    testWidgets('top position anchors to topCenter', (tester) async {
      final context = await pumpHost(tester);

      FabrikSnackbar.success(
        context,
        title: 'Up top',
        position: FabrikSnackbarPosition.top,
      );
      await tester.pumpAndSettle();

      final align = tester.widget<Align>(
        find
            .ancestor(of: find.byType(Dismissible), matching: find.byType(Align))
            .first,
      );
      expect(align.alignment, Alignment.topCenter);

      await tester.pumpAndSettle(const Duration(seconds: 4));
    });

    testWidgets('bottom position anchors to bottomCenter', (tester) async {
      final context = await pumpHost(tester);

      FabrikSnackbar.success(context, title: 'Down low');
      await tester.pumpAndSettle();

      final align = tester.widget<Align>(
        find
            .ancestor(of: find.byType(Dismissible), matching: find.byType(Align))
            .first,
      );
      expect(align.alignment, Alignment.bottomCenter);

      await tester.pumpAndSettle(const Duration(seconds: 4));
    });

    testWidgets('an explicit maxWidth constrains the container', (
      tester,
    ) async {
      final context = await pumpHost(tester);

      FabrikSnackbar.success(context, title: 'Narrow', maxWidth: 200);
      await tester.pumpAndSettle();

      expect(surfaceContainer(tester).constraints?.maxWidth, 200);

      await tester.pumpAndSettle(const Duration(seconds: 4));
    });

    testWidgets('wide screens fall back to the default max width', (
      tester,
    ) async {
      final context = await pumpHost(tester, size: const Size(1200, 800));

      FabrikSnackbar.success(context, title: 'Wide');
      await tester.pumpAndSettle();

      expect(surfaceContainer(tester).constraints?.maxWidth, 480.0);

      await tester.pumpAndSettle(const Duration(seconds: 4));
    });

    testWidgets('narrow screens stay unconstrained', (tester) async {
      final context = await pumpHost(tester, size: const Size(400, 800));

      FabrikSnackbar.success(context, title: 'Narrow screen');
      await tester.pumpAndSettle();

      expect(surfaceContainer(tester).constraints?.maxWidth, double.infinity);

      await tester.pumpAndSettle(const Duration(seconds: 4));
    });
  });

  group('FabrikSnackbar barrier', () {
    testWidgets('no blur barrier is inserted by default', (tester) async {
      final context = await pumpHost(tester);

      FabrikSnackbar.success(context, title: 'No barrier');
      await tester.pumpAndSettle();

      expect(find.byType(FabrikSnackbarBackgroundBlur), findsNothing);

      await tester.pumpAndSettle(const Duration(seconds: 4));
    });

    testWidgets('blockBackgroundInteraction still renders the content', (
      tester,
    ) async {
      final context = await pumpHost(tester);

      FabrikSnackbar.custom(
        context,
        config: const FabrikSnackbarConfig(
          title: 'Blocked',
          blockBackgroundInteraction: true,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Blocked'), findsOneWidget);

      await tester.pumpAndSettle(const Duration(seconds: 4));
    });

    testWidgets('barrierBlur renders the blur backdrop', (tester) async {
      final context = await pumpHost(tester);

      FabrikSnackbar.custom(
        context,
        config: const FabrikSnackbarConfig(
          title: 'Blurred',
          blockBackgroundInteraction: true,
          barrierBlur: 5,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(FabrikSnackbarBackgroundBlur), findsOneWidget);
      expect(
        tester
            .widget<FabrikSnackbarBackgroundBlur>(
              find.byType(FabrikSnackbarBackgroundBlur),
            )
            .blur,
        5,
      );

      await tester.pumpAndSettle(const Duration(seconds: 4));
    });

    testWidgets('barrierColor alone renders the backdrop', (tester) async {
      final context = await pumpHost(tester);

      FabrikSnackbar.custom(
        context,
        config: const FabrikSnackbarConfig(
          title: 'Tinted',
          blockBackgroundInteraction: true,
          barrierColor: Colors.red,
        ),
      );
      await tester.pumpAndSettle();

      expect(
        tester
            .widget<FabrikSnackbarBackgroundBlur>(
              find.byType(FabrikSnackbarBackgroundBlur),
            )
            .color,
        Colors.red,
      );

      await tester.pumpAndSettle(const Duration(seconds: 4));
    });

    testWidgets('the barrier absorbs taps aimed at the background', (
      tester,
    ) async {
      var backgroundTaps = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GestureDetector(
              onTap: () => backgroundTaps++,
              behavior: HitTestBehavior.opaque,
              child: const SizedBox.expand(),
            ),
          ),
        ),
      );
      final context = tester.element(find.byType(SizedBox).first);

      FabrikSnackbar.custom(
        context,
        config: const FabrikSnackbarConfig(
          title: 'Guarded',
          duration: Duration(seconds: 30),
          blockBackgroundInteraction: true,
        ),
      );
      await tester.pumpAndSettle();

      // Tap near the top of the screen, away from the bottom-anchored snackbar.
      await tester.tapAt(const Offset(400, 60));
      await tester.pump();

      expect(backgroundTaps, 0);
    });

    testWidgets('without a barrier the background still receives taps', (
      tester,
    ) async {
      var backgroundTaps = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GestureDetector(
              onTap: () => backgroundTaps++,
              behavior: HitTestBehavior.opaque,
              child: const SizedBox.expand(),
            ),
          ),
        ),
      );
      final context = tester.element(find.byType(SizedBox).first);

      FabrikSnackbar.custom(
        context,
        config: const FabrikSnackbarConfig(
          title: 'Open',
          duration: Duration(seconds: 30),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tapAt(const Offset(400, 60));
      await tester.pump();

      expect(backgroundTaps, 1);
    });
  });

  group('FabrikSnackbar accessibility', () {
    testWidgets('exposes a live-region semantic label', (tester) async {
      final context = await pumpHost(tester);

      FabrikSnackbar.success(context, title: 'Saved', message: 'All good');
      await tester.pumpAndSettle();

      final semantics = tester.getSemantics(
        find.byType(FabrikSnackbarRow).first,
      );
      expect(semantics.label, contains('Saved'));
      expect(semantics.label, contains('All good'));

      await tester.pumpAndSettle(const Duration(seconds: 4));
    });

    testWidgets('builds the label from rich content too', (tester) async {
      final context = await pumpHost(tester);

      FabrikSnackbar.custom(
        context,
        config: const FabrikSnackbarConfig(
          richTitle: TextSpan(text: 'Rich title'),
          richMessage: TextSpan(text: 'Rich message'),
        ),
      );
      await tester.pumpAndSettle();

      final semantics = tester.getSemantics(
        find.byType(FabrikSnackbarRow).first,
      );
      expect(semantics.label, contains('Rich title'));
      expect(semantics.label, contains('Rich message'));

      await tester.pumpAndSettle(const Duration(seconds: 4));
    });
  });

  group('FabrikSnackbar lifecycle safety', () {
    testWidgets('does not throw when the host is torn down early', (
      tester,
    ) async {
      final context = await pumpHost(tester);

      FabrikSnackbar.success(context, title: 'Transient');
      await tester.pump();

      // Replace the whole app while the snackbar is still on screen.
      await tester.pumpWidget(const MaterialApp(home: SizedBox()));
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
    });
  });
}
