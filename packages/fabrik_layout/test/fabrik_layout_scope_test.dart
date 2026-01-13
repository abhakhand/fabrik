import 'package:fabrik_layout/fabrik_layout.dart';
import 'package:fabrik_layout/src/fabrik_layout_scope.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FabrikLayoutScope', () {
    testWidgets('provides layout data to descendants', (tester) async {
      const data = FabrikLayoutData(
        type: FabrikLayoutType.mobile,
        screenSize: Size(375, 667),
        textScaler: TextScaler.linear(1.0),
      );

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: FabrikLayoutScope(
            data: data,
            child: Builder(
              builder: (context) {
                final scope = context
                    .dependOnInheritedWidgetOfExactType<FabrikLayoutScope>();
                return Text('${scope?.data.type}');
              },
            ),
          ),
        ),
      );

      expect(find.text('FabrikLayoutType.mobile'), findsOneWidget);
    });

    testWidgets('notifies when data changes', (tester) async {
      const initialData = FabrikLayoutData(
        type: FabrikLayoutType.mobile,
        screenSize: Size(375, 667),
        textScaler: TextScaler.linear(1.0),
      );

      const updatedData = FabrikLayoutData(
        type: FabrikLayoutType.tablet,
        screenSize: Size(768, 1024),
        textScaler: TextScaler.linear(1.05),
      );

      late StateSetter setState;

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: StatefulBuilder(
            builder: (context, setter) {
              setState = setter;
              return FabrikLayoutScope(
                data: initialData,
                child: Builder(
                  builder: (context) {
                    final scope = context
                        .dependOnInheritedWidgetOfExactType<
                          FabrikLayoutScope
                        >();
                    return Text('${scope?.data.type}');
                  },
                ),
              );
            },
          ),
        ),
      );

      expect(find.text('FabrikLayoutType.mobile'), findsOneWidget);

      setState(() {});
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: FabrikLayoutScope(
            data: updatedData,
            child: Builder(
              builder: (context) {
                final scope = context
                    .dependOnInheritedWidgetOfExactType<FabrikLayoutScope>();
                return Text('${scope?.data.type}');
              },
            ),
          ),
        ),
      );

      expect(find.text('FabrikLayoutType.tablet'), findsOneWidget);
    });

    testWidgets('updateShouldNotify returns true when data differs', (
      tester,
    ) async {
      const data1 = FabrikLayoutData(
        type: FabrikLayoutType.mobile,
        screenSize: Size(375, 667),
        textScaler: TextScaler.linear(1.0),
      );

      const data2 = FabrikLayoutData(
        type: FabrikLayoutType.tablet,
        screenSize: Size(768, 1024),
        textScaler: TextScaler.linear(1.05),
      );

      const scope1 = FabrikLayoutScope(data: data1, child: SizedBox());

      const scope2 = FabrikLayoutScope(data: data2, child: SizedBox());

      expect(scope2.updateShouldNotify(scope1), true);
    });

    testWidgets('updateShouldNotify returns false when data is same', (
      tester,
    ) async {
      const data = FabrikLayoutData(
        type: FabrikLayoutType.mobile,
        screenSize: Size(375, 667),
        textScaler: TextScaler.linear(1.0),
      );

      const scope1 = FabrikLayoutScope(data: data, child: SizedBox());

      const scope2 = FabrikLayoutScope(data: data, child: SizedBox());

      expect(scope2.updateShouldNotify(scope1), false);
    });
  });
}
