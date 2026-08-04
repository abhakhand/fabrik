// Imports ONLY the public library, exactly as a consumer would.
//
// Regression guard for the 0.1.8 export fix: `FabrikSnackbarPosition`,
// `FabrikSnackbarStyle` and `FabrikSnackbarDismissDirection` were reachable
// from the public API's parameter lists but were never exported, so the
// customization example in the README did not compile for users.
import 'package:fabrik_snackbar/fabrik_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('public API surface', () {
    test('positioning enum is exported', () {
      const position = FabrikSnackbarPosition.top;
      expect(position.isTop, isTrue);
      expect(FabrikSnackbarPosition.values, hasLength(2));
    });

    test('style enum is exported', () {
      const style = FabrikSnackbarStyle.grounded;
      expect(style.isGrounded, isTrue);
      expect(FabrikSnackbarStyle.values, hasLength(2));
    });

    test('dismiss direction enum is exported', () {
      const direction = FabrikSnackbarDismissDirection.horizontal;
      expect(direction.isHorizontal, isTrue);
      expect(FabrikSnackbarDismissDirection.values, hasLength(2));
    });

    test('toast position enum is exported', () {
      expect(FabrikToastPosition.center.isCenter, isTrue);
      expect(FabrikToastPosition.values, hasLength(3));
    });

    test('defaults class is exported', () {
      expect(FabrikSnackbarDefaults.defaultDuration, isA<Duration>());
      expect(FabrikSnackbarDefaults.defaultTitleStyle, isA<TextStyle>());
      expect(FabrikSnackbarDefaults.defaultMessageStyle, isA<TextStyle>());
    });

    test('config classes are exported', () {
      expect(const FabrikSnackbarConfig(title: 'x'), isA<FabrikSnackbarConfig>());
      expect(const FabrikToastConfig(message: 'x'), isA<FabrikToastConfig>());
    });

    test('the README customization example type-checks', () {
      // Mirrors the snippet published in README.md.
      final config = FabrikSnackbarConfig(
        title: 'Order placed',
        message: 'Your items will arrive in 2–3 days.',
        icon: const Icon(Icons.shopping_bag_outlined, color: Colors.white),
        backgroundColor: Colors.indigo,
        position: FabrikSnackbarPosition.top,
        duration: const Duration(seconds: 5),
        borderRadius: BorderRadius.circular(16),
        style: FabrikSnackbarStyle.floating,
        dismissDirection: FabrikSnackbarDismissDirection.horizontal,
      );

      expect(config.position, FabrikSnackbarPosition.top);
      expect(config.style, FabrikSnackbarStyle.floating);
      expect(
        config.dismissDirection,
        FabrikSnackbarDismissDirection.horizontal,
      );
    });
  });
}
