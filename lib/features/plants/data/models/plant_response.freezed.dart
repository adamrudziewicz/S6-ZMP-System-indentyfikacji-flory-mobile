// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'plant_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlantResponse {

 String get id; String get herbariumId; String? get name; String? get detectedSpecies; String? get speciesId; String? get family; String? get genus; String? get commonNames; DateTime? get createdAt; DateTime? get updatedAt; List<PlantPhotoResponse> get photos;
/// Create a copy of PlantResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlantResponseCopyWith<PlantResponse> get copyWith => _$PlantResponseCopyWithImpl<PlantResponse>(this as PlantResponse, _$identity);

  /// Serializes this PlantResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlantResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.herbariumId, herbariumId) || other.herbariumId == herbariumId)&&(identical(other.name, name) || other.name == name)&&(identical(other.detectedSpecies, detectedSpecies) || other.detectedSpecies == detectedSpecies)&&(identical(other.speciesId, speciesId) || other.speciesId == speciesId)&&(identical(other.family, family) || other.family == family)&&(identical(other.genus, genus) || other.genus == genus)&&(identical(other.commonNames, commonNames) || other.commonNames == commonNames)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other.photos, photos));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,herbariumId,name,detectedSpecies,speciesId,family,genus,commonNames,createdAt,updatedAt,const DeepCollectionEquality().hash(photos));

@override
String toString() {
  return 'PlantResponse(id: $id, herbariumId: $herbariumId, name: $name, detectedSpecies: $detectedSpecies, speciesId: $speciesId, family: $family, genus: $genus, commonNames: $commonNames, createdAt: $createdAt, updatedAt: $updatedAt, photos: $photos)';
}


}

/// @nodoc
abstract mixin class $PlantResponseCopyWith<$Res>  {
  factory $PlantResponseCopyWith(PlantResponse value, $Res Function(PlantResponse) _then) = _$PlantResponseCopyWithImpl;
@useResult
$Res call({
 String id, String herbariumId, String? name, String? detectedSpecies, String? speciesId, String? family, String? genus, String? commonNames, DateTime? createdAt, DateTime? updatedAt, List<PlantPhotoResponse> photos
});




}
/// @nodoc
class _$PlantResponseCopyWithImpl<$Res>
    implements $PlantResponseCopyWith<$Res> {
  _$PlantResponseCopyWithImpl(this._self, this._then);

  final PlantResponse _self;
  final $Res Function(PlantResponse) _then;

/// Create a copy of PlantResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? herbariumId = null,Object? name = freezed,Object? detectedSpecies = freezed,Object? speciesId = freezed,Object? family = freezed,Object? genus = freezed,Object? commonNames = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? photos = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,herbariumId: null == herbariumId ? _self.herbariumId : herbariumId // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,detectedSpecies: freezed == detectedSpecies ? _self.detectedSpecies : detectedSpecies // ignore: cast_nullable_to_non_nullable
as String?,speciesId: freezed == speciesId ? _self.speciesId : speciesId // ignore: cast_nullable_to_non_nullable
as String?,family: freezed == family ? _self.family : family // ignore: cast_nullable_to_non_nullable
as String?,genus: freezed == genus ? _self.genus : genus // ignore: cast_nullable_to_non_nullable
as String?,commonNames: freezed == commonNames ? _self.commonNames : commonNames // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,photos: null == photos ? _self.photos : photos // ignore: cast_nullable_to_non_nullable
as List<PlantPhotoResponse>,
  ));
}

}


/// Adds pattern-matching-related methods to [PlantResponse].
extension PlantResponsePatterns on PlantResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlantResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlantResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlantResponse value)  $default,){
final _that = this;
switch (_that) {
case _PlantResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlantResponse value)?  $default,){
final _that = this;
switch (_that) {
case _PlantResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String herbariumId,  String? name,  String? detectedSpecies,  String? speciesId,  String? family,  String? genus,  String? commonNames,  DateTime? createdAt,  DateTime? updatedAt,  List<PlantPhotoResponse> photos)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlantResponse() when $default != null:
return $default(_that.id,_that.herbariumId,_that.name,_that.detectedSpecies,_that.speciesId,_that.family,_that.genus,_that.commonNames,_that.createdAt,_that.updatedAt,_that.photos);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String herbariumId,  String? name,  String? detectedSpecies,  String? speciesId,  String? family,  String? genus,  String? commonNames,  DateTime? createdAt,  DateTime? updatedAt,  List<PlantPhotoResponse> photos)  $default,) {final _that = this;
switch (_that) {
case _PlantResponse():
return $default(_that.id,_that.herbariumId,_that.name,_that.detectedSpecies,_that.speciesId,_that.family,_that.genus,_that.commonNames,_that.createdAt,_that.updatedAt,_that.photos);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String herbariumId,  String? name,  String? detectedSpecies,  String? speciesId,  String? family,  String? genus,  String? commonNames,  DateTime? createdAt,  DateTime? updatedAt,  List<PlantPhotoResponse> photos)?  $default,) {final _that = this;
switch (_that) {
case _PlantResponse() when $default != null:
return $default(_that.id,_that.herbariumId,_that.name,_that.detectedSpecies,_that.speciesId,_that.family,_that.genus,_that.commonNames,_that.createdAt,_that.updatedAt,_that.photos);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlantResponse implements PlantResponse {
  const _PlantResponse({required this.id, required this.herbariumId, this.name, this.detectedSpecies, this.speciesId, this.family, this.genus, this.commonNames, this.createdAt, this.updatedAt, final  List<PlantPhotoResponse> photos = const []}): _photos = photos;
  factory _PlantResponse.fromJson(Map<String, dynamic> json) => _$PlantResponseFromJson(json);

@override final  String id;
@override final  String herbariumId;
@override final  String? name;
@override final  String? detectedSpecies;
@override final  String? speciesId;
@override final  String? family;
@override final  String? genus;
@override final  String? commonNames;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;
 final  List<PlantPhotoResponse> _photos;
@override@JsonKey() List<PlantPhotoResponse> get photos {
  if (_photos is EqualUnmodifiableListView) return _photos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_photos);
}


/// Create a copy of PlantResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlantResponseCopyWith<_PlantResponse> get copyWith => __$PlantResponseCopyWithImpl<_PlantResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlantResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlantResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.herbariumId, herbariumId) || other.herbariumId == herbariumId)&&(identical(other.name, name) || other.name == name)&&(identical(other.detectedSpecies, detectedSpecies) || other.detectedSpecies == detectedSpecies)&&(identical(other.speciesId, speciesId) || other.speciesId == speciesId)&&(identical(other.family, family) || other.family == family)&&(identical(other.genus, genus) || other.genus == genus)&&(identical(other.commonNames, commonNames) || other.commonNames == commonNames)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other._photos, _photos));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,herbariumId,name,detectedSpecies,speciesId,family,genus,commonNames,createdAt,updatedAt,const DeepCollectionEquality().hash(_photos));

@override
String toString() {
  return 'PlantResponse(id: $id, herbariumId: $herbariumId, name: $name, detectedSpecies: $detectedSpecies, speciesId: $speciesId, family: $family, genus: $genus, commonNames: $commonNames, createdAt: $createdAt, updatedAt: $updatedAt, photos: $photos)';
}


}

/// @nodoc
abstract mixin class _$PlantResponseCopyWith<$Res> implements $PlantResponseCopyWith<$Res> {
  factory _$PlantResponseCopyWith(_PlantResponse value, $Res Function(_PlantResponse) _then) = __$PlantResponseCopyWithImpl;
@override @useResult
$Res call({
 String id, String herbariumId, String? name, String? detectedSpecies, String? speciesId, String? family, String? genus, String? commonNames, DateTime? createdAt, DateTime? updatedAt, List<PlantPhotoResponse> photos
});




}
/// @nodoc
class __$PlantResponseCopyWithImpl<$Res>
    implements _$PlantResponseCopyWith<$Res> {
  __$PlantResponseCopyWithImpl(this._self, this._then);

  final _PlantResponse _self;
  final $Res Function(_PlantResponse) _then;

/// Create a copy of PlantResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? herbariumId = null,Object? name = freezed,Object? detectedSpecies = freezed,Object? speciesId = freezed,Object? family = freezed,Object? genus = freezed,Object? commonNames = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? photos = null,}) {
  return _then(_PlantResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,herbariumId: null == herbariumId ? _self.herbariumId : herbariumId // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,detectedSpecies: freezed == detectedSpecies ? _self.detectedSpecies : detectedSpecies // ignore: cast_nullable_to_non_nullable
as String?,speciesId: freezed == speciesId ? _self.speciesId : speciesId // ignore: cast_nullable_to_non_nullable
as String?,family: freezed == family ? _self.family : family // ignore: cast_nullable_to_non_nullable
as String?,genus: freezed == genus ? _self.genus : genus // ignore: cast_nullable_to_non_nullable
as String?,commonNames: freezed == commonNames ? _self.commonNames : commonNames // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,photos: null == photos ? _self._photos : photos // ignore: cast_nullable_to_non_nullable
as List<PlantPhotoResponse>,
  ));
}


}

// dart format on
