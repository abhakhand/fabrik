# 🧱 fabrik_snackbar

A beautifully crafted, easy-to-use, and customizable Snackbar + Toast library for Flutter, built as part of the [Fabrik Toolkit](https://fabriktool.com).  
It provides both **Snackbars** for rich feedback and **Toasts** for lightweight messages — all without boilerplate.

---

## ✨ Features

- ✅ Modern, animated **Snackbars**
- ✅ Minimal, centered **Toasts**
- ✅ Custom icons, durations, and gradients
- ✅ Prebuilt snackbar types: success, error, info, warning
- ✅ Positioning support: top / bottom / center
- ✅ Web and mobile compatibility
- ✅ No extensions or init code needed

---

## 🚀 Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  fabrik_snackbar: ^0.1.0
```

---

## Example Usage

### Prebuilt Snackbar

```dart
FabrikSnackbar.success(
  context,
  title: 'Success!',
  message: 'You registered successfully.',
);
```

Other types:  
❌ `FabrikSnackbar.error`  
ℹ️ `FabrikSnackbar.info`  
⚠️ `FabrikSnackbar.warning`

Customize if needed:

```dart
position: FabrikSnackbarPosition.top,
maxWidth: 480,
safeArea: false,
barrierBlur: 4.0,
```

---

### Custom Snackbar

```dart
FabrikSnackbar.custom(
  context,
  config: FabrikSnackbarConfig(
    title: 'Custom Title',
    message: 'You can customize everything.',
    icon: Icon(Icons.star),
    backgroundColor: Colors.purple,
    borderRadius: BorderRadius.circular(16),
    duration: Duration(seconds: 4),
  ),
);
```

---

### Toast

```dart
FabrikToast.show(
  context,
  message: 'Copied to clipboard',
);
```

Customize toast appearance:

```dart
position: FabrikToastPosition.top,
backgroundColor: Colors.white,
textColor: Colors.black,
fontSize: 16,
```

---

## 🔗 Contributing

Want to contribute or report a bug?  
Open an issue or PR — we’d love your help 💙
