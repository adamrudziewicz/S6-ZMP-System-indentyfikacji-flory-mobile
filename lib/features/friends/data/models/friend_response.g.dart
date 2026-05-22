// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FriendResponse _$FriendResponseFromJson(Map<String, dynamic> json) =>
    _FriendResponse(
      friendshipId: json['friendshipId'] as String,
      userId: json['userId'] as String,
      username: json['username'] as String,
      status: json['status'] as String,
      direction: json['direction'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$FriendResponseToJson(_FriendResponse instance) =>
    <String, dynamic>{
      'friendshipId': instance.friendshipId,
      'userId': instance.userId,
      'username': instance.username,
      'status': instance.status,
      'direction': instance.direction,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
