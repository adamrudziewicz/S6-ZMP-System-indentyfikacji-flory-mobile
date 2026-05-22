import 'package:freezed_annotation/freezed_annotation.dart';

part 'friend_request_body.freezed.dart';
part 'friend_request_body.g.dart';

@freezed
abstract class FriendRequestBody with _$FriendRequestBody {
  const factory FriendRequestBody({
    required String username,
  }) = _FriendRequestBody;

  factory FriendRequestBody.fromJson(Map<String, dynamic> json) => _$FriendRequestBodyFromJson(json);
}
