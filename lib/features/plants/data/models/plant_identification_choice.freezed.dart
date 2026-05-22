// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'plant_identification_choice.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlantIdentificationChoice {

 bool get resolved; PlantResponse? get plant; String? get pendingPhotoId; String? get status; IdentificationInfo? get identification; List<PlantResponse> get recommendedPlants;
/// Create a copy of PlantIdentificationChoice
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlantIdentificationChoiceCopyWith<PlantIdentificationChoice> get copyWith => _$PlantIdentificationChoiceCopyWithImpl<PlantIdentificationChoice>(this as PlantIdentificationChoice, _$identity);

  /// Serializes this PlantIdentificationChoice to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlantIdentificationChoice&&(identical(other.resolved, resolved) || other.resolved == resolved)&&(identical(other.plant, plant) || other.plant == plant)&&(identical(other.pendingPhotoId, pendingPhotoId) || other.pendingPhotoId == pendingPhotoId)&&(identical(other.status, status) || other.status == status)&&(identical(other.identification, identification) || other.identification == identification)&&const DeepCollectionEquality().equals(other.recommendedPlants, recommendedPlants));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,resolved,plant,pendingPhotoId,status,identification,const DeepCollectionEquality().hash(recommendedPlants));

@override
String toString() {
  return 'PlantIdentificationChoice(resolved: $resolved, plant: $plant, pendingPhotoId: $pendingPhotoId, status: $status, identification: $identification, recommendedPlants: $recommendedPlants)';
}


}

/// @nodoc
abstract mixin class $PlantIdentificationChoiceCopyWith<$Res>  {
  factory $PlantIdentificationChoiceCopyWith(PlantIdentificationChoice value, $Res Function(PlantIdentificationChoice) _then) = _$PlantIdentificationChoiceCopyWithImpl;
@useResult
$Res call({
 bool resolved, PlantResponse? plant, String? pendingPhotoId, String? status, IdentificationInfo? identification, List<PlantResponse> recommendedPlants
});


$PlantResponseCopyWith<$Res>? get plant;$IdentificationInfoCopyWith<$Res>? get identification;

}
/// @nodoc
class _$PlantIdentificationChoiceCopyWithImpl<$Res>
    implements $PlantIdentificationChoiceCopyWith<$Res> {
  _$PlantIdentificationChoiceCopyWithImpl(this._self, this._then);

  final PlantIdentificationChoice _self;
  final $Res Function(PlantIdentificationChoice) _then;

/// Create a copy of PlantIdentificationChoice
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? resolved = null,Object? plant = freezed,Object? pendingPhotoId = freezed,Object? status = freezed,Object? identification = freezed,Object? recommendedPlants = null,}) {
  return _then(_self.copyWith(
resolved: null == resolved ? _self.resolved : resolved // ignore: cast_nullable_to_non_nullable
as bool,plant: freezed == plant ? _self.plant : plant // ignore: cast_nullable_to_non_nullable
as PlantResponse?,pendingPhotoId: freezed == pendingPhotoId ? _self.pendingPhotoId : pendingPhotoId // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,identification: freezed == identification ? _self.identification : identification // ignore: cast_nullable_to_non_nullable
as IdentificationInfo?,recommendedPlants: null == recommendedPlants ? _self.recommendedPlants : recommendedPlants // ignore: cast_nullable_to_non_nullable
as List<PlantResponse>,
  ));
}
/// Create a copy of PlantIdentificationChoice
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlantResponseCopyWith<$Res>? get plant {
    if (_self.plant == null) {
    return null;
  }

  return $PlantResponseCopyWith<$Res>(_self.plant!, (value) {
    return _then(_self.copyWith(plant: value));
  });
}/// Create a copy of PlantIdentificationChoice
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IdentificationInfoCopyWith<$Res>? get identification {
    if (_self.identification == null) {
    return null;
  }

  return $IdentificationInfoCopyWith<$Res>(_self.identification!, (value) {
    return _then(_self.copyWith(identification: value));
  });
}
}


/// Adds pattern-matching-related methods to [PlantIdentificationChoice].
extension PlantIdentificationChoicePatterns on PlantIdentificationChoice {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlantIdentificationChoice value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlantIdentificationChoice() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlantIdentificationChoice value)  $default,){
final _that = this;
switch (_that) {
case _PlantIdentificationChoice():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlantIdentificationChoice value)?  $default,){
final _that = this;
switch (_that) {
case _PlantIdentificationChoice() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool resolved,  PlantResponse? plant,  String? pendingPhotoId,  String? status,  IdentificationInfo? identification,  List<PlantResponse> recommendedPlants)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlantIdentificationChoice() when $default != null:
return $default(_that.resolved,_that.plant,_that.pendingPhotoId,_that.status,_that.identification,_that.recommendedPlants);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool resolved,  PlantResponse? plant,  String? pendingPhotoId,  String? status,  IdentificationInfo? identification,  List<PlantResponse> recommendedPlants)  $default,) {final _that = this;
switch (_that) {
case _PlantIdentificationChoice():
return $default(_that.resolved,_that.plant,_that.pendingPhotoId,_that.status,_that.identification,_that.recommendedPlants);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool resolved,  PlantResponse? plant,  String? pendingPhotoId,  String? status,  IdentificationInfo? identification,  List<PlantResponse> recommendedPlants)?  $default,) {final _that = this;
switch (_that) {
case _PlantIdentificationChoice() when $default != null:
return $default(_that.resolved,_that.plant,_that.pendingPhotoId,_that.status,_that.identification,_that.recommendedPlants);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlantIdentificationChoice implements PlantIdentificationChoice {
  const _PlantIdentificationChoice({required this.resolved, this.plant, this.pendingPhotoId, this.status, this.identification, final  List<PlantResponse> recommendedPlants = const []}): _recommendedPlants = recommendedPlants;
  factory _PlantIdentificationChoice.fromJson(Map<String, dynamic> json) => _$PlantIdentificationChoiceFromJson(json);

@override final  bool resolved;
@override final  PlantResponse? plant;
@override final  String? pendingPhotoId;
@override final  String? status;
@override final  IdentificationInfo? identification;
 final  List<PlantResponse> _recommendedPlants;
@override@JsonKey() List<PlantResponse> get recommendedPlants {
  if (_recommendedPlants is EqualUnmodifiableListView) return _recommendedPlants;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recommendedPlants);
}


/// Create a copy of PlantIdentificationChoice
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlantIdentificationChoiceCopyWith<_PlantIdentificationChoice> get copyWith => __$PlantIdentificationChoiceCopyWithImpl<_PlantIdentificationChoice>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlantIdentificationChoiceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlantIdentificationChoice&&(identical(other.resolved, resolved) || other.resolved == resolved)&&(identical(other.plant, plant) || other.plant == plant)&&(identical(other.pendingPhotoId, pendingPhotoId) || other.pendingPhotoId == pendingPhotoId)&&(identical(other.status, status) || other.status == status)&&(identical(other.identification, identification) || other.identification == identification)&&const DeepCollectionEquality().equals(other._recommendedPlants, _recommendedPlants));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,resolved,plant,pendingPhotoId,status,identification,const DeepCollectionEquality().hash(_recommendedPlants));

@override
String toString() {
  return 'PlantIdentificationChoice(resolved: $resolved, plant: $plant, pendingPhotoId: $pendingPhotoId, status: $status, identification: $identification, recommendedPlants: $recommendedPlants)';
}


}

/// @nodoc
abstract mixin class _$PlantIdentificationChoiceCopyWith<$Res> implements $PlantIdentificationChoiceCopyWith<$Res> {
  factory _$PlantIdentificationChoiceCopyWith(_PlantIdentificationChoice value, $Res Function(_PlantIdentificationChoice) _then) = __$PlantIdentificationChoiceCopyWithImpl;
@override @useResult
$Res call({
 bool resolved, PlantResponse? plant, String? pendingPhotoId, String? status, IdentificationInfo? identification, List<PlantResponse> recommendedPlants
});


@override $PlantResponseCopyWith<$Res>? get plant;@override $IdentificationInfoCopyWith<$Res>? get identification;

}
/// @nodoc
class __$PlantIdentificationChoiceCopyWithImpl<$Res>
    implements _$PlantIdentificationChoiceCopyWith<$Res> {
  __$PlantIdentificationChoiceCopyWithImpl(this._self, this._then);

  final _PlantIdentificationChoice _self;
  final $Res Function(_PlantIdentificationChoice) _then;

/// Create a copy of PlantIdentificationChoice
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? resolved = null,Object? plant = freezed,Object? pendingPhotoId = freezed,Object? status = freezed,Object? identification = freezed,Object? recommendedPlants = null,}) {
  return _then(_PlantIdentificationChoice(
resolved: null == resolved ? _self.resolved : resolved // ignore: cast_nullable_to_non_nullable
as bool,plant: freezed == plant ? _self.plant : plant // ignore: cast_nullable_to_non_nullable
as PlantResponse?,pendingPhotoId: freezed == pendingPhotoId ? _self.pendingPhotoId : pendingPhotoId // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,identification: freezed == identification ? _self.identification : identification // ignore: cast_nullable_to_non_nullable
as IdentificationInfo?,recommendedPlants: null == recommendedPlants ? _self._recommendedPlants : recommendedPlants // ignore: cast_nullable_to_non_nullable
as List<PlantResponse>,
  ));
}

/// Create a copy of PlantIdentificationChoice
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlantResponseCopyWith<$Res>? get plant {
    if (_self.plant == null) {
    return null;
  }

  return $PlantResponseCopyWith<$Res>(_self.plant!, (value) {
    return _then(_self.copyWith(plant: value));
  });
}/// Create a copy of PlantIdentificationChoice
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IdentificationInfoCopyWith<$Res>? get identification {
    if (_self.identification == null) {
    return null;
  }

  return $IdentificationInfoCopyWith<$Res>(_self.identification!, (value) {
    return _then(_self.copyWith(identification: value));
  });
}
}

// dart format on
