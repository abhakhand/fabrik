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
  group('Option.fromNullable', () {
    test('wraps a non-null value in Some', () {
      expect(Option.fromNullable('hello'), some('hello'));
    });

    test('turns null into None', () {
      expect(Option.fromNullable<String>(null), none<String>());
    });

    test('treats falsy-but-present values as Some', () {
      expect(Option.fromNullable(0), some(0));
      expect(Option.fromNullable(''), some(''));
      expect(Option.fromNullable(false), some(false));
    });

    test('reads loosely typed map data', () {
      final json = <String, dynamic>{'name': 'Ada', 'nickname': null};

      expect(Option.fromNullable(json['name'] as String?), some('Ada'));
      expect(
        Option.fromNullable(json['nickname'] as String?),
        none<String>(),
      );
      expect(Option.fromNullable(json['missing'] as String?), none<String>());
    });
  });

  group('Option.toNullable', () {
    test('unwraps a Some', () {
      expect(some(42).toNullable(), 42);
    });

    test('returns null for None', () {
      expect(none<int>().toNullable(), isNull);
    });

    test('round-trips through fromNullable', () {
      expect(Option.fromNullable(7).toNullable(), 7);
      expect(Option.fromNullable<int>(null).toNullable(), isNull);
    });
  });

  group('Option.map', () {
    test('transforms a present value', () {
      expect(some('abc').map((v) => v.length), some(3));
    });

    test('leaves None untouched', () {
      expect(none<String>().map((v) => v.length), none<int>());
    });

    test('does not call the transform for None', () {
      var called = false;
      none<String>().map((v) {
        called = true;
        return v;
      });
      expect(called, isFalse);
    });
  });

  group('Option.flatMap', () {
    Option<int> parse(String raw) => Option.fromNullable(int.tryParse(raw));

    test('chains into another Some', () {
      expect(some('42').flatMap(parse), some(42));
    });

    test('collapses to None when the chain fails', () {
      expect(some('abc').flatMap(parse), none<int>());
    });

    test('short-circuits on None', () {
      var called = false;
      final result = none<String>().flatMap((v) {
        called = true;
        return parse(v);
      });

      expect(called, isFalse);
      expect(result, none<int>());
    });
  });

  group('Option.getOrElse', () {
    test('returns the contained value', () {
      expect(some('Ada').getOrElse(() => 'Anonymous'), 'Ada');
    });

    test('returns the fallback for None', () {
      expect(none<String>().getOrElse(() => 'Anonymous'), 'Anonymous');
    });

    test('does not evaluate the fallback for Some', () {
      var called = false;
      some('Ada').getOrElse(() {
        called = true;
        return 'Anonymous';
      });
      expect(called, isFalse);
    });
  });

  group('Option.where', () {
    test('keeps a value that satisfies the predicate', () {
      expect(some(21).where((v) => v >= 18), some(21));
    });

    test('drops a value that fails the predicate', () {
      expect(some(12).where((v) => v >= 18), none<int>());
    });

    test('leaves None as None', () {
      expect(none<int>().where((v) => v >= 18), none<int>());
    });

    test('does not call the predicate for None', () {
      var called = false;
      none<int>().where((v) {
        called = true;
        return true;
      });
      expect(called, isFalse);
    });
  });

  group('Option.toEither', () {
    test('a Some becomes a Right', () {
      expect(
        some(42).toEither(() => const Failure('missing')),
        right<Failure, int>(42),
      );
    });

    test('a None becomes a Left carrying the supplied failure', () {
      expect(
        none<int>().toEither(() => const Failure('missing')),
        left<Failure, int>(const Failure('missing')),
      );
    });

    test('does not build the failure for a Some', () {
      var called = false;
      some(1).toEither(() {
        called = true;
        return const Failure('missing');
      });
      expect(called, isFalse);
    });

    test('bridges nullable input straight through to Either', () {
      Either<Failure, String> read(String? raw) =>
          Option.fromNullable(raw).toEither(() => const Failure('absent'));

      expect(read('ok'), right<Failure, String>('ok'));
      expect(read(null), left<Failure, String>(const Failure('absent')));
    });
  });

  group('Option exhaustive switch', () {
    String describe(Option<int> option) => switch (option) {
      Some(value: final v) => 'got $v',
      None() => 'nothing',
    };

    test('matches Some', () {
      expect(describe(some(3)), 'got 3');
    });

    test('matches None', () {
      expect(describe(none<int>()), 'nothing');
    });
  });
}
