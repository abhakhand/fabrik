# fabrik_snackbar

A beautifully crafted, easy-to-use, and customizable Snackbar + Toast library for Flutter.  
It provides both **Snackbars** for rich feedback and **Toasts** for lightweight messages, all without boilerplate.

**Learn more at → [fabriktool.com](https://www.fabriktool.com)**

## Demo

Showcasing various snackbar types and toast positions

![Fabrik Snackbar Demo](https://github.com/abhakhand/fabrik/blob/main/packages/fabrik_snackbar/assets/demo.gif?raw=true)

## Features

- Modern, animated **Snackbars**
- Minimal, centered **Toasts**
- Custom icons, durations, and gradients
- Rich text support with styled content
- Prebuilt snackbar types: success, error, info, warning
- Positioning support: top / bottom / center
- Web and mobile compatibility
- No extensions or init code needed

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  fabrik_snackbar: ^0.1.0
```

## Usage

### Prebuilt Snackbar

```dart
FabrikSnackbar.success(
  context,
  title: 'Success!',
  message: 'You registered successfully.',
);
```

**Available types:**  
`FabrikSnackbar.success`  
`FabrikSnackbar.error`  
`FabrikSnackbar.info`  
`FabrikSnackbar.warning`

Customize if needed:

```dart
position: FabrikSnackbarPosition.top,
maxWidth: 480,
safeArea: false,
barrierBlur: 4.0,
```

### Rich Content Snackbar

Use `richTitle` and `richMessage` for styled text with multiple colors, fonts, and decorations:

```dart
FabrikSnackbar.success(
  context,
  richTitle: TextSpan(
    children: [
      TextSpan(
        text: 'Success ',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      TextSpan(
        text: '✓',
        style: TextStyle(
          color: Colors.green,
          fontSize: 18,
        ),
      ),
    ],
  ),
  richMessage: TextSpan(
    children: [
      TextSpan(
        text: 'Your account has been ',
        style: TextStyle(color: Colors.white70),
      ),
      TextSpan(
        text: 'successfully',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      TextSpan(
        text: ' created!',
        style: TextStyle(color: Colors.white70),
      ),
    ],
  ),
);
```

**Note:** Use either regular text (`title`, `message`) or rich text (`richTitle`, `richMessage`).

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

## Contributing

Want to contribute or report a bug?  
Open an issue or PR on our repository.

## Maintainers

- [Ashish Bhakhand](https://github.com/abhakhand)
