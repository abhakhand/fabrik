import 'package:fabrik_result/fabrik_result.dart';
import 'package:test/test.dart';

void main() {
  test('unit represents a singleton value with stable identity', () {
    expect(unit.toString(), 'unit');
    expect(unit, const Unit());
  });
}
