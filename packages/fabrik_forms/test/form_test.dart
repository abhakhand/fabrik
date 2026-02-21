import 'package:fabrik_forms/fabrik_forms.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // ===========================================================================
  // FabrikForm
  // ===========================================================================

  group('FabrikForm', () {
    FabrikForm<String> makeForm({
      String email = '',
      String name = 'Alice',
    }) {
      return FabrikForm({
        'email': FabrikField(
          value: email,
          validators: [const EmailValidator()],
        ),
        'name': FabrikField(
          value: name,
          validators: [const RequiredValidator()],
        ),
      });
    }

    group('isValid', () {
      test('returns false when any field is invalid', () {
        final form = makeForm(email: '');
        expect(form.isValid, isFalse);
      });

      test('returns true when all fields are valid', () {
        final form = makeForm(email: 'user@example.com');
        expect(form.isValid, isTrue);
      });
    });

    group('isDirty', () {
      test('returns false when no fields have changed', () {
        final form = makeForm(email: 'user@example.com');
        expect(form.isDirty, isFalse);
      });

      test('returns true when any field has changed', () {
        final form = makeForm(email: 'user@example.com');
        form.update<String>('name', 'Bob');
        expect(form.isDirty, isTrue);
      });
    });

    group('isTouched', () {
      test('returns false before any interaction', () {
        final form = makeForm();
        expect(form.isTouched, isFalse);
      });

      test('returns true after updating a field', () {
        final form = makeForm();
        form.update<String>('email', 'x@x.com');
        expect(form.isTouched, isTrue);
      });
    });

    group('values', () {
      test('returns map of all current field values', () {
        final form = makeForm(email: 'u@u.com', name: 'Bob');
        expect(form.values, {'email': 'u@u.com', 'name': 'Bob'});
      });
    });

    group('errors', () {
      test('returns map with null for valid fields', () {
        final form = makeForm(email: 'u@u.com', name: 'Alice');
        expect(form.errors['email'], isNull);
        expect(form.errors['name'], isNull);
      });

      test('returns error for invalid fields', () {
        final form = makeForm(email: '');
        expect(form.errors['email'], isNotNull);
      });
    });

    group('get()', () {
      test('retrieves typed field by key', () {
        final form = makeForm(email: 'u@u.com');
        final field = form.get<String>('email');
        expect(field.value, 'u@u.com');
      });
    });

    group('update()', () {
      test('updates the named field value', () {
        final form = makeForm(email: '');
        form.update<String>('email', 'new@example.com');
        expect(form.get<String>('email').value, 'new@example.com');
      });

      test('marks the field touched', () {
        final form = makeForm();
        form.update<String>('name', 'Bob');
        expect(form.get<String>('name').isTouched, isTrue);
      });
    });

    group('markAllTouched()', () {
      test('marks every field as touched', () {
        final form = makeForm();
        form.markAllTouched();
        expect(form.get<String>('email').isTouched, isTrue);
        expect(form.get<String>('name').isTouched, isTrue);
      });

      test('exposes visibleError on all fields after markAllTouched', () {
        final form = makeForm(email: '');
        form.markAllTouched();
        expect(form.get<String>('email').visibleError, isNotNull);
      });
    });

    group('reset()', () {
      test('restores all fields to initial values', () {
        final form = makeForm(email: 'u@u.com', name: 'Alice');
        form.update<String>('email', 'other@x.com');
        form.update<String>('name', 'Bob');
        form.reset();
        expect(form.get<String>('email').value, 'u@u.com');
        expect(form.get<String>('name').value, 'Alice');
      });

      test('clears dirty state after reset', () {
        final form = makeForm(email: 'u@u.com');
        form.update<String>('name', 'Changed');
        expect(form.isDirty, isTrue);
        form.reset();
        expect(form.isDirty, isFalse);
      });

      test('clears touched state after reset', () {
        final form = makeForm();
        form.markAllTouched();
        form.reset();
        expect(form.isTouched, isFalse);
      });
    });
  });

  // ===========================================================================
  // FabrikFormNotifier
  // ===========================================================================

  group('FabrikFormNotifier', () {
    FabrikFormNotifier<String> makeNotifier({
      String email = '',
      String name = 'Alice',
    }) {
      return FabrikFormNotifier(
        FabrikForm({
          'email': FabrikField(
            value: email,
            validators: [const EmailValidator()],
          ),
          'name': FabrikField(
            value: name,
            validators: [const RequiredValidator()],
          ),
        }),
      );
    }

    test('notifies listeners when update() is called', () {
      final notifier = makeNotifier();
      var notified = false;
      notifier.addListener(() => notified = true);

      notifier.update<String>('name', 'Bob');
      expect(notified, isTrue);
    });

    test('notifies listeners when markAllTouched() is called', () {
      final notifier = makeNotifier();
      var notified = false;
      notifier.addListener(() => notified = true);

      notifier.markAllTouched();
      expect(notified, isTrue);
    });

    test('notifies listeners when reset() is called', () {
      final notifier = makeNotifier();
      notifier.update<String>('name', 'Bob');

      var notified = false;
      notifier.addListener(() => notified = true);

      notifier.reset();
      expect(notified, isTrue);
    });

    test('reset() restores form to initial values', () {
      final notifier = makeNotifier(email: 'u@u.com', name: 'Alice');
      notifier.update<String>('name', 'Changed');
      notifier.reset();
      expect(notifier.get<String>('name').value, 'Alice');
      expect(notifier.isDirty, isFalse);
    });

    test('isValid delegates to underlying form', () {
      final notifier = makeNotifier(email: 'u@u.com');
      expect(notifier.isValid, isTrue);
    });

    test('isDirty delegates to underlying form', () {
      final notifier = makeNotifier();
      notifier.update<String>('name', 'Bob');
      expect(notifier.isDirty, isTrue);
    });

    test('values returns all field values', () {
      final notifier = makeNotifier(email: 'u@u.com', name: 'Alice');
      final v = notifier.values;
      expect(v['email'], 'u@u.com');
      expect(v['name'], 'Alice');
    });

    test('errors returns field errors', () {
      final notifier = makeNotifier(email: '');
      expect(notifier.errors['email'], isNotNull);
    });

    test('get() returns field from underlying form', () {
      final notifier = makeNotifier(name: 'Alice');
      expect(notifier.get<String>('name').value, 'Alice');
    });
  });
}
