import 'package:flutter/widgets.dart';

import 'fabrik_layout_type.dart';

/// Resolves the appropriate [TextScaler] based on device category.
///
/// Scaling is intentionally conservative and opt-in.
TextScaler resolveTextScaler({
  required FabrikLayoutType device,
  required TextScaler systemScaler,
}) {
  final factor = switch (device) {
    FabrikLayoutType.mobile => 1.0,
    FabrikLayoutType.tablet => 1.05,
    FabrikLayoutType.desktop => 1.1,
  };

  return systemScaler.clamp(minScaleFactor: factor);
}
