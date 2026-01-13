import 'package:flutter/widgets.dart';

import 'fabrik_layout_data.dart';
import 'fabrik_layout_scope.dart';

extension FabrikLayoutContext on BuildContext {
  /// Returns the resolved [FabrikLayoutData] for this context.
  ///
  /// Throws an assertion error if [FabrikLayout] is not found above
  /// in the widget tree.
  FabrikLayoutData get layout {
    final scope = dependOnInheritedWidgetOfExactType<FabrikLayoutScope>();
    assert(
      scope != null,
      'FabrikLayout not found in widget tree. '
      'Wrap your app with FabrikLayout.',
    );
    return scope!.data;
  }
}
