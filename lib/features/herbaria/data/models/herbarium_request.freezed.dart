// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'herbarium_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HerbariumRequest {

 String get name; String? get description;@JsonKey(name: 'public') bool get isPublic;
/// Create a copy of HerbariumRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HerbariumRequestCopyWith<HerbariumRequest> get copyWith => _$HerbariumRequestCopyWithImpl<HerbariumRequest>(this as HerbariumRequest, _$identity);

  /// Serializes this HerbariumRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HerbariumRequest&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.isPublic, isPublic) || other.isPublic == isPublic));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,description,isPublic);

@override
String toString() {
  return 'HerbariumRequest(name: $name, description: $description, isPublic: $isPublic)';
}


}

/// @nodoc
abstract mixin class $HerbariumRequestCopyWith<$Res>  {
  factory $HerbariumRequestCopyWith(HerbariumRequest value, $Res Function(HerbariumRequest) _then) = _$HerbariumRequestCopyWithImpl;
@useResult
$Res call({
 String name, String? description,@JsonKey(name: 'public') bool isPublic
});




}
/// @nodoc
class _$HerbariumRequestCopyWithImpl<$Res>
    implements $HerbariumRequestCopyWith<$Res> {
  _$HerbariumRequestCopyWithImpl(this._self, this._then);

  final HerbariumRequest _self;
  final $Res Function(HerbariumRequest) _then;

/// Create a copy of HerbariumRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? description = freezed,Object? isPublic = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,isPublic: null == isPublic ? _self.isPublic : isPublic // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [HerbariumRequest].
extension HerbariumRequestPatterns on HerbariumRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HerbariumRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HerbariumRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HerbariumRequest value)  $default,){
final _that = this;
switch (_that) {
case _HerbariumRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HerbariumRequest value)?  $default,){
final _that = this;
switch (_that) {
case _HerbariumRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String? description, @JsonKey(name: 'public')  bool isPublic)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HerbariumRequest() when $default != null:
return $default(_that.name,_that.description,_that.isPublic);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String? description, @JsonKey(name: 'public')  bool isPublic)  $default,) {final _that = this;
switch (_that) {
case _HerbariumRequest():
return $default(_that.name,_that.description,_that.isPublic);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String? description, @JsonKey(name: 'public')  bool isPublic)?  $default,) {final _that = this;
switch (_that) {
case _HerbariumRequest() when $default != null:
return $default(_that.name,_that.description,_that.isPublic);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HerbariumRequest implements HerbariumRequest {
  const _HerbariumRequest({required this.name, this.description, @JsonKey(name: 'public') this.isPublic = false});
  factory _HerbariumRequest.fromJson(Map<String, dynamic> json) => _$HerbariumRequestFromJson(json);

@override final  String name;
@override final  String? description;
@override@JsonKey(name: 'public') final  bool isPublic;

/// Create a copy of HerbariumRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HerbariumRequestCopyWith<_HerbariumRequest> get copyWith => __$HerbariumRequestCopyWithImpl<_HerbariumRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HerbariumRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HerbariumRequest&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.isPublic, isPublic) || other.isPublic == isPublic));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,description,isPublic);

@override
String toString() {
  return 'HerbariumRequest(name: $name, description: $description, isPublic: $isPublic)';
}


}

/// @nodoc
abstract mixin class _$HerbariumRequestCopyWith<$Res> implements $HerbariumRequestCopyWith<$Res> {
  factory _$HerbariumRequestCopyWith(_HerbariumRequest value, $Res Function(_HerbariumRequest) _then) = __$HerbariumRequestCopyWithImpl;
@override @useResult
$Res call({
 String name, String? description,@JsonKey(name: 'public') bool isPublic
});




}
/// @nodoc
class __$HerbariumRequestCopyWithImpl<$Res>
    implements _$HerbariumRequestCopyWith<$Res> {
  __$HerbariumRequestCopyWithImpl(this._self, this._then);

  final _HerbariumRequest _self;
  final $Res Function(_HerbariumRequest) _then;

/// Create a copy of HerbariumRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? description = freezed,Object? isPublic = null,}) {
  return _then(_HerbariumRequest(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,isPublic: null == isPublic ? _self.isPublic : isPublic // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
