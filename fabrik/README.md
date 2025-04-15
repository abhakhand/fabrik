# 🧱 Fabrik CLI

A powerful CLI tool to generate **scalable**, **testable**, and **clean Flutter feature scaffolding** using **DDD layered architecture**.

Built with developer experience in mind — **generate complete feature folders in seconds**.

---

## ✨ Features

- ✅ Clean architecture structure (Model → Entity → DataSource → Repository → UseCase → BLoC)
- ✅ Barrel files auto-generated
- ✅ Supports `--output-dir` or `-o` to customize output
- 🛠️ Optional flags like `--with-bloc`, `--minimal` coming soon

---

## 🚀 Installation

```bash
dart pub global activate fabrik
```

### ⚙️ Set Up PATH (if needed)

After activating the CLI, make sure Dart’s global bin directory is in your system PATH.

#### macOS/Linux

```bash
# Add this to your shell config file (~/.zshrc, ~/.bashrc, etc.)
export PATH="$PATH":"$HOME/.pub-cache/bin"
```

#### Windows

Locale the dart global bin path and add it to system PATH

```bash
C:\Users\<YourUsername>\AppData\Local\Pub\Cache\bin
```

---

## 🧰 Usage

### Generate a feature

```bash
fabrik generate feature auth
```

This will create:

```bash
./auth/
  |- models/
  |- entities/
  |- usecases/
  |- blocs/
  |- repository.dart
  |- data_source.dart
  |- auth.dart (barrel)
```

### Generate into a specific folder

```bash
fabrik generate feature auth -o app_auth
```

➡️ Outputs to `./app_auth/`

---

## 📦 Output Example

Inside your feature folder:

```dart
lib/features/auth/
  |- models/
     |- user_model.dart
     |- models.dart
  |- entities/
     |- user.dart
     |- entities.dart
  |- usecases/
     |- login_usecase.dart
     |- usecases.dart
  |- blocs/
     |- auth_bloc.dart
     |- auth_event.dart
     |- auth_state.dart
  |- repository.dart
  |- data_source.dart
  |- auth.dart
```

All classes are stubbed with clean and minimal code — ready to be implemented.

---

## 📚 Recommended Utility Packages

Fabrik scaffolds rely on some essential packages for clean architecture, error handling, and code generation.

To get started, add the following to your `pubspec.yaml`:

```yaml
dependencies:
  # Core utility package containing Failure & Status classes
  flutter_core:
    git:
      url: https://github.com/abhakhand/flutter_core.git
      ref: main

  # Functional programming support (Either, Option, etc.)
  dartz:

  # State management with BLoC
  bloc:
  flutter_bloc:
  equatable:

  # Code generation support
  json_annotation:
  freezed_annotation:

  # Dependency injection
  get_it: ^7.6.4
  injectable: ^2.3.2

dev_dependencies:
  build_runner:
  freezed:
  injectable_generator:
  json_serializable:
  very_good_analysis:
```

### ⚙️ Don’t forget to run

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

---

## 🔗 Related

- [mason](https://pub.dev/packages/mason) — powering this scaffolding magic.
- [flutter_core](https://pub.dev/packages/flutter_core) — recommended base package for `Failure`, `Status`, and architecture utilities.

---

## 📣 Coming Soon

- [ ] `--minimal` flag for model-only scaffolds
- [ ] `fabrik init` to generate ApiClient, Config, and other architecture utils
- [ ] VSCode Extension for Fabrik
- [ ] Web UI at [fabriktool.com](https://fabriktool.com)

---

## Maintainers

- [Ashish Bhakhand](https://github.com/abhakhand)

Inspired by real-world Flutter app architecture challenges.
Open source. Open to contributions. Built for the Flutter community.
