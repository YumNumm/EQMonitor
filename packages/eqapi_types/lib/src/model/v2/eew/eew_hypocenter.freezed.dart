// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eew_hypocenter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EewHypocenter {

 CodeName get value; CodeName? get detailed; Coordinate get coordinates; double? get magnitude;/// 震源の深さ: 0 = ごく浅い, 700 = 700km以上, null = 不明
 int? get depth;
/// Create a copy of EewHypocenter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EewHypocenterCopyWith<EewHypocenter> get copyWith => _$EewHypocenterCopyWithImpl<EewHypocenter>(this as EewHypocenter, _$identity);

  /// Serializes this EewHypocenter to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EewHypocenter&&(identical(other.value, value) || other.value == value)&&(identical(other.detailed, detailed) || other.detailed == detailed)&&(identical(other.coordinates, coordinates) || other.coordinates == coordinates)&&(identical(other.magnitude, magnitude) || other.magnitude == magnitude)&&(identical(other.depth, depth) || other.depth == depth));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,detailed,coordinates,magnitude,depth);

@override
String toString() {
  return 'EewHypocenter(value: $value, detailed: $detailed, coordinates: $coordinates, magnitude: $magnitude, depth: $depth)';
}


}

/// @nodoc
abstract mixin class $EewHypocenterCopyWith<$Res>  {
  factory $EewHypocenterCopyWith(EewHypocenter value, $Res Function(EewHypocenter) _then) = _$EewHypocenterCopyWithImpl;
@useResult
$Res call({
 CodeName value, CodeName? detailed, Coordinate coordinates, double? magnitude, int? depth
});


$CodeNameCopyWith<$Res> get value;$CodeNameCopyWith<$Res>? get detailed;$CoordinateCopyWith<$Res> get coordinates;

}
/// @nodoc
class _$EewHypocenterCopyWithImpl<$Res>
    implements $EewHypocenterCopyWith<$Res> {
  _$EewHypocenterCopyWithImpl(this._self, this._then);

  final EewHypocenter _self;
  final $Res Function(EewHypocenter) _then;

/// Create a copy of EewHypocenter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = null,Object? detailed = freezed,Object? coordinates = null,Object? magnitude = freezed,Object? depth = freezed,}) {
  return _then(_self.copyWith(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as CodeName,detailed: freezed == detailed ? _self.detailed : detailed // ignore: cast_nullable_to_non_nullable
as CodeName?,coordinates: null == coordinates ? _self.coordinates : coordinates // ignore: cast_nullable_to_non_nullable
as Coordinate,magnitude: freezed == magnitude ? _self.magnitude : magnitude // ignore: cast_nullable_to_non_nullable
as double?,depth: freezed == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}
/// Create a copy of EewHypocenter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CodeNameCopyWith<$Res> get value {
  
  return $CodeNameCopyWith<$Res>(_self.value, (value) {
    return _then(_self.copyWith(value: value));
  });
}/// Create a copy of EewHypocenter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CodeNameCopyWith<$Res>? get detailed {
    if (_self.detailed == null) {
    return null;
  }

  return $CodeNameCopyWith<$Res>(_self.detailed!, (value) {
    return _then(_self.copyWith(detailed: value));
  });
}/// Create a copy of EewHypocenter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CoordinateCopyWith<$Res> get coordinates {
  
  return $CoordinateCopyWith<$Res>(_self.coordinates, (value) {
    return _then(_self.copyWith(coordinates: value));
  });
}
}


/// Adds pattern-matching-related methods to [EewHypocenter].
extension EewHypocenterPatterns on EewHypocenter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EewHypocenter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EewHypocenter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EewHypocenter value)  $default,){
final _that = this;
switch (_that) {
case _EewHypocenter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EewHypocenter value)?  $default,){
final _that = this;
switch (_that) {
case _EewHypocenter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CodeName value,  CodeName? detailed,  Coordinate coordinates,  double? magnitude,  int? depth)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EewHypocenter() when $default != null:
return $default(_that.value,_that.detailed,_that.coordinates,_that.magnitude,_that.depth);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CodeName value,  CodeName? detailed,  Coordinate coordinates,  double? magnitude,  int? depth)  $default,) {final _that = this;
switch (_that) {
case _EewHypocenter():
return $default(_that.value,_that.detailed,_that.coordinates,_that.magnitude,_that.depth);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CodeName value,  CodeName? detailed,  Coordinate coordinates,  double? magnitude,  int? depth)?  $default,) {final _that = this;
switch (_that) {
case _EewHypocenter() when $default != null:
return $default(_that.value,_that.detailed,_that.coordinates,_that.magnitude,_that.depth);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EewHypocenter implements EewHypocenter {
  const _EewHypocenter({required this.value, this.detailed, required this.coordinates, this.magnitude, this.depth});
  factory _EewHypocenter.fromJson(Map<String, dynamic> json) => _$EewHypocenterFromJson(json);

@override final  CodeName value;
@override final  CodeName? detailed;
@override final  Coordinate coordinates;
@override final  double? magnitude;
/// 震源の深さ: 0 = ごく浅い, 700 = 700km以上, null = 不明
@override final  int? depth;

/// Create a copy of EewHypocenter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EewHypocenterCopyWith<_EewHypocenter> get copyWith => __$EewHypocenterCopyWithImpl<_EewHypocenter>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EewHypocenterToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EewHypocenter&&(identical(other.value, value) || other.value == value)&&(identical(other.detailed, detailed) || other.detailed == detailed)&&(identical(other.coordinates, coordinates) || other.coordinates == coordinates)&&(identical(other.magnitude, magnitude) || other.magnitude == magnitude)&&(identical(other.depth, depth) || other.depth == depth));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,detailed,coordinates,magnitude,depth);

@override
String toString() {
  return 'EewHypocenter(value: $value, detailed: $detailed, coordinates: $coordinates, magnitude: $magnitude, depth: $depth)';
}


}

/// @nodoc
abstract mixin class _$EewHypocenterCopyWith<$Res> implements $EewHypocenterCopyWith<$Res> {
  factory _$EewHypocenterCopyWith(_EewHypocenter value, $Res Function(_EewHypocenter) _then) = __$EewHypocenterCopyWithImpl;
@override @useResult
$Res call({
 CodeName value, CodeName? detailed, Coordinate coordinates, double? magnitude, int? depth
});


@override $CodeNameCopyWith<$Res> get value;@override $CodeNameCopyWith<$Res>? get detailed;@override $CoordinateCopyWith<$Res> get coordinates;

}
/// @nodoc
class __$EewHypocenterCopyWithImpl<$Res>
    implements _$EewHypocenterCopyWith<$Res> {
  __$EewHypocenterCopyWithImpl(this._self, this._then);

  final _EewHypocenter _self;
  final $Res Function(_EewHypocenter) _then;

/// Create a copy of EewHypocenter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = null,Object? detailed = freezed,Object? coordinates = null,Object? magnitude = freezed,Object? depth = freezed,}) {
  return _then(_EewHypocenter(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as CodeName,detailed: freezed == detailed ? _self.detailed : detailed // ignore: cast_nullable_to_non_nullable
as CodeName?,coordinates: null == coordinates ? _self.coordinates : coordinates // ignore: cast_nullable_to_non_nullable
as Coordinate,magnitude: freezed == magnitude ? _self.magnitude : magnitude // ignore: cast_nullable_to_non_nullable
as double?,depth: freezed == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

/// Create a copy of EewHypocenter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CodeNameCopyWith<$Res> get value {
  
  return $CodeNameCopyWith<$Res>(_self.value, (value) {
    return _then(_self.copyWith(value: value));
  });
}/// Create a copy of EewHypocenter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CodeNameCopyWith<$Res>? get detailed {
    if (_self.detailed == null) {
    return null;
  }

  return $CodeNameCopyWith<$Res>(_self.detailed!, (value) {
    return _then(_self.copyWith(detailed: value));
  });
}/// Create a copy of EewHypocenter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CoordinateCopyWith<$Res> get coordinates {
  
  return $CoordinateCopyWith<$Res>(_self.coordinates, (value) {
    return _then(_self.copyWith(coordinates: value));
  });
}
}

// dart format on
