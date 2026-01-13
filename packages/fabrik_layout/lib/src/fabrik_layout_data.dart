import 'package:flutter/widgets.dart';

import 'fabrik_layout_type.dart';

/// Immutable snapshot of resolved layout information for the current subtree.
///
/// This object is computed once per layout change and exposed read-only
/// via [BuildContext] extensions.
@immutable
class FabrikLayoutData {
  final FabrikLayoutType type;
  final Size screenSize;
  final TextScaler textScaler;

  const FabrikLayoutData({
    required this.type,
    required this.screenSize,
    required this.textScaler,
  });

  bool get isMobile => type == FabrikLayoutType.mobile;
  bool get isTablet => type == FabrikLayoutType.tablet;
  bool get isDesktop => type == FabrikLayoutType.desktop;

  /// Returns a value based on the current layout.
  ///
  /// This is the preferred way to branch layout-dependent values.
  T value<T>({required T mobile, T? tablet, T? desktop}) {
    switch (type) {
      case FabrikLayoutType.desktop:
        return desktop ?? tablet ?? mobile;
      case FabrikLayoutType.tablet:
        return tablet ?? mobile;
      case FabrikLayoutType.mobile:
        return mobile;
    }
  }
}
