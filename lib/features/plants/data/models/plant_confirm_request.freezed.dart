// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'plant_confirm_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlantConfirmRequest {

 String get pendingPhotoId; String get decisionType; String? get existingPlantId;
/// Create a copy of PlantConfirmRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlantConfirmRequestCopyWith<PlantConfirmRequest> get copyWith => _$PlantConfirmRequestCopyWithImpl<PlantConfirmRequest>(this as PlantConfirmRequest, _$identity);

  /// Serializes this PlantConfirmRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlantConfirmRequest&&(identical(other.pendingPhotoId, pendingPhotoId) || other.pendingPhotoId == pendingPhotoId)&&(identical(other.decisionType, decisionType) || other.decisionType == decisionType)&&(identical(other.existingPlantId, existingPlantId) || other.existingPlantId == existingPlantId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pendingPhotoId,decisionType,existingPlantId);

@override
String toString() {
  return 'PlantConfirmRequest(pendingPhotoId: $pendingPhotoId, decisionType: $decisionType, existingPlantId: $existingPlantId)';
}


}

/// @nodoc
abstract mixin class $PlantConfirmRequestCopyWith<$Res>  {
  factory $PlantConfirmRequestCopyWith(PlantConfirmRequest value, $Res Function(PlantConfirmRequest) _then) = _$PlantConfirmRequestCopyWithImpl;
@useResult
$Res call({
 String pendingPhotoId, String decisionType, String? existingPlantId
});




}
/// @nodoc
class _$PlantConfirmRequestCopyWithImpl<$Res>
    implements $PlantConfirmRequestCopyWith<$Res> {
  _$PlantConfirmRequestCopyWithImpl(this._self, this._then);

  final PlantConfirmRequest _self;
  final $Res Function(PlantConfirmRequest) _then;

/// Create a copy of PlantConfirmRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pendingPhotoId = null,Object? decisionType = null,Object? existingPlantId = freezed,}) {
  return _then(_self.copyWith(
pendingPhotoId: null == pendingPhotoId ? _self.pendingPhotoId : pendingPhotoId // ignore: cast_nullable_to_non_nullable
as String,decisionType: null == decisionType ? _self.decisionType : decisionType // ignore: cast_nullable_to_non_nullable
as String,existingPlantId: freezed == existingPlantId ? _self.existingPlantId : existingPlantId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PlantConfirmRequest].
extension PlantConfirmRequestPatterns on PlantConfirmRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlantConfirmRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlantConfirmRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlantConfirmRequest value)  $default,){
final _that = this;
switch (_that) {
case _PlantConfirmRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlantConfirmRequest value)?  $default,){
final _that = this;
switch (_that) {
case _PlantConfirmRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String pendingPhotoId,  String decisionType,  String? existingPlantId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlantConfirmRequest() when $default != null:
return $default(_that.pendingPhotoId,_that.decisionType,_that.existingPlantId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String pendingPhotoId,  String decisionType,  String? existingPlantId)  $default,) {final _that = this;
switch (_that) {
case _PlantConfirmRequest():
return $default(_that.pendingPhotoId,_that.decisionType,_that.existingPlantId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String pendingPhotoId,  String decisionType,  String? existingPlantId)?  $default,) {final _that = this;
switch (_that) {
case _PlantConfirmRequest() when $default != null:
return $default(_that.pendingPhotoId,_that.decisionType,_that.existingPlantId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlantConfirmRequest implements PlantConfirmRequest {
  const _PlantConfirmRequest({required this.pendingPhotoId, required this.decisionType, this.existingPlantId});
  factory _PlantConfirmRequest.fromJson(Map<String, dynamic> json) => _$PlantConfirmRequestFromJson(json);

@override final  String pendingPhotoId;
@override final  String decisionType;
@override final  String? existingPlantId;

/// Create a copy of PlantConfirmRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlantConfirmRequestCopyWith<_PlantConfirmRequest> get copyWith => __$PlantConfirmRequestCopyWithImpl<_PlantConfirmRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlantConfirmRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlantConfirmRequest&&(identical(other.pendingPhotoId, pendingPhotoId) || other.pendingPhotoId == pendingPhotoId)&&(identical(other.decisionType, decisionType) || other.decisionType == decisionType)&&(identical(other.existingPlantId, existingPlantId) || other.existingPlantId == existingPlantId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pendingPhotoId,decisionType,existingPlantId);

@override
String toString() {
  return 'PlantConfirmRequest(pendingPhotoId: $pendingPhotoId, decisionType: $decisionType, existingPlantId: $existingPlantId)';
}


}

/// @nodoc
abstract mixin class _$PlantConfirmRequestCopyWith<$Res> implements $PlantConfirmRequestCopyWith<$Res> {
  factory _$PlantConfirmRequestCopyWith(_PlantConfirmRequest value, $Res Function(_PlantConfirmRequest) _then) = __$PlantConfirmRequestCopyWithImpl;
@override @useResult
$Res call({
 String pendingPhotoId, String decisionType, String? existingPlantId
});




}
/// @nodoc
class __$PlantConfirmRequestCopyWithImpl<$Res>
    implements _$PlantConfirmRequestCopyWith<$Res> {
  __$PlantConfirmRequestCopyWithImpl(this._self, this._then);

  final _PlantConfirmRequest _self;
  final $Res Function(_PlantConfirmRequest) _then;

/// Create a copy of PlantConfirmRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pendingPhotoId = null,Object? decisionType = null,Object? existingPlantId = freezed,}) {
  return _then(_PlantConfirmRequest(
pendingPhotoId: null == pendingPhotoId ? _self.pendingPhotoId : pendingPhotoId // ignore: cast_nullable_to_non_nullable
as String,decisionType: null == decisionType ? _self.decisionType : decisionType // ignore: cast_nullable_to_non_nullable
as String,existingPlantId: freezed == existingPlantId ? _self.existingPlantId : existingPlantId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
