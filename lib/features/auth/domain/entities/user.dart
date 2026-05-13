import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String username;
  final String email;
  final List<String> roles;
  final String token;

  const User({
    required this.id,
    required this.username,
    required this.email,
    required this.roles,
    required this.token,
  });

  @override
  List<Object?> get props => [id, username, email, roles, token];
}
