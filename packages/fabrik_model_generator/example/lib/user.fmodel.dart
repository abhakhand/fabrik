// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// FabrikModelGenerator
// **************************************************************************

abstract class _$UserFromJson {
  static User fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email_address'] as String,
      name: json['name'] as String,
      age: json['age'] as int,
    );
  }
}

abstract class _$UserToJson {
  static Map<String, dynamic> toJson(User instance) {
    return {
      'email_address': instance.email,
      'name': instance.name,
      'age': instance.age,
    };
  }
}

abstract class _$UserCopyWith {
  User copyWith(
    User instance, {
    String email,
    String name,
    int age,
  }) {
    return User(
      email: email ?? instance.email,
      name: name ?? instance.name,
      age: age ?? instance.age,
    );
  }
}

abstract class _$UserEquality {
  bool operator ==(
    User a,
    User b,
  ) {
    if (identical(a, b)) return true;
    return a.email == b.email && a.name == b.name && a.age == b.age && true;
  }

  int hashCode(User instance) {
    return Object.hash(
      instance.email,
      instance.name,
      instance.age,
    );
  }
}
