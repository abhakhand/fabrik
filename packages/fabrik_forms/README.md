# fabrik_forms

A clean, UI-agnostic form state and validation system for Flutter.

[![pub.dev](https://img.shields.io/pub/v/fabrik_forms.svg)](https://pub.dev/packages/fabrik_forms)
[![license](https://img.shields.io/github/license/abhakhand/fabrik)](https://github.com/abhakhand/fabrik/blob/main/LICENSE)
[![platform](https://img.shields.io/badge/platform-flutter-02569B.svg?logo=flutter)](https://flutter.dev)

---

## What's included

| API | What it does |
| --- | --- |
| **`FabrikField<T>`** | Holds a value, validators, and metadata (`isTouched`, `isDirty`, `error`, `visibleError`) |
| **`FabrikForm<T>`** | Named field container with `isValid`, `isDirty`, `values`, `errors`, `markAllTouched`, `reset` |
| **`FabrikFormNotifier<T>`** | `ValueNotifier` wrapper for reactive form state |
| **`FabrikFormBuilder<T>`** | Declarative widget builder that rebuilds on form updates |
| **`RequiredValidator`** | Ensures the field is not empty |
| **`EmailValidator`** | Validates email format, optional or required |
| **`MinLengthValidator`** | Enforces a minimum character count |
| **`MaxLengthValidator`** | Enforces a maximum character count |
| **`PasswordValidator`** | Configurable complexity rules (uppercase, digit, special char, min length) |
| **`UrlValidator`** | Validates HTTP/HTTPS URLs, optional HTTPS-only mode |
| **`PhoneValidator`** | Validates local and international phone number formats |
| **`RangeValidator`** | Validates that a numeric value falls within an inclusive range |

---

## Installation

```yaml
dependencies:
  fabrik_forms: ^0.1.0
```

```sh
flutter pub get
```

---

## Usage

### Setting up a form

```dart
final formNotifier = FabrikFormNotifier<String>(
  FabrikForm({
    'email': FabrikField(
      value: '',
      validators: [const EmailValidator()],
    ),
    'password': FabrikField(
      value: '',
      validators: [
        const PasswordValidator(
          requireDigit: true,
          requireSpecialChar: true,
        ),
      ],
    ),
  }),
);
```

### Building the UI

```dart
FabrikFormBuilder<String>(
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

---

## Field metadata

| Property | Type | Description |
| --- | --- | --- |
| `value` | `T` | Current field value |
| `error` | `String?` | Validation error (always set, regardless of touch) |
| `visibleError` | `String?` | Error only exposed after the field is touched |
| `isValid` | `bool` | No active errors |
| `isTouched` | `bool` | User has interacted with the field |
| `isDirty` | `bool` | Value differs from the original |

---

## Documentation

Full API reference and guides at **[fabriktool.com](https://www.fabriktool.com)**

---

## Contributing

Found a bug or have a suggestion?
Open an issue or pull request on [GitHub](https://github.com/abhakhand/fabrik).

## Maintainers

- [Ashish Bhakhand](https://github.com/abhakhand)
