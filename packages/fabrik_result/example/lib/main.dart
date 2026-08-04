// ignore_for_file: avoid_print
//
// This example is plain Dart with no Flutter dependency, so debugPrint is
// unavailable; print is the right call here.

import 'package:fabrik_result/fabrik_result.dart';

void main() {
  // Example 1: Fetching a user (Either<Failure, User>)
  final result = fetchUserById('123');

  // Exhaustive handling using fold
  result.fold(
    (failure) => print('Error: ${failure.message}'),
    (user) => print('Welcome, ${user.name}!'),
  );

  // One-sided handling when only success matters
  result.onRight((user) {
    print('User loaded: ${user.name}');
  });

  // Safe extraction when control flow is simple
  final user = result.rightOrNull;
  if (user == null) {
    print('No user available');
    return;
  }

  // Example 2: Saving data (Either<Failure, Unit>)
  final saveResult = saveUserData(user: user);

  saveResult.fold(
    (failure) => print('Failed to save: ${failure.message}'),
    (_) => print('Data saved successfully'),
  );
}

class User {
  const User({required this.name});

  final String name;
}

class AppFailure {
  const AppFailure(this.message);

  final String message;
}

Either<AppFailure, User> fetchUserById(String id) {
  if (id == '123') {
    return right(User(name: 'Ashu'));
  }

  return left(AppFailure('User not found'));
}

Either<AppFailure, Unit> saveUserData({required User user}) {
  // Pretend to persist data
  return right(unit);
}
