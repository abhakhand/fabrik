import 'package:flutter/widgets.dart';

import 'fabrik_layout_data.dart';

class FabrikLayoutScope extends InheritedWidget {
  final FabrikLayoutData data;

  const FabrikLayoutScope({
    required this.data,
    required super.child,
    super.key,
  });

  @override
  bool updateShouldNotify(FabrikLayoutScope oldWidget) {
    return data != oldWidget.data;
  }
}
