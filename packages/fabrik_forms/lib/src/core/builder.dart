import 'package:flutter/widgets.dart';
import 'package:fabrik_forms/src/core/core.dart';

/// A reactive widget for building UI from a [FabrikFormNotifier].
///
/// Automatically rebuilds when the form changes, and exposes a strongly typed
/// `get<T>()` helper for accessing individual fields inside the builder.
class FabrikFormBuilder<T> extends StatelessWidget {
  /// Creates a [FabrikFormBuilder] that listens to a [FabrikFormNotifier]
  /// and rebuilds the UI whenever the form updates.
  const FabrikFormBuilder({
    super.key,
    required this.formNotifier,
    required this.builder,
  });

  /// The reactive form notifier this widget listens to.
  final FabrikFormNotifier<T> formNotifier;

  /// A builder function that provides:
  /// - the current form instance
  /// - a typed helper to get a [FabrikField<T>] by key
  ///
  /// Example:
  /// ```dart
  /// builder: (context, form, get) {
  ///   final email = get<String>('email');
  ///   return Text(email.value);
  /// }
  /// ```
  final Widget Function(
    BuildContext context,
    FabrikForm<T> form,
    FabrikField<T2> Function<T2>(String key),
  )
  builder;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<FabrikForm<T>>(
      valueListenable: formNotifier,
      builder: (context, form, _) {
        return builder(context, form, <T2>(String key) => form.get<T2>(key));
      },
    );
  }
}
