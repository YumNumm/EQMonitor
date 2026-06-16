// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tsunami_state_hypocenter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TsunamiStateHypocenter {

 CodeName get value; Depth get depth; Magnitude get magnitude;@JsonKey(includeIfNull: false) Coordinate? get coordinates;@JsonKey(includeIfNull: false) HypocenterAuxiliary? get auxiliary;
/// Create a copy of TsunamiStateHypocenter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiStateHypocenterCopyWith<TsunamiStateHypocenter> get copyWith => _$TsunamiStateHypocenterCopyWithImpl<TsunamiStateHypocenter>(this as TsunamiStateHypocenter, _$identity);

  /// Serializes this TsunamiStateHypocenter to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiStateHypocenter&&(identical(other.value, value) || other.value == value)&&(identical(other.depth, depth) || other.depth == depth)&&(identical(other.magnitude, magnitude) || other.magnitude == magnitude)&&(identical(other.coordinates, coordinates) || other.coordinates == coordinates)&&(identical(other.auxiliary, auxiliary) || other.auxiliary == auxiliary));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,depth,magnitude,coordinates,auxiliary);

@override
String toString() {
  return 'TsunamiStateHypocenter(value: $value, depth: $depth, magnitude: $magnitude, coordinates: $coordinates, auxiliary: $auxiliary)';
}


}

/// @nodoc
abstract mixin class $TsunamiStateHypocenterCopyWith<$Res>  {
  factory $TsunamiStateHypocenterCopyWith(TsunamiStateHypocenter value, $Res Function(TsunamiStateHypocenter) _then) = _$TsunamiStateHypocenterCopyWithImpl;
@useResult
$Res call({
 CodeName value, Depth depth, Magnitude magnitude,@JsonKey(includeIfNull: false) Coordinate? coordinates,@JsonKey(includeIfNull: false) HypocenterAuxiliary? auxiliary
});


$CodeNameCopyWith<$Res> get value;$DepthCopyWith<$Res> get depth;$MagnitudeCopyWith<$Res> get magnitude;$CoordinateCopyWith<$Res>? get coordinates;$HypocenterAuxiliaryCopyWith<$Res>? get auxiliary;

}
/// @nodoc
class _$TsunamiStateHypocenterCopyWithImpl<$Res>
    implements $TsunamiStateHypocenterCopyWith<$Res> {
  _$TsunamiStateHypocenterCopyWithImpl(this._self, this._then);

  final TsunamiStateHypocenter _self;
  final $Res Function(TsunamiStateHypocenter) _then;

/// Create a copy of TsunamiStateHypocenter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = null,Object? depth = null,Object? magnitude = null,Object? coordinates = freezed,Object? auxiliary = freezed,}) {
  return _then(_self.copyWith(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as CodeName,depth: null == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as Depth,magnitude: null == magnitude ? _self.magnitude : magnitude // ignore: cast_nullable_to_non_nullable
as Magnitude,coordinates: freezed == coordinates ? _self.coordinates : coordinates // ignore: cast_nullable_to_non_nullable
as Coordinate?,auxiliary: freezed == auxiliary ? _self.auxiliary : auxiliary // ignore: cast_nullable_to_non_nullable
as HypocenterAuxiliary?,
  ));
}
/// Create a copy of TsunamiStateHypocenter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CodeNameCopyWith<$Res> get value {
  
  return $CodeNameCopyWith<$Res>(_self.value, (value) {
    return _then(_self.copyWith(value: value));
  });
}/// Create a copy of TsunamiStateHypocenter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DepthCopyWith<$Res> get depth {
  
  return $DepthCopyWith<$Res>(_self.depth, (value) {
    return _then(_self.copyWith(depth: value));
  });
}/// Create a copy of TsunamiStateHypocenter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MagnitudeCopyWith<$Res> get magnitude {
  
  return $MagnitudeCopyWith<$Res>(_self.magnitude, (value) {
    return _then(_self.copyWith(magnitude: value));
  });
}/// Create a copy of TsunamiStateHypocenter
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
}/// Create a copy of TsunamiStateHypocenter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HypocenterAuxiliaryCopyWith<$Res>? get auxiliary {
    if (_self.auxiliary == null) {
    return null;
  }

  return $HypocenterAuxiliaryCopyWith<$Res>(_self.auxiliary!, (value) {
    return _then(_self.copyWith(auxiliary: value));
  });
}
}


/// Adds pattern-matching-related methods to [TsunamiStateHypocenter].
extension TsunamiStateHypocenterPatterns on TsunamiStateHypocenter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TsunamiStateHypocenter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TsunamiStateHypocenter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TsunamiStateHypocenter value)  $default,){
final _that = this;
switch (_that) {
case _TsunamiStateHypocenter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TsunamiStateHypocenter value)?  $default,){
final _that = this;
switch (_that) {
case _TsunamiStateHypocenter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CodeName value,  Depth depth,  Magnitude magnitude, @JsonKey(includeIfNull: false)  Coordinate? coordinates, @JsonKey(includeIfNull: false)  HypocenterAuxiliary? auxiliary)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TsunamiStateHypocenter() when $default != null:
return $default(_that.value,_that.depth,_that.magnitude,_that.coordinates,_that.auxiliary);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CodeName value,  Depth depth,  Magnitude magnitude, @JsonKey(includeIfNull: false)  Coordinate? coordinates, @JsonKey(includeIfNull: false)  HypocenterAuxiliary? auxiliary)  $default,) {final _that = this;
switch (_that) {
case _TsunamiStateHypocenter():
return $default(_that.value,_that.depth,_that.magnitude,_that.coordinates,_that.auxiliary);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CodeName value,  Depth depth,  Magnitude magnitude, @JsonKey(includeIfNull: false)  Coordinate? coordinates, @JsonKey(includeIfNull: false)  HypocenterAuxiliary? auxiliary)?  $default,) {final _that = this;
switch (_that) {
case _TsunamiStateHypocenter() when $default != null:
return $default(_that.value,_that.depth,_that.magnitude,_that.coordinates,_that.auxiliary);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TsunamiStateHypocenter implements TsunamiStateHypocenter {
  const _TsunamiStateHypocenter({required this.value, required this.depth, required this.magnitude, @JsonKey(includeIfNull: false) this.coordinates, @JsonKey(includeIfNull: false) this.auxiliary});
  factory _TsunamiStateHypocenter.fromJson(Map<String, dynamic> json) => _$TsunamiStateHypocenterFromJson(json);

@override final  CodeName value;
@override final  Depth depth;
@override final  Magnitude magnitude;
@override@JsonKey(includeIfNull: false) final  Coordinate? coordinates;
@override@JsonKey(includeIfNull: false) final  HypocenterAuxiliary? auxiliary;

/// Create a copy of TsunamiStateHypocenter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiStateHypocenterCopyWith<_TsunamiStateHypocenter> get copyWith => __$TsunamiStateHypocenterCopyWithImpl<_TsunamiStateHypocenter>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TsunamiStateHypocenterToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiStateHypocenter&&(identical(other.value, value) || other.value == value)&&(identical(other.depth, depth) || other.depth == depth)&&(identical(other.magnitude, magnitude) || other.magnitude == magnitude)&&(identical(other.coordinates, coordinates) || other.coordinates == coordinates)&&(identical(other.auxiliary, auxiliary) || other.auxiliary == auxiliary));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,depth,magnitude,coordinates,auxiliary);

@override
String toString() {
  return 'TsunamiStateHypocenter(value: $value, depth: $depth, magnitude: $magnitude, coordinates: $coordinates, auxiliary: $auxiliary)';
}


}

/// @nodoc
abstract mixin class _$TsunamiStateHypocenterCopyWith<$Res> implements $TsunamiStateHypocenterCopyWith<$Res> {
  factory _$TsunamiStateHypocenterCopyWith(_TsunamiStateHypocenter value, $Res Function(_TsunamiStateHypocenter) _then) = __$TsunamiStateHypocenterCopyWithImpl;
@override @useResult
$Res call({
 CodeName value, Depth depth, Magnitude magnitude,@JsonKey(includeIfNull: false) Coordinate? coordinates,@JsonKey(includeIfNull: false) HypocenterAuxiliary? auxiliary
});


@override $CodeNameCopyWith<$Res> get value;@override $DepthCopyWith<$Res> get depth;@override $MagnitudeCopyWith<$Res> get magnitude;@override $CoordinateCopyWith<$Res>? get coordinates;@override $HypocenterAuxiliaryCopyWith<$Res>? get auxiliary;

}
/// @nodoc
class __$TsunamiStateHypocenterCopyWithImpl<$Res>
    implements _$TsunamiStateHypocenterCopyWith<$Res> {
  __$TsunamiStateHypocenterCopyWithImpl(this._self, this._then);

  final _TsunamiStateHypocenter _self;
  final $Res Function(_TsunamiStateHypocenter) _then;

/// Create a copy of TsunamiStateHypocenter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = null,Object? depth = null,Object? magnitude = null,Object? coordinates = freezed,Object? auxiliary = freezed,}) {
  return _then(_TsunamiStateHypocenter(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as CodeName,depth: null == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as Depth,magnitude: null == magnitude ? _self.magnitude : magnitude // ignore: cast_nullable_to_non_nullable
as Magnitude,coordinates: freezed == coordinates ? _self.coordinates : coordinates // ignore: cast_nullable_to_non_nullable
as Coordinate?,auxiliary: freezed == auxiliary ? _self.auxiliary : auxiliary // ignore: cast_nullable_to_non_nullable
as HypocenterAuxiliary?,
  ));
}

/// Create a copy of TsunamiStateHypocenter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CodeNameCopyWith<$Res> get value {
  
  return $CodeNameCopyWith<$Res>(_self.value, (value) {
    return _then(_self.copyWith(value: value));
  });
}/// Create a copy of TsunamiStateHypocenter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DepthCopyWith<$Res> get depth {
  
  return $DepthCopyWith<$Res>(_self.depth, (value) {
    return _then(_self.copyWith(depth: value));
  });
}/// Create a copy of TsunamiStateHypocenter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MagnitudeCopyWith<$Res> get magnitude {
  
  return $MagnitudeCopyWith<$Res>(_self.magnitude, (value) {
    return _then(_self.copyWith(magnitude: value));
  });
}/// Create a copy of TsunamiStateHypocenter
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
}/// Create a copy of TsunamiStateHypocenter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HypocenterAuxiliaryCopyWith<$Res>? get auxiliary {
    if (_self.auxiliary == null) {
    return null;
  }

  return $HypocenterAuxiliaryCopyWith<$Res>(_self.auxiliary!, (value) {
    return _then(_self.copyWith(auxiliary: value));
  });
}
}

// dart format on
