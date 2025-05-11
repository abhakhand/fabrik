import 'package:fabrik_result/fabrik_result.dart';

void main() {
  final result = fetchUserById("123");

  result.fold(
    (failure) => print("Error: ${failure.message}"),
    (user) => print("Welcome, ${user.name}!"),
  );

  final saveResult = saveUserData(user: User(name: "Ashu"));

  if (saveResult.isRight) {
    print("Data saved successfully ✅");
  }
}

/// User Entity
class User {
  const User({required this.name});

  final String name;
}

/// Simulated failure
class AppFailure {
  const AppFailure(this.message);

  final String message;
}

/// Simulated usecase returning Either
Either<AppFailure, User> fetchUserById(String id) {
  if (id == "123") {
    return right(User(name: "Ashu"));
  } else {
    return left(AppFailure("User not found"));
  }
}

/// Simulated usecase returning Either with Unit
Either<AppFailure, Unit> saveUserData({required User user}) {
  // pretend to save something
  return right(unit);
}
