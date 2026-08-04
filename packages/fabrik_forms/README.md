# fabrik_forms

Flutter's `Form` and `TextFormField` couple validation to widgets: to test
whether a sign-up form accepts an input, you have to build one.

`fabrik_forms` keeps form state outside the widget tree, so form logic is
testable on its own.

```dart
final form = FabrikForm({
  'email': FabrikField<String>(value: '', validators: [const EmailValidator()]),
});

form.update<String>('email', 'not-an-email');
form.isValid;  // false — no widgets involved
```

[![pub.dev](https://img.shields.io/pub/v/fabrik_forms.svg)](https://pub.dev/packages/fabrik_forms)
[![license](https://img.shields.io/github/license/abhakhand/fabrik)](https://github.com/abhakhand/fabrik/blob/main/LICENSE)
[![platform](https://img.shields.io/badge/platform-flutter-02569B.svg?logo=flutter)](https://flutter.dev)

---

## What's included

| API | What it does |
| --- | --- |
| **`FabrikField<T>`** | Holds a value, validators, and metadata (`isTouched`, `isDirty`, `error`, `visibleError`) |
| **`FabrikForm`** | Named field container with `isValid`, `isDirty`, `values`, `errors`, `markAllTouched`, `reset` |
| **`FabrikFormNotifier`** | `ValueNotifier` wrapper for reactive form state |
| **`FabrikFormBuilder`** | Declarative widget builder that rebuilds on form updates |
| **`RequiredValidator`** | Ensures the field is not empty |
| **`EmailValidator`** | Validates email format, optional or required |
| **`MinLengthValidator`** | Enforces a minimum character count |
| **`MaxLengthValidator`** | Enforces a maximum character count |
| **`PasswordValidator`** | Configurable complexity rules (uppercase, digit, special char, min length) |
| **`UrlValidator`** | Validates HTTP/HTTPS URLs, optional HTTPS-only mode |
| **`PhoneValidator`** | Validates local and international phone number formats |
| **`RangeValidator`** | Validates that a numeric value falls within an inclusive range |
| **`FieldsMatchValidator`** | Form-level rule requiring two fields to be equal (password confirmation) |
| **`FabrikFormRule`** | Form-level rule built from a plain function |

---

## Installation

```yaml
dependencies:
  fabrik_forms: ^0.2.0
```

```sh
flutter pub get
```

---

## Usage

### Setting up a form

Each field declares its own type, so one form can mix `String`, `int` and
`bool` values:

```dart
final formNotifier = FabrikFormNotifier(
  FabrikForm({
    'email': FabrikField<String>(
      value: '',
      validators: [const EmailValidator()],
    ),
    'password': FabrikField<String>(
      value: '',
      validators: [
        const PasswordValidator(
          requireDigit: true,
          requireSpecialChar: true,
        ),
      ],
    ),
    'age': FabrikField<int>(
      value: 18,
      validators: [const RangeValidator(min: 18, max: 120)],
    ),
    'subscribed': FabrikField<bool>(value: false),
  }),
);
```

Read fields back at their own type with `get<T>`:

```dart
final String email = formNotifier.get<String>('email').value;
final int age = formNotifier.get<int>('age').value;
```

### Building the UI

```dart
FabrikFormBuilder(
  formNotifier: formNotifier,
  builder: (context, form, get) {
    final emailField = get<String>('email');
    final passwordField = get<String>('password');

    return Column(
      children: [
        TextField(
          onChanged: (val) => formNotifier.update('email', val),
          decoration: InputDecoration(
            labelText: 'Email',
            errorText: emailField.visibleError,
          ),
        ),
        TextField(
          onChanged: (val) => formNotifier.update('password', val),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
            errorText: passwordField.visibleError,
          ),
        ),
        ElevatedButton(
          onPressed: () {
            if (formNotifier.isValid) {
              // submit formNotifier.values
            } else {
              formNotifier.markAllTouched(); // reveal all errors
            }
          },
          child: const Text('Sign In'),
        ),
      ],
    );
  },
);
```

### Resetting a form

```dart
// Restore all fields to initial values and clear touched/dirty state
formNotifier.reset();
```

---

## Validators

### RequiredValidator

```dart
RequiredValidator()
RequiredValidator(message: 'Name is required', trim: false)
```

### EmailValidator

```dart
EmailValidator()                          // required by default
EmailValidator(isRequired: false)         // optional — empty is valid
EmailValidator(invalidMessage: 'Bad email')
```

### MinLengthValidator / MaxLengthValidator

```dart
MinLengthValidator(min: 3)
MaxLengthValidator(max: 50, message: 'Keep it under 50 chars')
```

### PasswordValidator

```dart
PasswordValidator()                          // requires 8+ chars, non-empty
PasswordValidator(isRequired: false)         // optional password
PasswordValidator(
  minLength: 12,
  requireUppercase: true,
  requireDigit: true,
  requireSpecialChar: true,
)
```

### UrlValidator

```dart
UrlValidator()                          // accepts http and https
UrlValidator(requireHttps: true)        // https only
UrlValidator(isRequired: false)         // optional — empty is valid
```

### PhoneValidator

```dart
PhoneValidator()                        // required by default
PhoneValidator(isRequired: false)       // optional — empty is valid
// Accepts: +1 234 567 8900 · (123) 456-7890 · 123-456-7890 · 1234567890
```

### RangeValidator

```dart
RangeValidator(min: 1, max: 100)
RangeValidator(min: 0.0, max: 1.0, minMessage: 'Too low', maxMessage: 'Too high')
```

### Custom validators

```dart
class UsernameValidator extends FabrikValidator<String> {
  const UsernameValidator();

  @override
  String? call(String value) {
    if (value.contains(' ')) return 'No spaces allowed';
    return null;
  }
}
```

### Cross-field validation

Some rules span more than one field — password confirmation being the obvious
one. Those live at the form level:

```dart
FabrikForm(
  {
    'password': FabrikField<String>(value: ''),
    'confirmPassword': FabrikField<String>(value: ''),
  },
  validators: [
    const FieldsMatchValidator(
      field: 'password',
      matchField: 'confirmPassword',
      message: 'Passwords do not match',
    ),
  ],
);
```

The result surfaces on the form rather than on a single field:

```dart
form.formError;   // 'Passwords do not match'
form.isValid;     // false — form-level rules count toward validity
```

For one-off rules, `FabrikFormRule` wraps a plain function:

```dart
FabrikFormRule(
  (values) => (values['end'] as int) > (values['start'] as int)
      ? null
      : 'End must be after start',
);
```

---

## Field metadata

| Property | Type | Description |
| --- | --- | --- |
| `value` | `T` | Current field value |
| `error` | `String?` | First validation error (always set, regardless of touch) |
| `errors` | `List<String>` | Every failing rule, in validator order |
| `visibleError` | `String?` | First error, only exposed after the field is touched |
| `visibleErrors` | `List<String>` | Every error, only exposed after the field is touched |
| `isValid` | `bool` | No active errors |
| `isTouched` | `bool` | User has interacted with the field |
| `isDirty` | `bool` | Value differs from the original |

Use `errors` when several rules should be shown at once:

```dart
Column(
  children: [
    for (final message in passwordField.visibleErrors) Text(message),
  ],
);
```

---

## Documentation

Full API reference, guides, and the reasoning behind the design at
**[fabriktool.com](https://www.fabriktool.com)**.

- [Choosing a package](https://www.fabriktool.com/choosing-a-package/) — which package solves which problem
- [Core concepts](https://www.fabriktool.com/core-concepts/) — the patterns shared across the toolkit
- [`fabrik_forms` reference](https://www.fabriktool.com/packages/fabrik_forms/)

---

## Part of Fabrik

`fabrik_forms` is part of [Fabrik](https://github.com/abhakhand/fabrik), a Flutter
toolkit whose packages are independent — use this one on its own, or reach for
others as you need them.

| Package | Solves |
| --- | --- |
| [`fabrik_theme`](https://pub.dev/packages/fabrik_theme) | Semantic colors for error and helper text |
| [`fabrik_result`](https://pub.dev/packages/fabrik_result) | Typed failures for your submit handler |

---

## Contributing

Issues and pull requests are welcome on
[GitHub](https://github.com/abhakhand/fabrik). Changes are documented in
[CHANGELOG.md](CHANGELOG.md), with a migration note for anything breaking.

## License

[MIT](https://github.com/abhakhand/fabrik/blob/main/LICENSE) © [Ashish Bhakhand](https://github.com/abhakhand)
