import 'package:fabrik_layout/fabrik_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FabrikLayout', () {
    testWidgets('resolves mobile layout for narrow widths', (tester) async {
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
    });

    testWidgets('resolves tablet layout for medium widths', (tester) async {
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

      await tester.binding.setSurfaceSize(const Size(800, 1024));
      await tester.pump();

      expect(find.text('FabrikLayoutType.tablet'), findsOneWidget);
    });

    testWidgets('resolves desktop layout for wide widths', (tester) async {
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

      await tester.binding.setSurfaceSize(const Size(1200, 900));
      await tester.pump();

      expect(find.text('FabrikLayoutType.desktop'), findsOneWidget);
    });

    testWidgets('uses custom breakpoints', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          builder: (context, child) => FabrikLayout(
            breakpoints: const FabrikBreakpoints(mobile: 480, tablet: 768),
            child: Builder(
              builder: (context) {
                final layout = context.layout;
                return Text('${layout.type}');
              },
            ),
          ),
        ),
      );

      await tester.binding.setSurfaceSize(const Size(500, 800));
      await tester.pump();

      expect(find.text('FabrikLayoutType.tablet'), findsOneWidget);
    });

    testWidgets('provides screen size in layout data', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          builder: (context, child) => FabrikLayout(
            child: Builder(
              builder: (context) {
                final layout = context.layout;
                return Text(
                  '${layout.screenSize.width}x${layout.screenSize.height}',
                );
              },
            ),
          ),
        ),
      );

      await tester.binding.setSurfaceSize(const Size(800, 600));
      await tester.pump();

      expect(find.text('800.0x600.0'), findsOneWidget);
    });

    testWidgets('does not scale text when enableTextScaling is false', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          builder: (context, child) => FabrikLayout(
            enableTextScaling: false,
            child: Builder(
              builder: (context) {
                final textScaler = MediaQuery.of(context).textScaler;
                return Text('Scale: ${textScaler.scale(1.0)}');
              },
            ),
          ),
        ),
      );

      await tester.binding.setSurfaceSize(const Size(1920, 1080));
      await tester.pump();

      expect(find.text('Scale: 1.0'), findsOneWidget);
    });

    testWidgets('scales text when enableTextScaling is true', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          builder: (context, child) => FabrikLayout(
            enableTextScaling: true,
            child: Builder(
              builder: (context) {
                final textScaler = MediaQuery.of(context).textScaler;
                return Text('Scale: ${textScaler.scale(1.0)}');
              },
            ),
          ),
        ),
      );

      await tester.binding.setSurfaceSize(const Size(1920, 1080));
      await tester.pump();

      expect(find.text('Scale: 1.1'), findsOneWidget);
    });

    testWidgets('updates layout when window size changes', (tester) async {
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

      await tester.binding.setSurfaceSize(const Size(1200, 900));
      await tester.pump();
      expect(find.text('FabrikLayoutType.desktop'), findsOneWidget);
    });

    testWidgets('exposes portrait orientation', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context).copyWith(
              size: const Size(400, 800),
            ),
            child: FabrikLayout(
              child: Builder(
                builder: (context) {
                  final layout = context.layout;
                  return Text(layout.isPortrait ? 'portrait' : 'landscape');
                },
              ),
            ),
          ),
        ),
      );

      await tester.binding.setSurfaceSize(const Size(400, 800));
      await tester.pump();

      expect(find.text('portrait'), findsOneWidget);
    });

    testWidgets('exposes landscape orientation', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context).copyWith(
              size: const Size(800, 400),
            ),
            child: FabrikLayout(
              child: Builder(
                builder: (context) {
                  final layout = context.layout;
                  return Text(layout.isPortrait ? 'portrait' : 'landscape');
                },
              ),
            ),
          ),
        ),
      );

      await tester.binding.setSurfaceSize(const Size(800, 400));
      await tester.pump();

      expect(find.text('landscape'), findsOneWidget);
    });

    testWidgets('uses custom text scale config', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          builder: (context, child) => FabrikLayout(
            enableTextScaling: true,
            textScaleConfig: const FabrikTextScaleConfig(
              mobile: 1.0,
              tablet: 1.0,
              desktop: 1.2,
            ),
            child: Builder(
              builder: (context) {
                final textScaler = MediaQuery.of(context).textScaler;
                return Text('Scale: ${textScaler.scale(1.0)}');
              },
            ),
          ),
        ),
      );

      await tester.binding.setSurfaceSize(const Size(1920, 1080));
      await tester.pump();

      expect(find.text('Scale: 1.2'), findsOneWidget);
    });

    testWidgets('checks exact boundary conditions', (tester) async {
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

      // Just below mobile breakpoint
      await tester.binding.setSurfaceSize(const Size(599, 800));
      await tester.pump();
      expect(find.text('FabrikLayoutType.mobile'), findsOneWidget);

      // At mobile breakpoint
      await tester.binding.setSurfaceSize(const Size(600, 800));
      await tester.pump();
      expect(find.text('FabrikLayoutType.tablet'), findsOneWidget);

      // Just below tablet breakpoint
      await tester.binding.setSurfaceSize(const Size(1023, 800));
      await tester.pump();
      expect(find.text('FabrikLayoutType.tablet'), findsOneWidget);

      // At tablet breakpoint
      await tester.binding.setSurfaceSize(const Size(1024, 800));
      await tester.pump();
      expect(find.text('FabrikLayoutType.desktop'), findsOneWidget);
    });
  });
}
