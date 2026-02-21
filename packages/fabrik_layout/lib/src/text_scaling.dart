import 'package:flutter/widgets.dart';

import 'fabrik_layout_type.dart';
import 'fabrik_text_scale_config.dart';

/// Resolves the appropriate [TextScaler] based on device category.
///
/// The returned scaler uses [config] values as minimum scale floors,
/// so the system's accessibility scale is always respected.
/// Scaling is intentionally conservative and opt-in.
TextScaler resolveTextScaler({
  required FabrikLayoutType device,
  required TextScaler systemScaler,
  required FabrikTextScaleConfig config,
}) {
  final factor = switch (device) {
    FabrikLayoutType.mobile => config.mobile,
    FabrikLayoutType.tablet => config.tablet,
    FabrikLayoutType.desktop => config.desktop,
  };

  return systemScaler.clamp(minScaleFactor: factor);
}
