import 'package:fabrik_result/src/unit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('unit represents a singleton value with stable identity', () {
    expect(unit.toString(), 'unit');
    expect(unit, const Unit());
  });
}
