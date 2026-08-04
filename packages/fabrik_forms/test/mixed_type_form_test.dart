import 'package:fabrik_forms/fabrik_forms.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // A form holds fields of different types — the thing the previous
  // `FabrikForm<T>` signature made impossible.
  FabrikForm signupForm() => FabrikForm({
    'email': FabrikField<String>(value: '', validators: [const EmailValidator()]),
    'age': FabrikField<int>(
      value: 0,
      validators: [const RangeValidator(min: 18, max: 120)],
    ),
    'subscribed': FabrikField<bool>(value: false),
  });

  group('mixed-type forms', () {
    test('holds String, int and bool fields side by side', () {
      final form = signupForm();

      expect(form.values, {'email': '', 'age': 0, 'subscribed': false});
    });

    test('get returns each field at its own type', () {
      final form = signupForm();

      final String email = form.get<String>('email').value;
      final int age = form.get<int>('age').value;
      final bool subscribed = form.get<bool>('subscribed').value;

      expect(email, '');
      expect(age, 0);
      expect(subscribed, false);
    });

    test('typed validators run against their own field type', () {
      final form = signupForm();

      expect(form.errors['email'], 'Email is required');
      expect(form.errors['age'], 'Must be at least 18');
      expect(form.errors['subscribed'], isNull);
    });

    test('updates keep their type and revalidate', () {
      final form = signupForm();

      form.update<int>('age', 25);
      expect(form.get<int>('age').value, 25);
      expect(form.errors['age'], isNull);

      form.update<String>('email', 'user@example.com');
      expect(form.errors['email'], isNull);

      form.update<bool>('subscribed', true);
      expect(form.get<bool>('subscribed').value, isTrue);
      expect(form.isValid, isTrue);
    });

    test('a numeric range validator attaches to a typed int field', () {
      final field = FabrikField<int>(
        value: 5,
        validators: [const RangeValidator(min: 1, max: 10)],
      );

      expect(field.isValid, isTrue);
      field.update(50);
      expect(field.error, 'Must be at most 10');
    });

    test('a numeric range validator attaches to a typed double field', () {
      final field = FabrikField<double>(
        value: 0.5,
        validators: [const RangeValidator(min: 0, max: 1)],
      );

      expect(field.isValid, isTrue);
      field.update(1.5);
      expect(field.error, 'Must be at most 1');
    });
  });

  group('field lookup errors', () {
    test('an unknown key names the available fields', () {
      final form = signupForm();

      expect(
        () => form.get<String>('emial'),
        throwsA(
          isA<ArgumentError>().having(
            (e) => e.message,
            'message',
            allOf(
              contains('emial'),
              contains('email'),
              contains('age'),
              contains('subscribed'),
            ),
          ),
        ),
      );
    });

    test('update on an unknown key reports the same way', () {
      final form = signupForm();

      expect(
        () => form.update<String>('emial', 'x'),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('requesting the wrong type explains the mismatch', () {
      final form = signupForm();

      expect(
        () => form.get<int>('email'),
        throwsA(
          isA<StateError>().having(
            (e) => e.message,
            'message',
            allOf(contains('email'), contains('String'), contains('int')),
          ),
        ),
      );
    });

    test('a field declared without a type argument says how to fix it', () {
      final form = FabrikForm({'name': FabrikField(value: 'Ada')});

      expect(
        () => form.get<String>('name'),
        throwsA(
          isA<StateError>().having(
            (e) => e.message,
            'message',
            contains('FabrikField<String>'),
          ),
        ),
      );
    });

    test('contains and keys expose the field set', () {
      final form = signupForm();

      expect(form.contains('email'), isTrue);
      expect(form.contains('nope'), isFalse);
      expect(form.keys, containsAll(<String>['email', 'age', 'subscribed']));
    });
  });
}
