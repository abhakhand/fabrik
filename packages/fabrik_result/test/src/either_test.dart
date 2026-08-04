import 'package:fabrik_result/fabrik_result.dart';
import 'package:test/test.dart';

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

    test('isLeft and isRight reflect correct state', () {
      final leftEither = Left<String, int>('fail');
      final rightEither = Right<String, int>(100);

      expect(leftEither.isLeft, isTrue);
      expect(leftEither.isRight, isFalse);

      expect(rightEither.isRight, isTrue);
      expect(rightEither.isLeft, isFalse);
    });

    test('onRight executes only for Right', () {
      final either = right<String, int>(10);
      int? value;

      either.onRight((v) {
        value = v;
      });

      expect(value, 10);
    });

    test('onRight does not execute for Left', () {
      final either = left<String, int>('error');
      bool called = false;

      either.onRight((_) {
        called = true;
      });

      expect(called, isFalse);
    });

    test('onLeft executes only for Left', () {
      final either = left<String, int>('failure');
      String? error;

      either.onLeft((e) {
        error = e;
      });

      expect(error, 'failure');
    });

    test('onLeft does not execute for Right', () {
      final either = right<String, int>(1);
      bool called = false;

      either.onLeft((_) {
        called = true;
      });

      expect(called, isFalse);
    });

    test('rightOrNull returns value for Right', () {
      final either = right<String, int>(99);

      expect(either.rightOrNull, 99);
      expect(either.leftOrNull, isNull);
    });

    test('rightOrNull returns null for Left', () {
      final either = left<String, int>('error');

      expect(either.rightOrNull, isNull);
      expect(either.leftOrNull, 'error');
    });

    test('Left equality holds for same value', () {
      expect(Left<String, int>('error'), equals(Left<String, int>('error')));
    });

    test('Left equality fails for different values', () {
      expect(Left<String, int>('a'), isNot(equals(Left<String, int>('b'))));
    });

    test('Right equality holds for same value', () {
      expect(Right<String, int>(42), equals(Right<String, int>(42)));
    });

    test('Right equality fails for different values', () {
      expect(Right<String, int>(1), isNot(equals(Right<String, int>(2))));
    });

    test('Left and Right with same wrapped value are not equal', () {
      expect(Left<int, int>(1), isNot(equals(Right<int, int>(1))));
    });
  });
}
