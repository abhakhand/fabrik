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

class _$UserImpl extends User {
  _$UserImpl(
    this.email,
    this.name,
    this.age,
  );

  User copyWith({
    String? email,
    String? name,
    int? age,
  }) {
    return User(
      email: email ?? this.email,
      name: name ?? this.name,
      age: age ?? this.age,
    );
  }

  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.email == email &&
        other.name == name &&
        other.age == age &&
        true;
  }

  int hashCode() {
    return email.hashCode ^ name.hashCode ^ age.hashCode;
  }

  String toString() {
    return 'User(email: $email, name: $name, age: $age)';
  }
}
