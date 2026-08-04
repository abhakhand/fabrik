import 'package:flutter/widgets.dart';

import 'fabrik_breakpoints.dart';
import 'fabrik_layout_type.dart';
import 'fabrik_layout_data.dart';
import 'fabrik_layout_scope.dart';
import 'fabrik_text_scale_config.dart';
import 'text_scaling.dart';

/// Provides responsive layout information and optional text scaling
/// to the widget subtree.
///
/// Place [FabrikLayout] inside `MaterialApp.builder` or
/// `CupertinoApp.builder` so it wraps the entire app:
///
/// ```dart
/// MaterialApp(
///   builder: (context, child) {
///     return FabrikLayout(
///       enableTextScaling: true,
///       child: child!,
///     );
///   },
/// )
/// ```
///
/// Once in place, use `context.layout` anywhere below to access
/// device classification, orientation, and text scaler.
class FabrikLayout extends StatelessWidget {
  final Widget child;

  /// Breakpoint thresholds for device classification. Defaults to
  /// `FabrikBreakpoints()` (mobile < 600, tablet < 1024, desktop ≥ 1024).
  final FabrikBreakpoints breakpoints;

  /// Whether to apply device-aware minimum text scaling. Defaults to `false`.
  ///
  /// When `true`, the system accessibility scale is never reduced —
  /// [textScaleConfig] values only raise the minimum floor per device.
  final bool enableTextScaling;

  /// Text scale floor values per device category. Only consulted when
  /// [enableTextScaling] is `true`. Defaults to `FabrikTextScaleConfig()`
  /// (mobile 1.0×, tablet 1.05×, desktop 1.1×).
  final FabrikTextScaleConfig textScaleConfig;

  const FabrikLayout({
    required this.child,
    this.breakpoints = const FabrikBreakpoints(),
    this.enableTextScaling = false,
    this.textScaleConfig = const FabrikTextScaleConfig(),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final media = MediaQuery.of(context);

        // Under an unbounded-width ancestor — a horizontal ListView or Row —
        // `constraints.maxWidth` is infinite, which would otherwise classify
        // every device as the widest category. Fall back to the window width
        // so a phone is still a phone.
        final width = constraints.hasBoundedWidth
            ? constraints.maxWidth
            : media.size.width;

        final type = _resolveLayoutType(width);

        final textScaler = enableTextScaling
            ? resolveTextScaler(
                device: type,
                systemScaler: media.textScaler,
                config: textScaleConfig,
              )
            : media.textScaler;

        final data = FabrikLayoutData(
          type: type,
          screenSize: media.size,
          textScaler: textScaler,
          orientation: media.orientation,
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
    if (width < breakpoints.desktop) return FabrikLayoutType.desktop;
    return FabrikLayoutType.largeDesktop;
  }
}
