// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'herbarium_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HerbariumResponse {

 String get id; String get userId; String get name; String? get description; DateTime? get createdAt; DateTime? get updatedAt; int get plantCount;@JsonKey(name: 'public') bool get isPublic;
/// Create a copy of HerbariumResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HerbariumResponseCopyWith<HerbariumResponse> get copyWith => _$HerbariumResponseCopyWithImpl<HerbariumResponse>(this as HerbariumResponse, _$identity);

  /// Serializes this HerbariumResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HerbariumResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.plantCount, plantCount) || other.plantCount == plantCount)&&(identical(other.isPublic, isPublic) || other.isPublic == isPublic));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,name,description,createdAt,updatedAt,plantCount,isPublic);

@override
String toString() {
  return 'HerbariumResponse(id: $id, userId: $userId, name: $name, description: $description, createdAt: $createdAt, updatedAt: $updatedAt, plantCount: $plantCount, isPublic: $isPublic)';
}


}

/// @nodoc
abstract mixin class $HerbariumResponseCopyWith<$Res>  {
  factory $HerbariumResponseCopyWith(HerbariumResponse value, $Res Function(HerbariumResponse) _then) = _$HerbariumResponseCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String name, String? description, DateTime? createdAt, DateTime? updatedAt, int plantCount,@JsonKey(name: 'public') bool isPublic
});




}
/// @nodoc
class _$HerbariumResponseCopyWithImpl<$Res>
    implements $HerbariumResponseCopyWith<$Res> {
  _$HerbariumResponseCopyWithImpl(this._self, this._then);

  final HerbariumResponse _self;
  final $Res Function(HerbariumResponse) _then;

/// Create a copy of HerbariumResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? name = null,Object? description = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? plantCount = null,Object? isPublic = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,plantCount: null == plantCount ? _self.plantCount : plantCount // ignore: cast_nullable_to_non_nullable
as int,isPublic: null == isPublic ? _self.isPublic : isPublic // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [HerbariumResponse].
extension HerbariumResponsePatterns on HerbariumResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HerbariumResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HerbariumResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HerbariumResponse value)  $default,){
final _that = this;
switch (_that) {
case _HerbariumResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HerbariumResponse value)?  $default,){
final _that = this;
switch (_that) {
case _HerbariumResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String name,  String? description,  DateTime? createdAt,  DateTime? updatedAt,  int plantCount, @JsonKey(name: 'public')  bool isPublic)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HerbariumResponse() when $default != null:
return $default(_that.id,_that.userId,_that.name,_that.description,_that.createdAt,_that.updatedAt,_that.plantCount,_that.isPublic);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String name,  String? description,  DateTime? createdAt,  DateTime? updatedAt,  int plantCount, @JsonKey(name: 'public')  bool isPublic)  $default,) {final _that = this;
switch (_that) {
case _HerbariumResponse():
return $default(_that.id,_that.userId,_that.name,_that.description,_that.createdAt,_that.updatedAt,_that.plantCount,_that.isPublic);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String name,  String? description,  DateTime? createdAt,  DateTime? updatedAt,  int plantCount, @JsonKey(name: 'public')  bool isPublic)?  $default,) {final _that = this;
switch (_that) {
case _HerbariumResponse() when $default != null:
return $default(_that.id,_that.userId,_that.name,_that.description,_that.createdAt,_that.updatedAt,_that.plantCount,_that.isPublic);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HerbariumResponse implements HerbariumResponse {
  const _HerbariumResponse({required this.id, required this.userId, required this.name, this.description, this.createdAt, this.updatedAt, this.plantCount = 0, @JsonKey(name: 'public') this.isPublic = false});
  factory _HerbariumResponse.fromJson(Map<String, dynamic> json) => _$HerbariumResponseFromJson(json);

@override final  String id;
@override final  String userId;
@override final  String name;
@override final  String? description;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;
@override@JsonKey() final  int plantCount;
@override@JsonKey(name: 'public') final  bool isPublic;

/// Create a copy of HerbariumResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HerbariumResponseCopyWith<_HerbariumResponse> get copyWith => __$HerbariumResponseCopyWithImpl<_HerbariumResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HerbariumResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HerbariumResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.plantCount, plantCount) || other.plantCount == plantCount)&&(identical(other.isPublic, isPublic) || other.isPublic == isPublic));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,name,description,createdAt,updatedAt,plantCount,isPublic);

@override
String toString() {
  return 'HerbariumResponse(id: $id, userId: $userId, name: $name, description: $description, createdAt: $createdAt, updatedAt: $updatedAt, plantCount: $plantCount, isPublic: $isPublic)';
}


}

/// @nodoc
abstract mixin class _$HerbariumResponseCopyWith<$Res> implements $HerbariumResponseCopyWith<$Res> {
  factory _$HerbariumResponseCopyWith(_HerbariumResponse value, $Res Function(_HerbariumResponse) _then) = __$HerbariumResponseCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String name, String? description, DateTime? createdAt, DateTime? updatedAt, int plantCount,@JsonKey(name: 'public') bool isPublic
});




}
/// @nodoc
class __$HerbariumResponseCopyWithImpl<$Res>
    implements _$HerbariumResponseCopyWith<$Res> {
  __$HerbariumResponseCopyWithImpl(this._self, this._then);

  final _HerbariumResponse _self;
  final $Res Function(_HerbariumResponse) _then;

/// Create a copy of HerbariumResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? name = null,Object? description = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? plantCount = null,Object? isPublic = null,}) {
  return _then(_HerbariumResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,plantCount: null == plantCount ? _self.plantCount : plantCount // ignore: cast_nullable_to_non_nullable
as int,isPublic: null == isPublic ? _self.isPublic : isPublic // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
