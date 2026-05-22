class Friend {
  final String friendshipId;
  final String userId;
  final String username;
  final String status; // PENDING or ACCEPTED
  final String? direction; // INCOMING or OUTGOING
  final DateTime? createdAt;

  Friend({
    required this.friendshipId,
    required this.userId,
    required this.username,
    required this.status,
    this.direction,
    this.createdAt,
  });
}
