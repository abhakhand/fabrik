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

  /// The device orientation at the time this snapshot was computed.
  final Orientation orientation;

  const FabrikLayoutData({
    required this.type,
    required this.screenSize,
    required this.textScaler,
    this.orientation = Orientation.portrait,
  });

  /// Returns `true` when the layout is classified as mobile.
  bool get isMobile => type == FabrikLayoutType.mobile;

  /// Returns `true` when the layout is classified as tablet.
  bool get isTablet => type == FabrikLayoutType.tablet;

  /// Returns `true` when the layout is classified as desktop.
  bool get isDesktop => type == FabrikLayoutType.desktop;

  /// Returns `true` when the device is in portrait orientation.
  bool get isPortrait => orientation == Orientation.portrait;

  /// Returns `true` when the device is in landscape orientation.
  bool get isLandscape => orientation == Orientation.landscape;

  /// Returns a value based on the current layout type.
  ///
  /// Only [mobile] is required. [tablet] and [desktop] fall back to the
  /// next smaller value when not provided:
  ///
  /// ```dart
  /// final padding = context.layout.value<double>(
  ///   mobile: 8,
  ///   tablet: 16,
  ///   desktop: 24,
  /// );
  /// ```
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

  /// Returns a copy of this instance with the given fields replaced.
  FabrikLayoutData copyWith({
    FabrikLayoutType? type,
    Size? screenSize,
    TextScaler? textScaler,
    Orientation? orientation,
  }) {
    return FabrikLayoutData(
      type: type ?? this.type,
      screenSize: screenSize ?? this.screenSize,
      textScaler: textScaler ?? this.textScaler,
      orientation: orientation ?? this.orientation,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FabrikLayoutData &&
        other.type == type &&
        other.screenSize == screenSize &&
        other.textScaler == textScaler &&
        other.orientation == orientation;
  }

  @override
  int get hashCode => Object.hash(type, screenSize, textScaler, orientation);
}
