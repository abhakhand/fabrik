import 'package:flutter/widgets.dart';

/// A consistent radius system inspired by Flutter, Material 3, and other design systems.
///
/// Provides access to raw radius values, [Radius.circular], and [BorderRadius.circular].
class FabrikRadius {
  const FabrikRadius._();

  // === Raw doubles ===

  static const double x0 = 0.0;
  static const double x1 = 2.0;
  static const double x2 = 4.0;
  static const double x3 = 6.0;
  static const double x4 = 8.0;
  static const double x6 = 12.0;
  static const double x8 = 16.0;
  static const double x12 = 24.0;
  static const double x16 = 32.0;

  /// Fully rounded capsule shape.
  static const double pill = 1000.0;

  // === Radius.circular(...) versions ===

  static final Radius r0 = Radius.circular(x0);
  static final Radius r1 = Radius.circular(x1);
  static final Radius r2 = Radius.circular(x2);
  static final Radius r3 = Radius.circular(x3);
  static final Radius r4 = Radius.circular(x4);
  static final Radius r6 = Radius.circular(x6);
  static final Radius r8 = Radius.circular(x8);
  static final Radius r12 = Radius.circular(x12);
  static final Radius r16 = Radius.circular(x16);
  static final Radius rPill = Radius.circular(pill);

  // === BorderRadius.circular(...) versions ===

  static final BorderRadius br0 = BorderRadius.circular(x0);
  static final BorderRadius br1 = BorderRadius.circular(x1);
  static final BorderRadius br2 = BorderRadius.circular(x2);
  static final BorderRadius br3 = BorderRadius.circular(x3);
  static final BorderRadius br4 = BorderRadius.circular(x4);
  static final BorderRadius br6 = BorderRadius.circular(x6);
  static final BorderRadius br8 = BorderRadius.circular(x8);
  static final BorderRadius br12 = BorderRadius.circular(x12);
  static final BorderRadius br16 = BorderRadius.circular(x16);
  static final BorderRadius brPill = BorderRadius.circular(pill);
}
