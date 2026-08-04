import 'package:fabrik_result/fabrik_result.dart';
import 'package:test/test.dart';

class Failure {
  const Failure(this.message);
  final String message;

  @override
  bool operator ==(Object other) =>
      other is Failure && other.message == message;

  @override
  int get hashCode => message.hashCode;

  @override
  String toString() => 'Failure($message)';
}

void main() {
  group('Either.map', () {
    test('transforms a Right value', () {
      expect(right<Failure, int>(21).map((v) => v * 2), right<Failure, int>(42));
    });

    test('leaves a Left untouched', () {
      const failure = Failure('boom');
      expect(
        left<Failure, int>(failure).map((v) => v * 2),
        left<Failure, int>(failure),
      );
    });

    test('does not call the transform for a Left', () {
      var called = false;
      left<Failure, int>(const Failure('boom')).map((v) {
        called = true;
        return v;
      });
      expect(called, isFalse);
    });

    test('can change the success type', () {
      final Either<Failure, String> result = right<Failure, int>(
        7,
      ).map((v) => 'value $v');
      expect(result, right<Failure, String>('value 7'));
    });
  });

  group('Either.mapLeft', () {
    test('transforms a Left value', () {
      expect(
        left<String, int>('boom').mapLeft(Failure.new),
        left<Failure, int>(const Failure('boom')),
      );
    });

    test('leaves a Right untouched', () {
      expect(
        right<String, int>(1).mapLeft(Failure.new),
        right<Failure, int>(1),
      );
    });

    test('does not call the transform for a Right', () {
      var called = false;
      right<String, int>(1).mapLeft((e) {
        called = true;
        return e;
      });
      expect(called, isFalse);
    });
  });

  group('Either.flatMap', () {
    Either<Failure, int> parse(String raw) {
      final parsed = int.tryParse(raw);
      return parsed == null ? left(const Failure('not a number')) : right(parsed);
    }

    test('chains a successful operation', () {
      expect(right<Failure, String>('42').flatMap(parse), right<Failure, int>(42));
    });

    test('propagates a failure from the chained operation', () {
      expect(
        right<Failure, String>('abc').flatMap(parse),
        left<Failure, int>(const Failure('not a number')),
      );
    });

    test('short-circuits when the receiver is already a Left', () {
      var called = false;
      final result = left<Failure, String>(const Failure('early')).flatMap((v) {
        called = true;
        return parse(v);
      });

      expect(called, isFalse);
      expect(result, left<Failure, int>(const Failure('early')));
    });

    test('composes several steps without nesting folds', () {
      final result = right<Failure, String>('10')
          .flatMap(parse)
          .map((v) => v * 3)
          .flatMap((v) => v > 20 ? right<Failure, int>(v) : left(const Failure('too small')));

      expect(result, right<Failure, int>(30));
    });
  });

  group('Either.flatMapAsync', () {
    Future<Either<Failure, int>> load(int id) async =>
        id > 0 ? right(id * 10) : left(const Failure('bad id'));

    test('chains a successful async operation', () async {
      expect(
        await right<Failure, int>(3).flatMapAsync(load),
        right<Failure, int>(30),
      );
    });

    test('propagates an async failure', () async {
      expect(
        await right<Failure, int>(-1).flatMapAsync(load),
        left<Failure, int>(const Failure('bad id')),
      );
    });

    test('short-circuits on an existing Left without awaiting', () async {
      var called = false;
      final result = await left<Failure, int>(
        const Failure('early'),
      ).flatMapAsync((v) async {
        called = true;
        return load(v);
      });

      expect(called, isFalse);
      expect(result, left<Failure, int>(const Failure('early')));
    });
  });

  group('Either.getOrElse', () {
    test('returns the success value for a Right', () {
      expect(right<Failure, int>(5).getOrElse((_) => 0), 5);
    });

    test('returns the fallback for a Left', () {
      expect(left<Failure, int>(const Failure('boom')).getOrElse((_) => 0), 0);
    });

    test('gives the fallback access to the failure', () {
      expect(
        left<Failure, String>(
          const Failure('boom'),
        ).getOrElse((f) => 'recovered: ${f.message}'),
        'recovered: boom',
      );
    });
  });

  group('Either.swap', () {
    test('turns a Right into a Left', () {
      expect(right<Failure, int>(1).swap(), left<int, Failure>(1));
    });

    test('turns a Left into a Right', () {
      expect(
        left<Failure, int>(const Failure('boom')).swap(),
        right<int, Failure>(const Failure('boom')),
      );
    });

    test('round-trips back to the original', () {
      final original = right<Failure, int>(9);
      expect(original.swap().swap(), original);
    });
  });

  group('Either.tryCatch', () {
    test('returns Right when the body succeeds', () {
      final result = Either.tryCatch(
        () => int.parse('123'),
        (e, st) => Failure('$e'),
      );
      expect(result, right<Failure, int>(123));
    });

    test('returns Left when the body throws', () {
      final result = Either.tryCatch(
        () => int.parse('abc'),
        (e, st) => const Failure('parse failed'),
      );
      expect(result, left<Failure, int>(const Failure('parse failed')));
    });

    test('passes the error and stack trace to onError', () {
      Object? seenError;
      StackTrace? seenStack;

      Either.tryCatch<Failure, int>(
        () => throw StateError('nope'),
        (e, st) {
          seenError = e;
          seenStack = st;
          return const Failure('x');
        },
      );

      expect(seenError, isA<StateError>());
      expect(seenStack, isNotNull);
    });

    test('does not swallow errors thrown by onError itself', () {
      expect(
        () => Either.tryCatch<Failure, int>(
          () => throw StateError('first'),
          (e, st) => throw ArgumentError('second'),
        ),
        throwsA(isA<ArgumentError>()),
      );
    });
  });

  group('Either.tryCatchAsync', () {
    test('returns Right when the future completes', () async {
      final result = await Either.tryCatchAsync(
        () async => 7,
        (e, st) => Failure('$e'),
      );
      expect(result, right<Failure, int>(7));
    });

    test('returns Left when the future throws', () async {
      final result = await Either.tryCatchAsync<Failure, int>(
        () async => throw StateError('nope'),
        (e, st) => const Failure('async failed'),
      );
      expect(result, left<Failure, int>(const Failure('async failed')));
    });

    test('returns Left when the body throws synchronously', () async {
      final result = await Either.tryCatchAsync<Failure, int>(
        () => throw StateError('sync throw'),
        (e, st) => const Failure('caught'),
      );
      expect(result, left<Failure, int>(const Failure('caught')));
    });

    test('passes the error and stack trace to onError', () async {
      Object? seenError;
      StackTrace? seenStack;

      await Either.tryCatchAsync<Failure, int>(
        () async => throw StateError('nope'),
        (e, st) {
          seenError = e;
          seenStack = st;
          return const Failure('x');
        },
      );

      expect(seenError, isA<StateError>());
      expect(seenStack, isNotNull);
    });
  });

  group('Either exhaustive switch', () {
    // The sealed hierarchy is what fabrik_result offers over non-sealed
    // alternatives: this compiles with no default branch.
    String describe(Either<Failure, int> result) => switch (result) {
      Left(value: final f) => 'error: ${f.message}',
      Right(value: final v) => 'ok: $v',
    };

    test('matches a Right', () {
      expect(describe(right(42)), 'ok: 42');
    });

    test('matches a Left', () {
      expect(describe(left(const Failure('boom'))), 'error: boom');
    });
  });
}
