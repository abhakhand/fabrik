# fabrik_forms

A clean, UI-agnostic form state and validation system for Flutter.  
Lightweight, composable, and ideal for both reactive UI or integration with any state management solution.

---

## Features

- ✅ Easy field-level validation using reusable validator classes
- ✅ Centralized form state with `.isValid`, `.isDirty`, `.isTouched`, `.values`, and `.errors`
- ✅ `FabrikFormNotifier` for reactive patterns via `ValueNotifier`
- ✅ `FabrikFormBuilder` widget for clean, declarative UI
- ✅ Built-in validators: `Required`, `Email`, `MinLength`, `MaxLength`, `Password`
- ✅ Full testability and UI-agnostic design
- ✅ Works with or without Flutter — logic is decoupled

---

## Quick Example

```dart
final formNotifier = FabrikFormNotifier<String>(
  FabrikForm({
    'email': FabrikField<String>(
      value: '',
      validators: [EmailValidator()],
    ),
    'password': FabrikField<String>(
      value: '',
      validators: [
        PasswordValidator(
          requireDigit: true,
          requireSpecialChar: true,
        ),
      ],
    ),
  }),
);
```

In your widget:

```dart
FabrikFormBuilder<String>(
  formNotifier: formNotifier,
  builder: (context, form, get) {
    final emailField = get<String>('email');
    final passwordField = get<String>('password');

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            initialValue: emailField.value,
            onChanged: (val) => formNotifier.update('email', val),
            decoration: InputDecoration(
              labelText: 'Email',
              errorText: emailField.visibleError,
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            initialValue: passwordField.value,
            onChanged: (val) => formNotifier.update('password', val),
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
              errorText: passwordField.visibleError,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _onSubmit,
            child: const Text('Sign In'),
          ),
        ],
      ),
    );
  },
);
```

---

## API Overview

### Core

- `FabrikField<T>` — holds a value, validators, and metadata (`isTouched`, `isDirty`, `error`)
- `FabrikForm<T>` — a group of named fields with validation, values, and error tracking
- `FabrikFormNotifier<T>` — a `ValueNotifier` for form reactivity
- `FabrikFormBuilder<T>` — a `StatelessWidget` builder wrapper

### Built-in Validators

- `RequiredValidator`
- `MinLengthValidator`
- `MaxLengthValidator`
- `EmailValidator`
- `PasswordValidator`

---
