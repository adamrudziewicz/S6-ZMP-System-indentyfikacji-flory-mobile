// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'friend_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FriendResponse {

 String get friendshipId; String get userId; String get username; String get status; String? get direction; DateTime? get createdAt;
/// Create a copy of FriendResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FriendResponseCopyWith<FriendResponse> get copyWith => _$FriendResponseCopyWithImpl<FriendResponse>(this as FriendResponse, _$identity);

  /// Serializes this FriendResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FriendResponse&&(identical(other.friendshipId, friendshipId) || other.friendshipId == friendshipId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.username, username) || other.username == username)&&(identical(other.status, status) || other.status == status)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,friendshipId,userId,username,status,direction,createdAt);

@override
String toString() {
  return 'FriendResponse(friendshipId: $friendshipId, userId: $userId, username: $username, status: $status, direction: $direction, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $FriendResponseCopyWith<$Res>  {
  factory $FriendResponseCopyWith(FriendResponse value, $Res Function(FriendResponse) _then) = _$FriendResponseCopyWithImpl;
@useResult
$Res call({
 String friendshipId, String userId, String username, String status, String? direction, DateTime? createdAt
});




}
/// @nodoc
class _$FriendResponseCopyWithImpl<$Res>
    implements $FriendResponseCopyWith<$Res> {
  _$FriendResponseCopyWithImpl(this._self, this._then);

  final FriendResponse _self;
  final $Res Function(FriendResponse) _then;

/// Create a copy of FriendResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? friendshipId = null,Object? userId = null,Object? username = null,Object? status = null,Object? direction = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
friendshipId: null == friendshipId ? _self.friendshipId : friendshipId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,direction: freezed == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [FriendResponse].
extension FriendResponsePatterns on FriendResponse {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FriendResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FriendResponse() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FriendResponse value)  $default,){
final _that = this;
switch (_that) {
case _FriendResponse():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FriendResponse value)?  $default,){
final _that = this;
switch (_that) {
case _FriendResponse() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String friendshipId,  String userId,  String username,  String status,  String? direction,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FriendResponse() when $default != null:
return $default(_that.friendshipId,_that.userId,_that.username,_that.status,_that.direction,_that.createdAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String friendshipId,  String userId,  String username,  String status,  String? direction,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _FriendResponse():
return $default(_that.friendshipId,_that.userId,_that.username,_that.status,_that.direction,_that.createdAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String friendshipId,  String userId,  String username,  String status,  String? direction,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _FriendResponse() when $default != null:
return $default(_that.friendshipId,_that.userId,_that.username,_that.status,_that.direction,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FriendResponse implements FriendResponse {
  const _FriendResponse({required this.friendshipId, required this.userId, required this.username, required this.status, this.direction, this.createdAt});
  factory _FriendResponse.fromJson(Map<String, dynamic> json) => _$FriendResponseFromJson(json);

@override final  String friendshipId;
@override final  String userId;
@override final  String username;
@override final  String status;
@override final  String? direction;
@override final  DateTime? createdAt;

/// Create a copy of FriendResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FriendResponseCopyWith<_FriendResponse> get copyWith => __$FriendResponseCopyWithImpl<_FriendResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FriendResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FriendResponse&&(identical(other.friendshipId, friendshipId) || other.friendshipId == friendshipId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.username, username) || other.username == username)&&(identical(other.status, status) || other.status == status)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,friendshipId,userId,username,status,direction,createdAt);

@override
String toString() {
  return 'FriendResponse(friendshipId: $friendshipId, userId: $userId, username: $username, status: $status, direction: $direction, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$FriendResponseCopyWith<$Res> implements $FriendResponseCopyWith<$Res> {
  factory _$FriendResponseCopyWith(_FriendResponse value, $Res Function(_FriendResponse) _then) = __$FriendResponseCopyWithImpl;
@override @useResult
$Res call({
 String friendshipId, String userId, String username, String status, String? direction, DateTime? createdAt
});




}
/// @nodoc
class __$FriendResponseCopyWithImpl<$Res>
    implements _$FriendResponseCopyWith<$Res> {
  __$FriendResponseCopyWithImpl(this._self, this._then);

  final _FriendResponse _self;
  final $Res Function(_FriendResponse) _then;

/// Create a copy of FriendResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? friendshipId = null,Object? userId = null,Object? username = null,Object? status = null,Object? direction = freezed,Object? createdAt = freezed,}) {
  return _then(_FriendResponse(
friendshipId: null == friendshipId ? _self.friendshipId : friendshipId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,direction: freezed == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
