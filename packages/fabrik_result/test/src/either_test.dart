import 'package:fabrik_result/src/either.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Either', () {
    test('fold works for Left', () {
      final either = left<String, int>('error');
      final result = either.fold((l) => 'left: $l', (r) => 'right: $r');
      expect(result, 'left: error');
    });

    test('fold works for Right', () {
      final either = right<String, int>(42);
      final result = either.fold((l) => 'left: $l', (r) => 'right: $r');
      expect(result, 'right: 42');
    });

    test('isLeft returns true for Left', () {
      final either = Left<String, int>('fail');
      expect(either.isLeft, isTrue);
      expect(either.isRight, isFalse);
    });

    test('isRight returns true for Right', () {
      final either = Right<String, int>(100);
      expect(either.isRight, isTrue);
      expect(either.isLeft, isFalse);
    });
  });
}
