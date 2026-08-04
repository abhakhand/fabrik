import 'package:fabrik_result/fabrik_result.dart';
import 'package:test/test.dart';

void main() {
  group('Option', () {
    test('Some.fold executes onSome', () {
      final option = some(10);

      final result = option.fold(() => 'none', (v) => 'some: $v');

      expect(result, 'some: 10');
    });

    test('None.fold executes onNone', () {
      final option = none<int>();

      final result = option.fold(() => 'none', (v) => 'some: $v');

      expect(result, 'none');
    });

    test('isSome and isNone reflect correct state', () {
      final someValue = some('value');
      final noneValue = none<String>();

      expect(someValue.isSome, isTrue);
      expect(someValue.isNone, isFalse);

      expect(noneValue.isNone, isTrue);
      expect(noneValue.isSome, isFalse);
    });

    test('Some.toString returns readable value', () {
      expect(some(5).toString(), 'Some(5)');
    });

    test('None.toString returns readable value', () {
      expect(none<int>().toString(), 'None');
    });

    test('Some equality holds for same value', () {
      expect(some(42), equals(some(42)));
    });

    test('Some equality fails for different values', () {
      expect(some(1), isNot(equals(some(2))));
    });

    test('None equality holds regardless of type parameter', () {
      expect(none<int>(), equals(none<int>()));
      expect(none<String>(), equals(none<int>()));
    });

    test('Some and None are never equal', () {
      expect(some(0), isNot(equals(none<int>())));
    });
  });
}
