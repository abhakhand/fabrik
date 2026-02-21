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
