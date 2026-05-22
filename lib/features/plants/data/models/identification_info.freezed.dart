// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'identification_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$IdentificationInfo {

 String? get detectedSpecies; double? get confidence; String? get speciesId; String? get family; String? get genus; String? get commonNames;
/// Create a copy of IdentificationInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IdentificationInfoCopyWith<IdentificationInfo> get copyWith => _$IdentificationInfoCopyWithImpl<IdentificationInfo>(this as IdentificationInfo, _$identity);

  /// Serializes this IdentificationInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IdentificationInfo&&(identical(other.detectedSpecies, detectedSpecies) || other.detectedSpecies == detectedSpecies)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&(identical(other.speciesId, speciesId) || other.speciesId == speciesId)&&(identical(other.family, family) || other.family == family)&&(identical(other.genus, genus) || other.genus == genus)&&(identical(other.commonNames, commonNames) || other.commonNames == commonNames));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,detectedSpecies,confidence,speciesId,family,genus,commonNames);

@override
String toString() {
  return 'IdentificationInfo(detectedSpecies: $detectedSpecies, confidence: $confidence, speciesId: $speciesId, family: $family, genus: $genus, commonNames: $commonNames)';
}


}

/// @nodoc
abstract mixin class $IdentificationInfoCopyWith<$Res>  {
  factory $IdentificationInfoCopyWith(IdentificationInfo value, $Res Function(IdentificationInfo) _then) = _$IdentificationInfoCopyWithImpl;
@useResult
$Res call({
 String? detectedSpecies, double? confidence, String? speciesId, String? family, String? genus, String? commonNames
});




}
/// @nodoc
class _$IdentificationInfoCopyWithImpl<$Res>
    implements $IdentificationInfoCopyWith<$Res> {
  _$IdentificationInfoCopyWithImpl(this._self, this._then);

  final IdentificationInfo _self;
  final $Res Function(IdentificationInfo) _then;

/// Create a copy of IdentificationInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? detectedSpecies = freezed,Object? confidence = freezed,Object? speciesId = freezed,Object? family = freezed,Object? genus = freezed,Object? commonNames = freezed,}) {
  return _then(_self.copyWith(
detectedSpecies: freezed == detectedSpecies ? _self.detectedSpecies : detectedSpecies // ignore: cast_nullable_to_non_nullable
as String?,confidence: freezed == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double?,speciesId: freezed == speciesId ? _self.speciesId : speciesId // ignore: cast_nullable_to_non_nullable
as String?,family: freezed == family ? _self.family : family // ignore: cast_nullable_to_non_nullable
as String?,genus: freezed == genus ? _self.genus : genus // ignore: cast_nullable_to_non_nullable
as String?,commonNames: freezed == commonNames ? _self.commonNames : commonNames // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [IdentificationInfo].
extension IdentificationInfoPatterns on IdentificationInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IdentificationInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IdentificationInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IdentificationInfo value)  $default,){
final _that = this;
switch (_that) {
case _IdentificationInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IdentificationInfo value)?  $default,){
final _that = this;
switch (_that) {
case _IdentificationInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? detectedSpecies,  double? confidence,  String? speciesId,  String? family,  String? genus,  String? commonNames)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IdentificationInfo() when $default != null:
return $default(_that.detectedSpecies,_that.confidence,_that.speciesId,_that.family,_that.genus,_that.commonNames);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? detectedSpecies,  double? confidence,  String? speciesId,  String? family,  String? genus,  String? commonNames)  $default,) {final _that = this;
switch (_that) {
case _IdentificationInfo():
return $default(_that.detectedSpecies,_that.confidence,_that.speciesId,_that.family,_that.genus,_that.commonNames);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? detectedSpecies,  double? confidence,  String? speciesId,  String? family,  String? genus,  String? commonNames)?  $default,) {final _that = this;
switch (_that) {
case _IdentificationInfo() when $default != null:
return $default(_that.detectedSpecies,_that.confidence,_that.speciesId,_that.family,_that.genus,_that.commonNames);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IdentificationInfo implements IdentificationInfo {
  const _IdentificationInfo({this.detectedSpecies, this.confidence, this.speciesId, this.family, this.genus, this.commonNames});
  factory _IdentificationInfo.fromJson(Map<String, dynamic> json) => _$IdentificationInfoFromJson(json);

@override final  String? detectedSpecies;
@override final  double? confidence;
@override final  String? speciesId;
@override final  String? family;
@override final  String? genus;
@override final  String? commonNames;

/// Create a copy of IdentificationInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IdentificationInfoCopyWith<_IdentificationInfo> get copyWith => __$IdentificationInfoCopyWithImpl<_IdentificationInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IdentificationInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IdentificationInfo&&(identical(other.detectedSpecies, detectedSpecies) || other.detectedSpecies == detectedSpecies)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&(identical(other.speciesId, speciesId) || other.speciesId == speciesId)&&(identical(other.family, family) || other.family == family)&&(identical(other.genus, genus) || other.genus == genus)&&(identical(other.commonNames, commonNames) || other.commonNames == commonNames));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,detectedSpecies,confidence,speciesId,family,genus,commonNames);

@override
String toString() {
  return 'IdentificationInfo(detectedSpecies: $detectedSpecies, confidence: $confidence, speciesId: $speciesId, family: $family, genus: $genus, commonNames: $commonNames)';
}


}

/// @nodoc
abstract mixin class _$IdentificationInfoCopyWith<$Res> implements $IdentificationInfoCopyWith<$Res> {
  factory _$IdentificationInfoCopyWith(_IdentificationInfo value, $Res Function(_IdentificationInfo) _then) = __$IdentificationInfoCopyWithImpl;
@override @useResult
$Res call({
 String? detectedSpecies, double? confidence, String? speciesId, String? family, String? genus, String? commonNames
});




}
/// @nodoc
class __$IdentificationInfoCopyWithImpl<$Res>
    implements _$IdentificationInfoCopyWith<$Res> {
  __$IdentificationInfoCopyWithImpl(this._self, this._then);

  final _IdentificationInfo _self;
  final $Res Function(_IdentificationInfo) _then;

/// Create a copy of IdentificationInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? detectedSpecies = freezed,Object? confidence = freezed,Object? speciesId = freezed,Object? family = freezed,Object? genus = freezed,Object? commonNames = freezed,}) {
  return _then(_IdentificationInfo(
detectedSpecies: freezed == detectedSpecies ? _self.detectedSpecies : detectedSpecies // ignore: cast_nullable_to_non_nullable
as String?,confidence: freezed == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double?,speciesId: freezed == speciesId ? _self.speciesId : speciesId // ignore: cast_nullable_to_non_nullable
as String?,family: freezed == family ? _self.family : family // ignore: cast_nullable_to_non_nullable
as String?,genus: freezed == genus ? _self.genus : genus // ignore: cast_nullable_to_non_nullable
as String?,commonNames: freezed == commonNames ? _self.commonNames : commonNames // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
