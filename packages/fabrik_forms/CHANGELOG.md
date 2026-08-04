## 0.2.0

This release makes `fabrik_forms` usable for real forms. The headline change is
that a form is no longer locked to a single field type.

### Breaking

- **Changed:** `FabrikForm`, `FabrikFormNotifier`, and `FabrikFormBuilder` no longer take a type parameter. A form previously had one `T` for every field, so a signup form with a `String` email, an `int` age, and a `bool` opt-in could not be expressed — the shipped example was `FabrikFormNotifier<String>` for exactly this reason. Each field now carries its own type and its own validators, and types are recovered at the call site with `get<T>('key')`.

  ```dart
  // before
  FabrikForm<String>({ 'email': FabrikField(value: '') });

  // after
  FabrikForm({
    'email': FabrikField<String>(value: '', validators: [EmailValidator()]),
    'age': FabrikField<int>(value: 0, validators: [RangeValidator(min: 18, max: 120)]),
    'subscribed': FabrikField<bool>(value: false),
  });
  ```

  To migrate, drop the type argument from `FabrikForm<T>` / `FabrikFormNotifier<T>` / `FabrikFormBuilder<T>` and put it on each `FabrikField<T>` instead. Declaring a field without its type argument makes it a `FabrikField<dynamic>`; `get<T>` then throws a `StateError` telling you which declaration to annotate.

- **Changed:** `RangeValidator` is now generic over `num` subtypes, so it attaches to a `FabrikField<int>` or `FabrikField<double>` rather than only `FabrikField<num>`. Existing `RangeValidator(min:, max:)` call sites are unaffected.

- **Changed:** `PasswordValidator` checks `minLength` before the uppercase, digit, and special-character rules, so the most basic failure is reported first. A short password that satisfies the character rules now reports the length message instead of passing those checks and reporting length last.

### New

- **New:** Form-level validators for rules that span multiple fields, passed via `FabrikForm(fields, validators: [...])` and surfaced through `formError` / `formErrors`. They count towards `isValid`.
  - `FieldsMatchValidator` — the password-confirmation case, ready made.
  - `FabrikFormRule` — wraps a plain function for one-off rules.
  - `FabrikFormValidator` — the base class for custom rules.
- **New:** `FabrikField.errors` and `visibleErrors` return *every* failing rule, alongside the existing first-error `error` and `visibleError`. `FabrikForm.allErrors` exposes the same per field.
- **New:** `FabrikForm.contains(key)` and `FabrikForm.keys` for inspecting the field set.

### Fixes

- **Fix:** Looking up an unknown field key threw `Null check operator used on a null value`, naming neither the key nor the valid ones. `get` and `update` now throw an `ArgumentError` that names the missing key and lists the available fields.

### Tests

- Test suite grown from 98 to 136 tests, covering mixed-type forms, cross-field validation, multi-error reporting, and the lookup failure modes.

---

## 0.1.0

- **New**: `UrlValidator` — validates HTTP/HTTPS URLs with optional `requireHttps` flag
- **New**: `PhoneValidator` — validates common local and international phone formats
- **New**: `RangeValidator` — validates that a numeric value falls within an inclusive `min..max` range
- **New**: `FabrikField.reset()` — restores field to its initial value and clears touched/dirty state
- **New**: `FabrikForm.reset()` — resets all fields at once
- **New**: `FabrikFormNotifier.reset()` — resets the form and notifies listeners
- **New**: `PasswordValidator.isRequired` — allows optional password fields (mirrors `EmailValidator`)
- **Fix**: `EmailValidator` — empty value with `isRequired: false` now correctly returns `null` instead of `invalidMessage`
- **Improvement**: `PasswordValidator` special character set expanded to include `-`, `_`, `+`, `=`, `[`, `]`, `/`, `~`, and `` ` ``
- **Tests**: Added full test suite — 98 tests across validators, `FabrikField`, `FabrikForm`, and `FabrikFormNotifier`

## 0.0.1

- `FabrikField<T>` with `value`, `error`, `isTouched`, `isDirty`, `visibleError`
- `FabrikForm<T>` with field management, validation, and `markAllTouched()`
- `FabrikFormNotifier<T>` for reactive usage
- `FabrikFormBuilder<T>` for clean widget-building
- Built-in validators:
  - `RequiredValidator`
  - `MinLengthValidator`
  - `MaxLengthValidator`
  - `EmailValidator`
  - `PasswordValidator`
