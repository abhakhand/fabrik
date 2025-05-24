import 'package:flutter/material.dart';

/// Determines whether the user has scrolled close to the bottom of a scrollable list.
///
/// [scrollOffsetThreshold] defines how close to the bottom (as a fraction).
/// Returns `true` if `currentScroll >= maxScroll * threshold`.
bool isApproachingScrollEnd(
  ScrollController controller, {
  double scrollOffsetThreshold = 0.7,
}) {
  if (!controller.hasClients) return false;
  final maxScroll = controller.position.maxScrollExtent;
  final currentScroll = controller.offset;

  return currentScroll >= (maxScroll * scrollOffsetThreshold) &&
      currentScroll > 0;
}
