import 'package:freezed_annotation/freezed_annotation.dart';

part 'friend_response.freezed.dart';
part 'friend_response.g.dart';

@freezed
abstract class FriendResponse with _$FriendResponse {
  const factory FriendResponse({
    required String friendshipId,
    required String userId,
    required String username,
    required String status,
    String? direction,
    DateTime? createdAt,
  }) = _FriendResponse;

  factory FriendResponse.fromJson(Map<String, dynamic> json) => _$FriendResponseFromJson(json);
}
