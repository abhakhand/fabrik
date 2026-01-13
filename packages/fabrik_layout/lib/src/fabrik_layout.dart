import 'package:flutter/widgets.dart';

import 'fabrik_breakpoints.dart';
import 'fabrik_layout_type.dart';
import 'fabrik_layout_data.dart';
import 'fabrik_layout_scope.dart';
import 'text_scaling.dart';

/// Provides responsive layout information and optional text scaling
/// to the widget subtree.
///
/// This widget must be placed inside `MaterialApp.builder` or
/// `CupertinoApp.builder`.
class FabrikLayout extends StatelessWidget {
  final Widget child;
  final FabrikBreakpoints breakpoints;
  final bool enableTextScaling;

  const FabrikLayout({
    required this.child,
    this.breakpoints = const FabrikBreakpoints(),
    this.enableTextScaling = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final media = MediaQuery.of(context);

        final type = _resolveLayoutType(constraints.maxWidth);

        final textScaler = enableTextScaling
            ? resolveTextScaler(device: type, systemScaler: media.textScaler)
            : media.textScaler;

        final data = FabrikLayoutData(
          type: type,
          screenSize: media.size,
          textScaler: textScaler,
        );

        return FabrikLayoutScope(
          data: data,
          child: MediaQuery(
            data: media.copyWith(textScaler: textScaler),
            child: child,
          ),
        );
      },
    );
  }

  FabrikLayoutType _resolveLayoutType(double width) {
    if (width < breakpoints.mobile) return FabrikLayoutType.mobile;
    if (width < breakpoints.tablet) return FabrikLayoutType.tablet;
    return FabrikLayoutType.desktop;
  }
}
