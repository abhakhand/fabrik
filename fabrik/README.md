# 🧱 Fabrik CLI

A powerful CLI tool to generate **scalable**, **testable**, and **clean Flutter feature scaffolding** using **DDD layered architecture**.

Built with developer experience in mind — **generate complete feature folders in seconds**.

---

## ✨ Features

- ✅ Clean architecture structure (Model → Entity → DataSource → Repository → UseCase → BLoC)
- ✅ Barrel files auto-generated
- ✅ Supports `--output-dir` or `-o` to customize output
- ✅ Works great with `flutter_core` (optional)
- 🛠️ Optional flags like `--with-bloc`, `--minimal` coming soon

---

## 🚀 Installation

```bash
dart pub global activate fabrik
```

Make sure your Dart global bin is in PATH:

```bash
# Add this to your shell config (~/.zshrc or ~/.bashrc)
export PATH="$PATH":"$HOME/.pub-cache/bin"
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

## ❤️ Credits

Crafted by [Ashish Bhakhand](https://github.com/abhakhand), inspired by real-world Flutter app architecture challenges.

Open source. Open to contributions. Built for the Flutter community.

---

## 📄 License

[MIT](../LICENSE)
