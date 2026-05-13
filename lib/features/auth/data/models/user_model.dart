import 'package:customer_app/features/auth/domain/entities/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends User {
  const UserModel({
    required int id,
    required String username,
    required String email,
    required List<String> roles,
    required String token,
  }) : super(
          id: id,
          username: username,
          email: email,
          roles: roles,
          token: token,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
