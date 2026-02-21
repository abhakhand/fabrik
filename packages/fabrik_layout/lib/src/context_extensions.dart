import 'package:flutter/widgets.dart';

import 'fabrik_layout_data.dart';
import 'fabrik_layout_scope.dart';

/// Convenience extension on [BuildContext] for accessing Fabrik layout data.
///
/// This getter is a thin wrapper over [dependOnInheritedWidgetOfExactType]
/// and throws a [StateError] in both debug and release mode if [FabrikLayout]
/// is not present in the widget tree.
extension FabrikLayoutContext on BuildContext {
  /// Returns the resolved [FabrikLayoutData] for this context.
  ///
  /// Throws a [StateError] in debug and release mode if [FabrikLayout] is not
  /// found above in the widget tree. Wrap your app with [FabrikLayout] inside
  /// `MaterialApp.builder` to ensure it is present.
  FabrikLayoutData get layout {
    final scope = dependOnInheritedWidgetOfExactType<FabrikLayoutScope>();
    return scope?.data ??
        (throw StateError(
          'FabrikLayout not found in widget tree. '
          'Wrap your app with FabrikLayout inside MaterialApp.builder.',
        ));
  }
}
