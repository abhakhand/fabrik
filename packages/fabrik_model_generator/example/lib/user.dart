import 'package:fabrik_model/fabrik_model.dart';

part 'user.fmodel.dart';

@FabrikModel()
class User {
  const User({required this.email, required this.name, required this.age});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  @FabrikField(name: 'email_address')
  final String email;
  final String name;
  final int age;
}
