/// Defines the vertical position of the snackbar on screen.
enum FabrikSnackbarPosition {
  /// Appears at the top of the screen.
  top,

  /// Appears at the bottom of the screen.
  bottom;

  /// Returns `true` if the snackbar is positioned at the top.
  bool get isTop => this == FabrikSnackbarPosition.top;

  /// Returns `true` if the snackbar is positioned at the bottom.
  bool get isBottom => this == FabrikSnackbarPosition.bottom;
}

/// Defines the visual style of the snackbar container.
enum FabrikSnackbarStyle {
  /// Floating style with margin and rounded corners.
  floating,

  /// Grounded to the screen edge with no margin or radius.
  grounded;

  /// Returns `true` if the style is floating.
  bool get isFloating => this == FabrikSnackbarStyle.floating;

  /// Returns `true` if the style is grounded.
  bool get isGrounded => this == FabrikSnackbarStyle.grounded;
}

/// Defines the swipe direction that dismisses the snackbar.
enum FabrikSnackbarDismissDirection {
  /// Swipe up (top snackbar) or down (bottom snackbar) to dismiss.
  vertical,

  /// Swipe left or right to dismiss.
  horizontal;

  /// Returns `true` if the dismissal direction is vertical.
  bool get isVertical => this == FabrikSnackbarDismissDirection.vertical;

  /// Returns `true` if the dismissal direction is horizontal.
  bool get isHorizontal => this == FabrikSnackbarDismissDirection.horizontal;
}
