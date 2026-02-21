import 'package:fabrik_forms/fabrik_forms.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FabrikField', () {
    // =========================================================================
    // Initial state
    // =========================================================================

    group('initial state', () {
      test('holds the initial value', () {
        final field = FabrikField(value: 'hello');
        expect(field.value, 'hello');
      });

      test('is not touched on creation', () {
        final field = FabrikField(value: '');
        expect(field.isTouched, isFalse);
      });

      test('is not dirty on creation', () {
        final field = FabrikField(value: 'hello');
        expect(field.isDirty, isFalse);
      });

      test('runs validators on creation', () {
        final field = FabrikField(
          value: '',
          validators: [const RequiredValidator()],
        );
        expect(field.error, 'This field is required');
        expect(field.isValid, isFalse);
      });

      test('visibleError is null when not touched', () {
        final field = FabrikField(
          value: '',
          validators: [const RequiredValidator()],
        );
        expect(field.visibleError, isNull);
      });

      test('is valid when no validators are set', () {
        final field = FabrikField(value: '');
        expect(field.isValid, isTrue);
        expect(field.error, isNull);
      });
    });

    // =========================================================================
    // update()
    // =========================================================================

    group('update()', () {
      test('updates the value', () {
        final field = FabrikField(value: 'before');
        field.update('after');
        expect(field.value, 'after');
      });

      test('marks field as touched', () {
        final field = FabrikField(value: 'hello');
        field.update('world');
        expect(field.isTouched, isTrue);
      });

      test('marks field as dirty when value changes', () {
        final field = FabrikField(value: 'before');
        field.update('after');
        expect(field.isDirty, isTrue);
      });

      test('not dirty when updated back to initial value', () {
        final field = FabrikField(value: 'hello');
        field.update('world');
        field.update('hello');
        expect(field.isDirty, isFalse);
      });

      test('re-runs validators on update', () {
        final field = FabrikField(
          value: '',
          validators: [const RequiredValidator()],
        );
        expect(field.isValid, isFalse);
        field.update('hello');
        expect(field.isValid, isTrue);
        expect(field.error, isNull);
      });

      test('visibleError shown after touch via update', () {
        final field = FabrikField(
          value: '',
          validators: [const RequiredValidator()],
        );
        field.update('');
        expect(field.visibleError, 'This field is required');
      });
    });

    // =========================================================================
    // markTouched()
    // =========================================================================

    group('markTouched()', () {
      test('marks field as touched without changing value', () {
        final field = FabrikField(value: 'hello');
        field.markTouched();
        expect(field.isTouched, isTrue);
        expect(field.value, 'hello');
      });

      test('exposes visibleError after markTouched', () {
        final field = FabrikField(
          value: '',
          validators: [const RequiredValidator()],
        );
        field.markTouched();
        expect(field.visibleError, 'This field is required');
      });

      test('does not change isDirty', () {
        final field = FabrikField(value: 'hello');
        field.markTouched();
        expect(field.isDirty, isFalse);
      });
    });

    // =========================================================================
    // reset()
    // =========================================================================

    group('reset()', () {
      test('restores the initial value', () {
        final field = FabrikField(value: 'original');
        field.update('changed');
        field.reset();
        expect(field.value, 'original');
      });

      test('clears touched state', () {
        final field = FabrikField(value: 'hello');
        field.update('world');
        expect(field.isTouched, isTrue);
        field.reset();
        expect(field.isTouched, isFalse);
      });

      test('clears dirty state', () {
        final field = FabrikField(value: 'hello');
        field.update('world');
        expect(field.isDirty, isTrue);
        field.reset();
        expect(field.isDirty, isFalse);
      });

      test('re-runs validators after reset', () {
        final field = FabrikField(
          value: '',
          validators: [const RequiredValidator()],
        );
        field.update('filled');
        expect(field.isValid, isTrue);
        field.reset();
        // Initial value was '' — should be invalid again
        expect(field.isValid, isFalse);
      });

      test('visibleError is hidden after reset (not touched)', () {
        final field = FabrikField(
          value: '',
          validators: [const RequiredValidator()],
        );
        field.update('');
        expect(field.visibleError, isNotNull);
        field.reset();
        expect(field.visibleError, isNull);
      });
    });

    // =========================================================================
    // Multiple validators
    // =========================================================================

    group('multiple validators', () {
      test('returns first failing validator error', () {
        final field = FabrikField(
          value: '',
          validators: [
            const RequiredValidator(message: 'Required'),
            const MinLengthValidator(min: 5, message: 'Too short'),
          ],
        );
        expect(field.error, 'Required');
      });

      test('returns second error if first passes', () {
        final field = FabrikField(
          value: 'hi',
          validators: [
            const RequiredValidator(message: 'Required'),
            const MinLengthValidator(min: 5, message: 'Too short'),
          ],
        );
        expect(field.error, 'Too short');
      });

      test('is valid when all validators pass', () {
        final field = FabrikField(
          value: 'hello world',
          validators: [
            const RequiredValidator(),
            const MinLengthValidator(min: 5),
          ],
        );
        expect(field.isValid, isTrue);
      });
    });
  });
}
