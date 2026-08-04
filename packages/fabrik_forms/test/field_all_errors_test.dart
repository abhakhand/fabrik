import 'package:fabrik_forms/fabrik_forms.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FabrikField.errors', () {
    test('collects every failing validator in order', () {
      final field = FabrikField<String>(
        value: '',
        validators: [
          const RequiredValidator(),
          const MinLengthValidator(min: 8),
        ],
      );

      expect(field.errors, ['This field is required', 'Too short']);
    });

    test('error still reports only the first failure', () {
      final field = FabrikField<String>(
        value: '',
        validators: [
          const RequiredValidator(),
          const MinLengthValidator(min: 8),
        ],
      );

      expect(field.error, 'This field is required');
    });

    test('is empty for a valid field', () {
      final field = FabrikField<String>(
        value: 'long enough',
        validators: [const MinLengthValidator(min: 3)],
      );

      expect(field.errors, isEmpty);
      expect(field.error, isNull);
      expect(field.isValid, isTrue);
    });

    test('is empty when the field has no validators', () {
      expect(FabrikField<String>(value: 'x').errors, isEmpty);
    });

    test('updates as the value changes', () {
      final field = FabrikField<String>(
        value: '',
        validators: [
          const RequiredValidator(),
          const MinLengthValidator(min: 5),
        ],
      );
      expect(field.errors, hasLength(2));

      field.update('abc');
      expect(field.errors, ['Too short']);

      field.update('abcdef');
      expect(field.errors, isEmpty);
    });

    test('the returned list cannot be mutated by callers', () {
      final field = FabrikField<String>(
        value: '',
        validators: [const RequiredValidator()],
      );

      expect(() => field.errors.add('injected'), throwsUnsupportedError);
    });
  });

  group('FabrikField.visibleErrors', () {
    test('is empty until the field is touched', () {
      final field = FabrikField<String>(
        value: '',
        validators: [
          const RequiredValidator(),
          const MinLengthValidator(min: 8),
        ],
      );

      expect(field.errors, hasLength(2));
      expect(field.visibleErrors, isEmpty);
      expect(field.visibleError, isNull);
    });

    test('mirrors errors once touched', () {
      final field = FabrikField<String>(
        value: '',
        validators: [
          const RequiredValidator(),
          const MinLengthValidator(min: 8),
        ],
      );

      field.markTouched();

      expect(field.visibleErrors, field.errors);
      expect(field.visibleError, field.error);
    });

    test('clears again after reset', () {
      final field = FabrikField<String>(
        value: '',
        validators: [const RequiredValidator()],
      );
      field.markTouched();
      expect(field.visibleErrors, isNotEmpty);

      field.reset();

      expect(field.visibleErrors, isEmpty);
    });
  });

  group('FabrikForm.allErrors', () {
    test('reports every error for every field', () {
      final form = FabrikForm({
        'password': FabrikField<String>(
          value: '',
          validators: [
            const RequiredValidator(),
            const MinLengthValidator(min: 8),
          ],
        ),
        'name': FabrikField<String>(value: 'Ada'),
      });

      expect(form.allErrors['password'], hasLength(2));
      expect(form.allErrors['name'], isEmpty);
      expect(form.errors['password'], 'This field is required');
    });
  });

  group('PasswordValidator rule order', () {
    test('reports length before the character-class rules', () {
      const validator = PasswordValidator(
        requireUppercase: true,
        requireDigit: true,
      );

      // Satisfies uppercase and digit, but is too short.
      expect(validator('aB1'), 'Password must be 8 characters or more');
    });

    test('reports character-class rules once the length passes', () {
      const validator = PasswordValidator(requireUppercase: true);

      expect(validator('abcdefgh'), 'Must include uppercase letter');
    });

    test('still reports the required message for an empty value', () {
      const validator = PasswordValidator(requireUppercase: true);

      expect(validator(''), 'Password is required');
    });

    test('passes when every rule is satisfied', () {
      const validator = PasswordValidator(
        requireUppercase: true,
        requireDigit: true,
        requireSpecialChar: true,
      );

      expect(validator('Passw0rd!'), isNull);
    });
  });
}
