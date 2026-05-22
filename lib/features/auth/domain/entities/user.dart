class User {
  final String id;
  final String username;
  final String email;
  final bool verified;
  final bool active;
  final bool admin;
  
  User({
    required this.id,
    required this.username,
    required this.email,
    required this.verified,
    required this.active,
    required this.admin,
  });
}
