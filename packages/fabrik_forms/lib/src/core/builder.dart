import 'package:flutter/widgets.dart';
import 'package:fabrik_forms/src/core/core.dart';

/// A reactive widget for building UI from a [FabrikFormNotifier].
///
/// Automatically rebuilds when the form changes, and exposes a strongly typed
/// `get<T>()` helper for accessing individual fields inside the builder.
class FabrikFormBuilder extends StatelessWidget {
  /// Creates a [FabrikFormBuilder] that listens to a [FabrikFormNotifier]
  /// and rebuilds the UI whenever the form updates.
  const FabrikFormBuilder({
    super.key,
    required this.formNotifier,
    required this.builder,
  });

  /// The reactive form notifier this widget listens to.
  final FabrikFormNotifier formNotifier;

  /// A builder function that provides:
  /// - the current form instance
  /// - a typed helper to get a [FabrikField] by key
  ///
  /// Example:
  /// ```dart
  /// builder: (context, form, get) {
  ///   final email = get<String>('email');
  ///   final age = get<int>('age');
  ///   return Text('${email.value} (${age.value})');
  /// }
  /// ```
  final Widget Function(
    BuildContext context,
    FabrikForm form,
    FabrikField<T> Function<T>(String key),
  )
  builder;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<FabrikForm>(
      valueListenable: formNotifier,
      builder: (context, form, _) {
        return builder(context, form, <T>(String key) => form.get<T>(key));
      },
    );
  }
}
