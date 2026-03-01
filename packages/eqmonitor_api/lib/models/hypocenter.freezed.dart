// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hypocenter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Hypocenter {

 CodeName get value; Coordinate get coordinates; Magnitude get magnitude; Depth get depth;@JsonKey(includeIfNull: false) CodeName? get detailed;
/// Create a copy of Hypocenter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HypocenterCopyWith<Hypocenter> get copyWith => _$HypocenterCopyWithImpl<Hypocenter>(this as Hypocenter, _$identity);

  /// Serializes this Hypocenter to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Hypocenter&&(identical(other.value, value) || other.value == value)&&(identical(other.coordinates, coordinates) || other.coordinates == coordinates)&&(identical(other.magnitude, magnitude) || other.magnitude == magnitude)&&(identical(other.depth, depth) || other.depth == depth)&&(identical(other.detailed, detailed) || other.detailed == detailed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,coordinates,magnitude,depth,detailed);

@override
String toString() {
  return 'Hypocenter(value: $value, coordinates: $coordinates, magnitude: $magnitude, depth: $depth, detailed: $detailed)';
}


}

/// @nodoc
abstract mixin class $HypocenterCopyWith<$Res>  {
  factory $HypocenterCopyWith(Hypocenter value, $Res Function(Hypocenter) _then) = _$HypocenterCopyWithImpl;
@useResult
$Res call({
 CodeName value, Coordinate coordinates, Magnitude magnitude, Depth depth,@JsonKey(includeIfNull: false) CodeName? detailed
});


$CodeNameCopyWith<$Res> get value;$CoordinateCopyWith<$Res> get coordinates;$MagnitudeCopyWith<$Res> get magnitude;$DepthCopyWith<$Res> get depth;$CodeNameCopyWith<$Res>? get detailed;

}
/// @nodoc
class _$HypocenterCopyWithImpl<$Res>
    implements $HypocenterCopyWith<$Res> {
  _$HypocenterCopyWithImpl(this._self, this._then);

  final Hypocenter _self;
  final $Res Function(Hypocenter) _then;

/// Create a copy of Hypocenter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = null,Object? coordinates = null,Object? magnitude = null,Object? depth = null,Object? detailed = freezed,}) {
  return _then(_self.copyWith(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as CodeName,coordinates: null == coordinates ? _self.coordinates : coordinates // ignore: cast_nullable_to_non_nullable
as Coordinate,magnitude: null == magnitude ? _self.magnitude : magnitude // ignore: cast_nullable_to_non_nullable
as Magnitude,depth: null == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as Depth,detailed: freezed == detailed ? _self.detailed : detailed // ignore: cast_nullable_to_non_nullable
as CodeName?,
  ));
}
/// Create a copy of Hypocenter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CodeNameCopyWith<$Res> get value {
  
  return $CodeNameCopyWith<$Res>(_self.value, (value) {
    return _then(_self.copyWith(value: value));
  });
}/// Create a copy of Hypocenter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CoordinateCopyWith<$Res> get coordinates {
  
  return $CoordinateCopyWith<$Res>(_self.coordinates, (value) {
    return _then(_self.copyWith(coordinates: value));
  });
}/// Create a copy of Hypocenter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MagnitudeCopyWith<$Res> get magnitude {
  
  return $MagnitudeCopyWith<$Res>(_self.magnitude, (value) {
    return _then(_self.copyWith(magnitude: value));
  });
}/// Create a copy of Hypocenter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DepthCopyWith<$Res> get depth {
  
  return $DepthCopyWith<$Res>(_self.depth, (value) {
    return _then(_self.copyWith(depth: value));
  });
}/// Create a copy of Hypocenter
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
}
}


/// Adds pattern-matching-related methods to [Hypocenter].
extension HypocenterPatterns on Hypocenter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Hypocenter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Hypocenter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Hypocenter value)  $default,){
final _that = this;
switch (_that) {
case _Hypocenter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Hypocenter value)?  $default,){
final _that = this;
switch (_that) {
case _Hypocenter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CodeName value,  Coordinate coordinates,  Magnitude magnitude,  Depth depth, @JsonKey(includeIfNull: false)  CodeName? detailed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Hypocenter() when $default != null:
return $default(_that.value,_that.coordinates,_that.magnitude,_that.depth,_that.detailed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CodeName value,  Coordinate coordinates,  Magnitude magnitude,  Depth depth, @JsonKey(includeIfNull: false)  CodeName? detailed)  $default,) {final _that = this;
switch (_that) {
case _Hypocenter():
return $default(_that.value,_that.coordinates,_that.magnitude,_that.depth,_that.detailed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CodeName value,  Coordinate coordinates,  Magnitude magnitude,  Depth depth, @JsonKey(includeIfNull: false)  CodeName? detailed)?  $default,) {final _that = this;
switch (_that) {
case _Hypocenter() when $default != null:
return $default(_that.value,_that.coordinates,_that.magnitude,_that.depth,_that.detailed);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Hypocenter implements Hypocenter {
  const _Hypocenter({required this.value, required this.coordinates, required this.magnitude, required this.depth, @JsonKey(includeIfNull: false) this.detailed});
  factory _Hypocenter.fromJson(Map<String, dynamic> json) => _$HypocenterFromJson(json);

@override final  CodeName value;
@override final  Coordinate coordinates;
@override final  Magnitude magnitude;
@override final  Depth depth;
@override@JsonKey(includeIfNull: false) final  CodeName? detailed;

/// Create a copy of Hypocenter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HypocenterCopyWith<_Hypocenter> get copyWith => __$HypocenterCopyWithImpl<_Hypocenter>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HypocenterToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Hypocenter&&(identical(other.value, value) || other.value == value)&&(identical(other.coordinates, coordinates) || other.coordinates == coordinates)&&(identical(other.magnitude, magnitude) || other.magnitude == magnitude)&&(identical(other.depth, depth) || other.depth == depth)&&(identical(other.detailed, detailed) || other.detailed == detailed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,coordinates,magnitude,depth,detailed);

@override
String toString() {
  return 'Hypocenter(value: $value, coordinates: $coordinates, magnitude: $magnitude, depth: $depth, detailed: $detailed)';
}


}

/// @nodoc
abstract mixin class _$HypocenterCopyWith<$Res> implements $HypocenterCopyWith<$Res> {
  factory _$HypocenterCopyWith(_Hypocenter value, $Res Function(_Hypocenter) _then) = __$HypocenterCopyWithImpl;
@override @useResult
$Res call({
 CodeName value, Coordinate coordinates, Magnitude magnitude, Depth depth,@JsonKey(includeIfNull: false) CodeName? detailed
});


@override $CodeNameCopyWith<$Res> get value;@override $CoordinateCopyWith<$Res> get coordinates;@override $MagnitudeCopyWith<$Res> get magnitude;@override $DepthCopyWith<$Res> get depth;@override $CodeNameCopyWith<$Res>? get detailed;

}
/// @nodoc
class __$HypocenterCopyWithImpl<$Res>
    implements _$HypocenterCopyWith<$Res> {
  __$HypocenterCopyWithImpl(this._self, this._then);

  final _Hypocenter _self;
  final $Res Function(_Hypocenter) _then;

/// Create a copy of Hypocenter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = null,Object? coordinates = null,Object? magnitude = null,Object? depth = null,Object? detailed = freezed,}) {
  return _then(_Hypocenter(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as CodeName,coordinates: null == coordinates ? _self.coordinates : coordinates // ignore: cast_nullable_to_non_nullable
as Coordinate,magnitude: null == magnitude ? _self.magnitude : magnitude // ignore: cast_nullable_to_non_nullable
as Magnitude,depth: null == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as Depth,detailed: freezed == detailed ? _self.detailed : detailed // ignore: cast_nullable_to_non_nullable
as CodeName?,
  ));
}

/// Create a copy of Hypocenter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CodeNameCopyWith<$Res> get value {
  
  return $CodeNameCopyWith<$Res>(_self.value, (value) {
    return _then(_self.copyWith(value: value));
  });
}/// Create a copy of Hypocenter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CoordinateCopyWith<$Res> get coordinates {
  
  return $CoordinateCopyWith<$Res>(_self.coordinates, (value) {
    return _then(_self.copyWith(coordinates: value));
  });
}/// Create a copy of Hypocenter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MagnitudeCopyWith<$Res> get magnitude {
  
  return $MagnitudeCopyWith<$Res>(_self.magnitude, (value) {
    return _then(_self.copyWith(magnitude: value));
  });
}/// Create a copy of Hypocenter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DepthCopyWith<$Res> get depth {
  
  return $DepthCopyWith<$Res>(_self.depth, (value) {
    return _then(_self.copyWith(depth: value));
  });
}/// Create a copy of Hypocenter
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
}
}

// dart format on
