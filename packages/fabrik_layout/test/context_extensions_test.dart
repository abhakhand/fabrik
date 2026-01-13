import 'package:fabrik_layout/fabrik_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FabrikLayoutContext extension', () {
    testWidgets('provides layout data via context.layout', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          builder: (context, child) => FabrikLayout(
            child: Builder(
              builder: (context) {
                final layout = context.layout;
                return Text('Type: ${layout.type}, Mobile: ${layout.isMobile}');
              },
            ),
          ),
        ),
      );

      await tester.binding.setSurfaceSize(const Size(400, 800));
      await tester.pump();

      expect(
        find.text('Type: FabrikLayoutType.mobile, Mobile: true'),
        findsOneWidget,
      );
    });

    testWidgets('throws assertion error when FabrikLayout is not found', (
      tester,
    ) async {
      // In debug mode, accessing layout without FabrikLayout should fail
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              return const Text('Test');
            },
          ),
        ),
      );

      expect(() {
        final context = tester.element(find.text('Test'));
        context.layout; // This should throw assertion in debug mode
      }, throwsAssertionError);
    });

    testWidgets('layout data updates when constraints change', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          builder: (context, child) => FabrikLayout(
            child: Builder(
              builder: (context) {
                final layout = context.layout;
                return Text('${layout.type}');
              },
            ),
          ),
        ),
      );

      await tester.binding.setSurfaceSize(const Size(400, 800));
      await tester.pump();
      expect(find.text('FabrikLayoutType.mobile'), findsOneWidget);

      await tester.binding.setSurfaceSize(const Size(800, 1024));
      await tester.pump();
      expect(find.text('FabrikLayoutType.tablet'), findsOneWidget);
    });

    testWidgets('works with value method', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          builder: (context, child) => FabrikLayout(
            child: Builder(
              builder: (context) {
                final padding = context.layout.value<double>(
                  mobile: 8.0,
                  tablet: 16.0,
                  desktop: 24.0,
                );
                return Text('Padding: $padding');
              },
            ),
          ),
        ),
      );

      await tester.binding.setSurfaceSize(const Size(800, 1024));
      await tester.pump();

      expect(find.text('Padding: 16.0'), findsOneWidget);
    });

    testWidgets('nested builders all access same layout data', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          builder: (context, child) => FabrikLayout(
            child: Builder(
              builder: (context) {
                final type1 = context.layout.type;
                return Builder(
                  builder: (context) {
                    final type2 = context.layout.type;
                    return Builder(
                      builder: (context) {
                        final type3 = context.layout.type;
                        return Text('$type1 $type2 $type3');
                      },
                    );
                  },
                );
              },
            ),
          ),
        ),
      );

      await tester.binding.setSurfaceSize(const Size(400, 800));
      await tester.pump();

      expect(
        find.text(
          'FabrikLayoutType.mobile FabrikLayoutType.mobile FabrikLayoutType.mobile',
        ),
        findsOneWidget,
      );
    });
  });
}
