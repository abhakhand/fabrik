import 'package:fabrik_layout/fabrik_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Regression guard: `constraints.maxWidth` is infinite under a horizontal
  // scroll view or an unconstrained Row. `Infinity < breakpoints.mobile` is
  // false, so every device used to fall through to the widest category — a
  // 375px phone reported `isDesktop == true` while `screenSize` said 375.
  group('unbounded width falls back to the window size', () {
    testWidgets('a phone inside a horizontal ListView stays mobile', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(375, 812);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      late FabrikLayoutData data;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                FabrikLayout(
                  child: Builder(
                    builder: (context) {
                      data = context.layout;
                      return const SizedBox(width: 50);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      expect(data.type, FabrikLayoutType.mobile);
      expect(data.isDesktop, isFalse);
    });

    testWidgets('a phone inside an unconstrained Row stays mobile', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(375, 812);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      late FabrikLayoutData data;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  FabrikLayout(
                    child: Builder(
                      builder: (context) {
                        data = context.layout;
                        return const SizedBox(width: 50);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      expect(data.type, FabrikLayoutType.mobile);
    });

    testWidgets('type and screenSize agree under unbounded width', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(375, 812);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      late FabrikLayoutData data;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                FabrikLayout(
                  child: Builder(
                    builder: (context) {
                      data = context.layout;
                      return const SizedBox(width: 50);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      // A narrow screenSize must not coexist with a desktop classification.
      expect(data.screenSize.width, lessThan(600));
      expect(data.isDesktop, isFalse);
      expect(data.isLargeDesktop, isFalse);
    });

    testWidgets('a wide window inside a horizontal ListView is still wide', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1600, 900);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      late FabrikLayoutData data;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                FabrikLayout(
                  child: Builder(
                    builder: (context) {
                      data = context.layout;
                      return const SizedBox(width: 50);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      expect(data.type, FabrikLayoutType.largeDesktop);
    });

    testWidgets('bounded width still wins over the window size', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1600, 900);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      late FabrikLayoutData data;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                width: 400,
                child: FabrikLayout(
                  child: Builder(
                    builder: (context) {
                      data = context.layout;
                      return const SizedBox.expand();
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      // The 400px box is bounded, so it drives classification, not the
      // 1600px window.
      expect(data.type, FabrikLayoutType.mobile);
    });
  });
}
