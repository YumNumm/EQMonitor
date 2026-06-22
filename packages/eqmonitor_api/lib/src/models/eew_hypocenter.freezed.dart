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

/// コードは、気象庁防災情報XMLフォーマット コード表 地震火山関連コード表 による
 String get code; String get name;@JsonKey(includeIfNull: true) num? get magnitude;/// 震源の深さ `0`: `ごく浅い`, `700`: `700km以上`, `null`: `不明`
@JsonKey(includeIfNull: true) int? get depth;@JsonKey(includeIfNull: false) CodeName? get detailed;@JsonKey(includeIfNull: false) Coordinate? get coordinates;
/// Create a copy of EewHypocenter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EewHypocenterCopyWith<EewHypocenter> get copyWith => _$EewHypocenterCopyWithImpl<EewHypocenter>(this as EewHypocenter, _$identity);

  /// Serializes this EewHypocenter to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EewHypocenter&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.magnitude, magnitude) || other.magnitude == magnitude)&&(identical(other.depth, depth) || other.depth == depth)&&(identical(other.detailed, detailed) || other.detailed == detailed)&&(identical(other.coordinates, coordinates) || other.coordinates == coordinates));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,magnitude,depth,detailed,coordinates);

@override
String toString() {
  return 'EewHypocenter(code: $code, name: $name, magnitude: $magnitude, depth: $depth, detailed: $detailed, coordinates: $coordinates)';
}


}

/// @nodoc
abstract mixin class $EewHypocenterCopyWith<$Res>  {
  factory $EewHypocenterCopyWith(EewHypocenter value, $Res Function(EewHypocenter) _then) = _$EewHypocenterCopyWithImpl;
@useResult
$Res call({
 String code, String name,@JsonKey(includeIfNull: true) num? magnitude,@JsonKey(includeIfNull: true) int? depth,@JsonKey(includeIfNull: false) CodeName? detailed,@JsonKey(includeIfNull: false) Coordinate? coordinates
});


$CodeNameCopyWith<$Res>? get detailed;$CoordinateCopyWith<$Res>? get coordinates;

}
/// @nodoc
class _$EewHypocenterCopyWithImpl<$Res>
    implements $EewHypocenterCopyWith<$Res> {
  _$EewHypocenterCopyWithImpl(this._self, this._then);

  final EewHypocenter _self;
  final $Res Function(EewHypocenter) _then;

/// Create a copy of EewHypocenter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? magnitude = freezed,Object? depth = freezed,Object? detailed = freezed,Object? coordinates = freezed,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,magnitude: freezed == magnitude ? _self.magnitude : magnitude // ignore: cast_nullable_to_non_nullable
as num?,depth: freezed == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as int?,detailed: freezed == detailed ? _self.detailed : detailed // ignore: cast_nullable_to_non_nullable
as CodeName?,coordinates: freezed == coordinates ? _self.coordinates : coordinates // ignore: cast_nullable_to_non_nullable
as Coordinate?,
  ));
}
/// Create a copy of EewHypocenter
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
$CoordinateCopyWith<$Res>? get coordinates {
    if (_self.coordinates == null) {
    return null;
  }

  return $CoordinateCopyWith<$Res>(_self.coordinates!, (value) {
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String name, @JsonKey(includeIfNull: true)  num? magnitude, @JsonKey(includeIfNull: true)  int? depth, @JsonKey(includeIfNull: false)  CodeName? detailed, @JsonKey(includeIfNull: false)  Coordinate? coordinates)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EewHypocenter() when $default != null:
return $default(_that.code,_that.name,_that.magnitude,_that.depth,_that.detailed,_that.coordinates);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String name, @JsonKey(includeIfNull: true)  num? magnitude, @JsonKey(includeIfNull: true)  int? depth, @JsonKey(includeIfNull: false)  CodeName? detailed, @JsonKey(includeIfNull: false)  Coordinate? coordinates)  $default,) {final _that = this;
switch (_that) {
case _EewHypocenter():
return $default(_that.code,_that.name,_that.magnitude,_that.depth,_that.detailed,_that.coordinates);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String name, @JsonKey(includeIfNull: true)  num? magnitude, @JsonKey(includeIfNull: true)  int? depth, @JsonKey(includeIfNull: false)  CodeName? detailed, @JsonKey(includeIfNull: false)  Coordinate? coordinates)?  $default,) {final _that = this;
switch (_that) {
case _EewHypocenter() when $default != null:
return $default(_that.code,_that.name,_that.magnitude,_that.depth,_that.detailed,_that.coordinates);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EewHypocenter implements EewHypocenter {
  const _EewHypocenter({required this.code, required this.name, @JsonKey(includeIfNull: true) required this.magnitude, @JsonKey(includeIfNull: true) required this.depth, @JsonKey(includeIfNull: false) this.detailed, @JsonKey(includeIfNull: false) this.coordinates});
  factory _EewHypocenter.fromJson(Map<String, dynamic> json) => _$EewHypocenterFromJson(json);

/// コードは、気象庁防災情報XMLフォーマット コード表 地震火山関連コード表 による
@override final  String code;
@override final  String name;
@override@JsonKey(includeIfNull: true) final  num? magnitude;
/// 震源の深さ `0`: `ごく浅い`, `700`: `700km以上`, `null`: `不明`
@override@JsonKey(includeIfNull: true) final  int? depth;
@override@JsonKey(includeIfNull: false) final  CodeName? detailed;
@override@JsonKey(includeIfNull: false) final  Coordinate? coordinates;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EewHypocenter&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.magnitude, magnitude) || other.magnitude == magnitude)&&(identical(other.depth, depth) || other.depth == depth)&&(identical(other.detailed, detailed) || other.detailed == detailed)&&(identical(other.coordinates, coordinates) || other.coordinates == coordinates));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,magnitude,depth,detailed,coordinates);

@override
String toString() {
  return 'EewHypocenter(code: $code, name: $name, magnitude: $magnitude, depth: $depth, detailed: $detailed, coordinates: $coordinates)';
}


}

/// @nodoc
abstract mixin class _$EewHypocenterCopyWith<$Res> implements $EewHypocenterCopyWith<$Res> {
  factory _$EewHypocenterCopyWith(_EewHypocenter value, $Res Function(_EewHypocenter) _then) = __$EewHypocenterCopyWithImpl;
@override @useResult
$Res call({
 String code, String name,@JsonKey(includeIfNull: true) num? magnitude,@JsonKey(includeIfNull: true) int? depth,@JsonKey(includeIfNull: false) CodeName? detailed,@JsonKey(includeIfNull: false) Coordinate? coordinates
});


@override $CodeNameCopyWith<$Res>? get detailed;@override $CoordinateCopyWith<$Res>? get coordinates;

}
/// @nodoc
class __$EewHypocenterCopyWithImpl<$Res>
    implements _$EewHypocenterCopyWith<$Res> {
  __$EewHypocenterCopyWithImpl(this._self, this._then);

  final _EewHypocenter _self;
  final $Res Function(_EewHypocenter) _then;

/// Create a copy of EewHypocenter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? magnitude = freezed,Object? depth = freezed,Object? detailed = freezed,Object? coordinates = freezed,}) {
  return _then(_EewHypocenter(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,magnitude: freezed == magnitude ? _self.magnitude : magnitude // ignore: cast_nullable_to_non_nullable
as num?,depth: freezed == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as int?,detailed: freezed == detailed ? _self.detailed : detailed // ignore: cast_nullable_to_non_nullable
as CodeName?,coordinates: freezed == coordinates ? _self.coordinates : coordinates // ignore: cast_nullable_to_non_nullable
as Coordinate?,
  ));
}

/// Create a copy of EewHypocenter
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
$CoordinateCopyWith<$Res>? get coordinates {
    if (_self.coordinates == null) {
    return null;
  }

  return $CoordinateCopyWith<$Res>(_self.coordinates!, (value) {
    return _then(_self.copyWith(coordinates: value));
  });
}
}

// dart format on
