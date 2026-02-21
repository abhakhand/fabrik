import 'package:fabrik_utils/fabrik_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('isApproachingScrollEnd', () {
    test('returns false when controller has no clients', () {
      final controller = ScrollController();
      expect(isApproachingScrollEnd(controller), isFalse);
      controller.dispose();
    });

    testWidgets('returns false when at top of list', (tester) async {
      final controller = ScrollController();

      await tester.pumpWidget(
        MaterialApp(
          home: ListView.builder(
            controller: controller,
            itemCount: 100,
            itemBuilder: (_, i) => SizedBox(height: 50, child: Text('$i')),
          ),
        ),
      );

      expect(isApproachingScrollEnd(controller), isFalse);
      controller.dispose();
    });

    testWidgets('returns true when near the bottom', (tester) async {
      final controller = ScrollController();

      await tester.pumpWidget(
        MaterialApp(
          home: ListView.builder(
            controller: controller,
            itemCount: 100,
            itemBuilder: (_, i) => SizedBox(height: 50, child: Text('$i')),
          ),
        ),
      );

      // Jump to 90% of max scroll extent
      final maxScroll = controller.position.maxScrollExtent;
      controller.jumpTo(maxScroll * 0.9);
      await tester.pump();

      expect(isApproachingScrollEnd(controller), isTrue);
      controller.dispose();
    });

    testWidgets('respects custom threshold', (tester) async {
      final controller = ScrollController();

      await tester.pumpWidget(
        MaterialApp(
          home: ListView.builder(
            controller: controller,
            itemCount: 100,
            itemBuilder: (_, i) => SizedBox(height: 50, child: Text('$i')),
          ),
        ),
      );

      final maxScroll = controller.position.maxScrollExtent;
      controller.jumpTo(maxScroll * 0.8);
      await tester.pump();

      // At 80% — above default 70% threshold → true
      expect(
        isApproachingScrollEnd(controller, scrollOffsetThreshold: 0.7),
        isTrue,
      );

      // At 80% — below custom 90% threshold → false
      expect(
        isApproachingScrollEnd(controller, scrollOffsetThreshold: 0.9),
        isFalse,
      );

      controller.dispose();
    });
  });
}
