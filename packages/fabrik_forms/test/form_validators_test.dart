import 'package:fabrik_forms/fabrik_forms.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FieldsMatchValidator', () {
    FabrikForm passwordForm({
      String password = 'secret123',
      String confirm = 'secret123',
    }) => FabrikForm(
      {
        'password': FabrikField<String>(value: password),
        'confirm': FabrikField<String>(value: confirm),
      },
      validators: [
        const FieldsMatchValidator(
          field: 'password',
          matchField: 'confirm',
          message: 'Passwords do not match',
        ),
      ],
    );

    test('matching values leave the form valid', () {
      final form = passwordForm();

      expect(form.isValid, isTrue);
      expect(form.formError, isNull);
      expect(form.formErrors, isEmpty);
    });

    test('a mismatch invalidates the form', () {
      final form = passwordForm(confirm: 'different');

      expect(form.isValid, isFalse);
      expect(form.formError, 'Passwords do not match');
    });

    test('the error clears once the fields agree', () {
      final form = passwordForm(confirm: 'different');
      expect(form.isValid, isFalse);

      form.update<String>('confirm', 'secret123');

      expect(form.isValid, isTrue);
      expect(form.formError, isNull);
    });

    test('a mismatch appearing later is caught', () {
      final form = passwordForm();
      expect(form.isValid, isTrue);

      form.update<String>('password', 'changed');

      expect(form.isValid, isFalse);
      expect(form.formError, 'Passwords do not match');
    });

    test('reset re-runs the form validators', () {
      final form = passwordForm(confirm: 'different');
      form.update<String>('confirm', 'secret123');
      expect(form.isValid, isTrue);

      form.reset();

      expect(form.formError, 'Passwords do not match');
    });

    test('markAllTouched re-runs the form validators', () {
      final form = passwordForm(confirm: 'different');

      form.markAllTouched();

      expect(form.formError, 'Passwords do not match');
    });

    test('uses a default message when none is supplied', () {
      final form = FabrikForm(
        {
          'a': FabrikField<String>(value: 'x'),
          'b': FabrikField<String>(value: 'y'),
        },
        validators: [
          const FieldsMatchValidator(field: 'a', matchField: 'b'),
        ],
      );

      expect(form.formError, 'Fields do not match');
    });
  });

  group('FabrikFormRule', () {
    test('expresses an inline cross-field rule', () {
      final form = FabrikForm(
        {
          'start': FabrikField<int>(value: 10),
          'end': FabrikField<int>(value: 5),
        },
        validators: [
          FabrikFormRule(
            (values) => (values['end'] as int) > (values['start'] as int)
                ? null
                : 'End must be after start',
          ),
        ],
      );

      expect(form.isValid, isFalse);
      expect(form.formError, 'End must be after start');

      form.update<int>('end', 20);
      expect(form.isValid, isTrue);
    });

    test('sees a snapshot of every field value', () {
      Map<String, dynamic>? seen;

      FabrikForm(
        {
          'a': FabrikField<String>(value: 'x'),
          'b': FabrikField<int>(value: 1),
        },
        validators: [
          FabrikFormRule((values) {
            seen = values;
            return null;
          }),
        ],
      );

      expect(seen, {'a': 'x', 'b': 1});
    });
  });

  group('multiple form validators', () {
    test('collects every failing rule', () {
      final form = FabrikForm(
        {
          'a': FabrikField<String>(value: '1'),
          'b': FabrikField<String>(value: '2'),
        },
        validators: [
          const FieldsMatchValidator(
            field: 'a',
            matchField: 'b',
            message: 'first rule failed',
          ),
          FabrikFormRule((_) => 'second rule failed'),
        ],
      );

      expect(form.formErrors, ['first rule failed', 'second rule failed']);
      expect(form.formError, 'first rule failed');
    });

    test('form-level failures block validity even when fields are valid', () {
      final form = FabrikForm(
        {'a': FabrikField<String>(value: 'ok')},
        validators: [FabrikFormRule((_) => 'nope')],
      );

      expect(form.errors['a'], isNull);
      expect(form.isValid, isFalse);
    });

    test('a form without validators has no form errors', () {
      final form = FabrikForm({'a': FabrikField<String>(value: 'ok')});

      expect(form.formError, isNull);
      expect(form.formErrors, isEmpty);
      expect(form.isValid, isTrue);
    });
  });

  group('FabrikFormNotifier exposes form-level state', () {
    test('surfaces formError and notifies on update', () {
      final notifier = FabrikFormNotifier(
        FabrikForm(
          {
            'password': FabrikField<String>(value: 'secret123'),
            'confirm': FabrikField<String>(value: 'different'),
          },
          validators: [
            const FieldsMatchValidator(
              field: 'password',
              matchField: 'confirm',
              message: 'Passwords do not match',
            ),
          ],
        ),
      );

      var notifications = 0;
      notifier.addListener(() => notifications++);

      expect(notifier.isValid, isFalse);
      expect(notifier.formError, 'Passwords do not match');

      notifier.update<String>('confirm', 'secret123');

      expect(notifications, 1);
      expect(notifier.isValid, isTrue);
      expect(notifier.formError, isNull);

      notifier.dispose();
    });
  });
}
