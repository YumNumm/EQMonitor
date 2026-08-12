// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earthquake_hypocenter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EarthquakeHypocenter {

 String? get code; String? get name; Coordinate? get coordinates; EarthquakeMagnitude get magnitude; EarthquakeDepth get depth; String? get detailedCode; String? get detailedName;
/// Create a copy of EarthquakeHypocenter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeHypocenterCopyWith<EarthquakeHypocenter> get copyWith => _$EarthquakeHypocenterCopyWithImpl<EarthquakeHypocenter>(this as EarthquakeHypocenter, _$identity);

  /// Serializes this EarthquakeHypocenter to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeHypocenter&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.coordinates, coordinates) || other.coordinates == coordinates)&&(identical(other.magnitude, magnitude) || other.magnitude == magnitude)&&(identical(other.depth, depth) || other.depth == depth)&&(identical(other.detailedCode, detailedCode) || other.detailedCode == detailedCode)&&(identical(other.detailedName, detailedName) || other.detailedName == detailedName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,coordinates,magnitude,depth,detailedCode,detailedName);

@override
String toString() {
  return 'EarthquakeHypocenter(code: $code, name: $name, coordinates: $coordinates, magnitude: $magnitude, depth: $depth, detailedCode: $detailedCode, detailedName: $detailedName)';
}


}

/// @nodoc
abstract mixin class $EarthquakeHypocenterCopyWith<$Res>  {
  factory $EarthquakeHypocenterCopyWith(EarthquakeHypocenter value, $Res Function(EarthquakeHypocenter) _then) = _$EarthquakeHypocenterCopyWithImpl;
@useResult
$Res call({
 String? code, String? name, Coordinate? coordinates, EarthquakeMagnitude magnitude, EarthquakeDepth depth, String? detailedCode, String? detailedName
});


$CoordinateCopyWith<$Res>? get coordinates;$EarthquakeMagnitudeCopyWith<$Res> get magnitude;$EarthquakeDepthCopyWith<$Res> get depth;

}
/// @nodoc
class _$EarthquakeHypocenterCopyWithImpl<$Res>
    implements $EarthquakeHypocenterCopyWith<$Res> {
  _$EarthquakeHypocenterCopyWithImpl(this._self, this._then);

  final EarthquakeHypocenter _self;
  final $Res Function(EarthquakeHypocenter) _then;

/// Create a copy of EarthquakeHypocenter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = freezed,Object? name = freezed,Object? coordinates = freezed,Object? magnitude = null,Object? depth = null,Object? detailedCode = freezed,Object? detailedName = freezed,}) {
  return _then(EarthquakeHypocenter(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,coordinates: freezed == coordinates ? _self.coordinates : coordinates // ignore: cast_nullable_to_non_nullable
as Coordinate?,magnitude: null == magnitude ? _self.magnitude : magnitude // ignore: cast_nullable_to_non_nullable
as EarthquakeMagnitude,depth: null == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as EarthquakeDepth,detailedCode: freezed == detailedCode ? _self.detailedCode : detailedCode // ignore: cast_nullable_to_non_nullable
as String?,detailedName: freezed == detailedName ? _self.detailedName : detailedName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of EarthquakeHypocenter
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
}/// Create a copy of EarthquakeHypocenter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeMagnitudeCopyWith<$Res> get magnitude {
  
  return $EarthquakeMagnitudeCopyWith<$Res>(_self.magnitude, (value) {
    return _then(_self.copyWith(magnitude: value));
  });
}/// Create a copy of EarthquakeHypocenter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeDepthCopyWith<$Res> get depth {
  
  return $EarthquakeDepthCopyWith<$Res>(_self.depth, (value) {
    return _then(_self.copyWith(depth: value));
  });
}
}


/// Adds pattern-matching-related methods to [EarthquakeHypocenter].
extension EarthquakeHypocenterPatterns on EarthquakeHypocenter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarthquakeHypocenter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarthquakeHypocenter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarthquakeHypocenter value)  $default,){
final _that = this;
switch (_that) {
case _EarthquakeHypocenter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarthquakeHypocenter value)?  $default,){
final _that = this;
switch (_that) {
case _EarthquakeHypocenter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? code,  String? name,  Coordinate? coordinates,  EarthquakeMagnitude magnitude,  EarthquakeDepth depth,  String? detailedCode,  String? detailedName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakeHypocenter() when $default != null:
return $default(_that.code,_that.name,_that.coordinates,_that.magnitude,_that.depth,_that.detailedCode,_that.detailedName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? code,  String? name,  Coordinate? coordinates,  EarthquakeMagnitude magnitude,  EarthquakeDepth depth,  String? detailedCode,  String? detailedName)  $default,) {final _that = this;
switch (_that) {
case _EarthquakeHypocenter():
return $default(_that.code,_that.name,_that.coordinates,_that.magnitude,_that.depth,_that.detailedCode,_that.detailedName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? code,  String? name,  Coordinate? coordinates,  EarthquakeMagnitude magnitude,  EarthquakeDepth depth,  String? detailedCode,  String? detailedName)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakeHypocenter() when $default != null:
return $default(_that.code,_that.name,_that.coordinates,_that.magnitude,_that.depth,_that.detailedCode,_that.detailedName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EarthquakeHypocenter implements EarthquakeHypocenter {
  const _EarthquakeHypocenter({required this.code, required this.name, required this.coordinates, required this.magnitude, required this.depth, required this.detailedCode, required this.detailedName});
  factory _EarthquakeHypocenter.fromJson(Map<String, dynamic> json) => _$EarthquakeHypocenterFromJson(json);

@override final  String? code;
@override final  String? name;
@override final  Coordinate? coordinates;
@override final  EarthquakeMagnitude magnitude;
@override final  EarthquakeDepth depth;
@override final  String? detailedCode;
@override final  String? detailedName;

/// Create a copy of EarthquakeHypocenter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeHypocenterCopyWith<_EarthquakeHypocenter> get copyWith => __$EarthquakeHypocenterCopyWithImpl<_EarthquakeHypocenter>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakeHypocenterToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeHypocenter&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.coordinates, coordinates) || other.coordinates == coordinates)&&(identical(other.magnitude, magnitude) || other.magnitude == magnitude)&&(identical(other.depth, depth) || other.depth == depth)&&(identical(other.detailedCode, detailedCode) || other.detailedCode == detailedCode)&&(identical(other.detailedName, detailedName) || other.detailedName == detailedName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,coordinates,magnitude,depth,detailedCode,detailedName);

@override
String toString() {
  return 'EarthquakeHypocenter(code: $code, name: $name, coordinates: $coordinates, magnitude: $magnitude, depth: $depth, detailedCode: $detailedCode, detailedName: $detailedName)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeHypocenterCopyWith<$Res> implements $EarthquakeHypocenterCopyWith<$Res> {
  factory _$EarthquakeHypocenterCopyWith(_EarthquakeHypocenter value, $Res Function(_EarthquakeHypocenter) _then) = __$EarthquakeHypocenterCopyWithImpl;
@override @useResult
$Res call({
 String? code, String? name, Coordinate? coordinates, EarthquakeMagnitude magnitude, EarthquakeDepth depth, String? detailedCode, String? detailedName
});


@override $CoordinateCopyWith<$Res>? get coordinates;@override $EarthquakeMagnitudeCopyWith<$Res> get magnitude;@override $EarthquakeDepthCopyWith<$Res> get depth;

}
/// @nodoc
class __$EarthquakeHypocenterCopyWithImpl<$Res>
    implements _$EarthquakeHypocenterCopyWith<$Res> {
  __$EarthquakeHypocenterCopyWithImpl(this._self, this._then);

  final _EarthquakeHypocenter _self;
  final $Res Function(_EarthquakeHypocenter) _then;

/// Create a copy of EarthquakeHypocenter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = freezed,Object? name = freezed,Object? coordinates = freezed,Object? magnitude = null,Object? depth = null,Object? detailedCode = freezed,Object? detailedName = freezed,}) {
  return _then(_EarthquakeHypocenter(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,coordinates: freezed == coordinates ? _self.coordinates : coordinates // ignore: cast_nullable_to_non_nullable
as Coordinate?,magnitude: null == magnitude ? _self.magnitude : magnitude // ignore: cast_nullable_to_non_nullable
as EarthquakeMagnitude,depth: null == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as EarthquakeDepth,detailedCode: freezed == detailedCode ? _self.detailedCode : detailedCode // ignore: cast_nullable_to_non_nullable
as String?,detailedName: freezed == detailedName ? _self.detailedName : detailedName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of EarthquakeHypocenter
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
}/// Create a copy of EarthquakeHypocenter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeMagnitudeCopyWith<$Res> get magnitude {
  
  return $EarthquakeMagnitudeCopyWith<$Res>(_self.magnitude, (value) {
    return _then(_self.copyWith(magnitude: value));
  });
}/// Create a copy of EarthquakeHypocenter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeDepthCopyWith<$Res> get depth {
  
  return $EarthquakeDepthCopyWith<$Res>(_self.depth, (value) {
    return _then(_self.copyWith(depth: value));
  });
}
}

// dart format on
