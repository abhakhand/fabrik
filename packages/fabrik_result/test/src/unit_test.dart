import 'package:fabrik_result/src/unit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('unit should be a singleton with string representation', () {
    expect(unit.toString(), 'unit');
    expect(unit, const Unit());
  });
}
