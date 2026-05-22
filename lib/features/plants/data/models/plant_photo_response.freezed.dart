// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'plant_photo_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlantPhotoResponse {

 String get id; String get plantId; String get url; String? get description; double? get confidence; DateTime? get createdAt;
/// Create a copy of PlantPhotoResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlantPhotoResponseCopyWith<PlantPhotoResponse> get copyWith => _$PlantPhotoResponseCopyWithImpl<PlantPhotoResponse>(this as PlantPhotoResponse, _$identity);

  /// Serializes this PlantPhotoResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlantPhotoResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.plantId, plantId) || other.plantId == plantId)&&(identical(other.url, url) || other.url == url)&&(identical(other.description, description) || other.description == description)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,plantId,url,description,confidence,createdAt);

@override
String toString() {
  return 'PlantPhotoResponse(id: $id, plantId: $plantId, url: $url, description: $description, confidence: $confidence, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $PlantPhotoResponseCopyWith<$Res>  {
  factory $PlantPhotoResponseCopyWith(PlantPhotoResponse value, $Res Function(PlantPhotoResponse) _then) = _$PlantPhotoResponseCopyWithImpl;
@useResult
$Res call({
 String id, String plantId, String url, String? description, double? confidence, DateTime? createdAt
});




}
/// @nodoc
class _$PlantPhotoResponseCopyWithImpl<$Res>
    implements $PlantPhotoResponseCopyWith<$Res> {
  _$PlantPhotoResponseCopyWithImpl(this._self, this._then);

  final PlantPhotoResponse _self;
  final $Res Function(PlantPhotoResponse) _then;

/// Create a copy of PlantPhotoResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? plantId = null,Object? url = null,Object? description = freezed,Object? confidence = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,plantId: null == plantId ? _self.plantId : plantId // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,confidence: freezed == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [PlantPhotoResponse].
extension PlantPhotoResponsePatterns on PlantPhotoResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlantPhotoResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlantPhotoResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlantPhotoResponse value)  $default,){
final _that = this;
switch (_that) {
case _PlantPhotoResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlantPhotoResponse value)?  $default,){
final _that = this;
switch (_that) {
case _PlantPhotoResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String plantId,  String url,  String? description,  double? confidence,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlantPhotoResponse() when $default != null:
return $default(_that.id,_that.plantId,_that.url,_that.description,_that.confidence,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String plantId,  String url,  String? description,  double? confidence,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _PlantPhotoResponse():
return $default(_that.id,_that.plantId,_that.url,_that.description,_that.confidence,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String plantId,  String url,  String? description,  double? confidence,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _PlantPhotoResponse() when $default != null:
return $default(_that.id,_that.plantId,_that.url,_that.description,_that.confidence,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlantPhotoResponse implements PlantPhotoResponse {
  const _PlantPhotoResponse({required this.id, required this.plantId, required this.url, this.description, this.confidence, this.createdAt});
  factory _PlantPhotoResponse.fromJson(Map<String, dynamic> json) => _$PlantPhotoResponseFromJson(json);

@override final  String id;
@override final  String plantId;
@override final  String url;
@override final  String? description;
@override final  double? confidence;
@override final  DateTime? createdAt;

/// Create a copy of PlantPhotoResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlantPhotoResponseCopyWith<_PlantPhotoResponse> get copyWith => __$PlantPhotoResponseCopyWithImpl<_PlantPhotoResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlantPhotoResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlantPhotoResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.plantId, plantId) || other.plantId == plantId)&&(identical(other.url, url) || other.url == url)&&(identical(other.description, description) || other.description == description)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,plantId,url,description,confidence,createdAt);

@override
String toString() {
  return 'PlantPhotoResponse(id: $id, plantId: $plantId, url: $url, description: $description, confidence: $confidence, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$PlantPhotoResponseCopyWith<$Res> implements $PlantPhotoResponseCopyWith<$Res> {
  factory _$PlantPhotoResponseCopyWith(_PlantPhotoResponse value, $Res Function(_PlantPhotoResponse) _then) = __$PlantPhotoResponseCopyWithImpl;
@override @useResult
$Res call({
 String id, String plantId, String url, String? description, double? confidence, DateTime? createdAt
});




}
/// @nodoc
class __$PlantPhotoResponseCopyWithImpl<$Res>
    implements _$PlantPhotoResponseCopyWith<$Res> {
  __$PlantPhotoResponseCopyWithImpl(this._self, this._then);

  final _PlantPhotoResponse _self;
  final $Res Function(_PlantPhotoResponse) _then;

/// Create a copy of PlantPhotoResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? plantId = null,Object? url = null,Object? description = freezed,Object? confidence = freezed,Object? createdAt = freezed,}) {
  return _then(_PlantPhotoResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,plantId: null == plantId ? _self.plantId : plantId // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,confidence: freezed == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
