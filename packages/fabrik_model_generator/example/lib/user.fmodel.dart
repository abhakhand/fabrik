// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// FabrikModelGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    email: json['email_address'] as String? ?? '',
    name: json['name'] as String? ?? '',
    age: json['age'] as int? ?? 0,
  );
}

Map<String, dynamic> _$UserToJson(User instance) {
  return <String, dynamic>{
    'email_address': instance.email,
    'name': instance.name,
    'age': instance.age,
  };
}

class _$UserCopyWith {
  User copyWith(
    User instance, {
    String? email,
    String? name,
    int? age,
  }) {
    return User(
      email: email ?? instance.email,
      name: name ?? instance.name,
      age: age ?? instance.age,
    );
  }
}

class _$UserEquality {
  bool operator ==(
    Object a,
    Object b,
  ) {
    if (identical(a, b)) return true;
    if (a is! User || b is! User) return false;
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
