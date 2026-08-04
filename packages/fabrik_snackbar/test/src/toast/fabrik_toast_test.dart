import 'package:fabrik_snackbar/fabrik_snackbar.dart';
import 'package:fabrik_snackbar/src/toast/fabrik_toast_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Pumps a host app and returns a context usable for showing toasts.
Future<BuildContext> pumpHost(WidgetTester tester) async {
  await tester.pumpWidget(
    const MaterialApp(home: Scaffold(body: SizedBox.expand())),
  );
  return tester.element(find.byType(SizedBox));
}

BoxDecoration toastDecoration(WidgetTester tester) {
  return tester
          .widget<Container>(
            find
                .descendant(
                  of: find.byType(FabrikToastWidget),
                  matching: find.byType(Container),
                )
                .first,
          )
          .decoration!
      as BoxDecoration;
}

void main() {
  group('FabrikToast.show', () {
    testWidgets('displays the message and dismisses after its duration', (
      tester,
    ) async {
      const message = 'This is a toast!';
      final context = await pumpHost(tester);

      FabrikToast.show(
        context,
        message: message,
        duration: const Duration(milliseconds: 500),
      );

      await tester.pump();
      expect(find.text(message), findsOneWidget);

      await tester.pump(const Duration(milliseconds: 600));
      await tester.pumpAndSettle();
      expect(find.text(message), findsNothing);
    });

    testWidgets('stays visible until its duration elapses', (tester) async {
      final context = await pumpHost(tester);

      FabrikToast.show(
        context,
        message: 'Patience',
        duration: const Duration(seconds: 2),
      );
      await tester.pumpAndSettle();

      await tester.pump(const Duration(milliseconds: 1500));
      expect(find.text('Patience'), findsOneWidget);

      await tester.pump(const Duration(milliseconds: 700));
      await tester.pumpAndSettle();
      expect(find.text('Patience'), findsNothing);
    });

    testWidgets('renders an optional icon', (tester) async {
      final context = await pumpHost(tester);

      FabrikToast.show(
        context,
        message: 'With icon',
        icon: Icons.favorite,
        iconColor: Colors.pink,
        iconSize: 30,
      );
      await tester.pumpAndSettle();

      final icon = tester.widget<Icon>(find.byIcon(Icons.favorite));
      expect(icon.color, Colors.pink);
      expect(icon.size, 30);

      await tester.pumpAndSettle(const Duration(seconds: 3));
    });

    testWidgets('omits the icon when none is given', (tester) async {
      final context = await pumpHost(tester);

      FabrikToast.show(context, message: 'No icon');
      await tester.pumpAndSettle();

      expect(
        find.descendant(
          of: find.byType(FabrikToastWidget),
          matching: find.byType(Icon),
        ),
        findsNothing,
      );

      await tester.pumpAndSettle(const Duration(seconds: 3));
    });

    testWidgets('applies text color and font size', (tester) async {
      final context = await pumpHost(tester);

      FabrikToast.show(
        context,
        message: 'Styled',
        textColor: Colors.yellow,
        fontSize: 22,
      );
      await tester.pumpAndSettle();

      final text = tester.widget<Text>(find.text('Styled'));
      expect(text.style?.color, Colors.yellow);
      expect(text.style?.fontSize, 22);

      await tester.pumpAndSettle(const Duration(seconds: 3));
    });

    testWidgets('applies background color and border radius', (tester) async {
      final context = await pumpHost(tester);
      const radius = BorderRadius.all(Radius.circular(4));

      FabrikToast.show(
        context,
        message: 'Boxed',
        backgroundColor: Colors.deepPurple,
        borderRadius: radius,
      );
      await tester.pumpAndSettle();

      final decoration = toastDecoration(tester);
      expect(decoration.color, Colors.deepPurple);
      expect(decoration.borderRadius, radius);

      await tester.pumpAndSettle(const Duration(seconds: 3));
    });

    testWidgets('fires onTap when tapped', (tester) async {
      final context = await pumpHost(tester);
      var tapped = false;

      FabrikToast.show(
        context,
        message: 'Tap me',
        duration: const Duration(seconds: 10),
        onTap: () => tapped = true,
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Tap me'));
      expect(tapped, isTrue);
    });

    testWidgets('supports stacking multiple toasts', (tester) async {
      final context = await pumpHost(tester);

      FabrikToast.show(context, message: 'One');
      FabrikToast.show(context, message: 'Two');
      await tester.pump();

      expect(find.text('One'), findsOneWidget);
      expect(find.text('Two'), findsOneWidget);

      await tester.pumpAndSettle(const Duration(seconds: 3));
      expect(find.text('One'), findsNothing);
      expect(find.text('Two'), findsNothing);
    });

    testWidgets('does not throw when the host is torn down early', (
      tester,
    ) async {
      final context = await pumpHost(tester);

      FabrikToast.show(context, message: 'Transient');
      await tester.pump();

      await tester.pumpWidget(const MaterialApp(home: SizedBox()));
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
    });
  });

  group('FabrikToast positioning', () {
    Future<Alignment> alignmentFor(
      WidgetTester tester,
      FabrikToastPosition position,
    ) async {
      final context = await pumpHost(tester);

      FabrikToast.show(context, message: 'Positioned', position: position);
      await tester.pumpAndSettle();

      final align = tester.widget<Align>(
        find
            .descendant(
              of: find.byType(FabrikToastWidget),
              matching: find.byType(Align),
            )
            .first,
      );

      await tester.pumpAndSettle(const Duration(seconds: 3));
      return align.alignment as Alignment;
    }

    testWidgets('top maps to topCenter', (tester) async {
      expect(
        await alignmentFor(tester, FabrikToastPosition.top),
        Alignment.topCenter,
      );
    });

    testWidgets('center maps to center', (tester) async {
      expect(
        await alignmentFor(tester, FabrikToastPosition.center),
        Alignment.center,
      );
    });

    testWidgets('bottom maps to bottomCenter', (tester) async {
      expect(
        await alignmentFor(tester, FabrikToastPosition.bottom),
        Alignment.bottomCenter,
      );
    });

    testWidgets('defaults to the bottom of the screen', (tester) async {
      final context = await pumpHost(tester);

      FabrikToast.show(context, message: 'Default');
      await tester.pumpAndSettle();

      final align = tester.widget<Align>(
        find
            .descendant(
              of: find.byType(FabrikToastWidget),
              matching: find.byType(Align),
            )
            .first,
      );
      expect(align.alignment, Alignment.bottomCenter);

      await tester.pumpAndSettle(const Duration(seconds: 3));
    });
  });

  group('FabrikToast accessibility', () {
    testWidgets('exposes the message as a live-region label', (tester) async {
      final context = await pumpHost(tester);

      FabrikToast.show(context, message: 'Announce me');
      await tester.pumpAndSettle();

      final semantics = tester.getSemantics(
        find
            .descendant(
              of: find.byType(FabrikToastWidget),
              matching: find.byType(Semantics),
            )
            .first,
      );
      expect(semantics.label, contains('Announce me'));

      await tester.pumpAndSettle(const Duration(seconds: 3));
    });
  });

  group('FabrikToastPosition', () {
    test('exposes mutually exclusive convenience getters', () {
      expect(FabrikToastPosition.top.isTop, isTrue);
      expect(FabrikToastPosition.top.isCenter, isFalse);
      expect(FabrikToastPosition.top.isBottom, isFalse);

      expect(FabrikToastPosition.center.isCenter, isTrue);
      expect(FabrikToastPosition.center.isTop, isFalse);
      expect(FabrikToastPosition.center.isBottom, isFalse);

      expect(FabrikToastPosition.bottom.isBottom, isTrue);
      expect(FabrikToastPosition.bottom.isTop, isFalse);
      expect(FabrikToastPosition.bottom.isCenter, isFalse);
    });
  });

  group('FabrikSnackbar helper enums', () {
    test('FabrikSnackbarPosition getters', () {
      expect(FabrikSnackbarPosition.top.isTop, isTrue);
      expect(FabrikSnackbarPosition.top.isBottom, isFalse);
      expect(FabrikSnackbarPosition.bottom.isBottom, isTrue);
      expect(FabrikSnackbarPosition.bottom.isTop, isFalse);
    });

    test('FabrikSnackbarStyle getters', () {
      expect(FabrikSnackbarStyle.floating.isFloating, isTrue);
      expect(FabrikSnackbarStyle.floating.isGrounded, isFalse);
      expect(FabrikSnackbarStyle.grounded.isGrounded, isTrue);
      expect(FabrikSnackbarStyle.grounded.isFloating, isFalse);
    });

    test('FabrikSnackbarDismissDirection getters', () {
      expect(FabrikSnackbarDismissDirection.vertical.isVertical, isTrue);
      expect(FabrikSnackbarDismissDirection.vertical.isHorizontal, isFalse);
      expect(FabrikSnackbarDismissDirection.horizontal.isHorizontal, isTrue);
      expect(FabrikSnackbarDismissDirection.horizontal.isVertical, isFalse);
    });
  });
}
