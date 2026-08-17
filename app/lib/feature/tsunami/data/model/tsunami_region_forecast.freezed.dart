// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tsunami_region_forecast.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TsunamiRegionForecast {

 TsunamiForecastFirstHeight? get firstHeight; TsunamiForecastMaxHeight? get maxHeight;
/// Create a copy of TsunamiRegionForecast
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiRegionForecastCopyWith<TsunamiRegionForecast> get copyWith => _$TsunamiRegionForecastCopyWithImpl<TsunamiRegionForecast>(this as TsunamiRegionForecast, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiRegionForecast&&(identical(other.firstHeight, firstHeight) || other.firstHeight == firstHeight)&&(identical(other.maxHeight, maxHeight) || other.maxHeight == maxHeight));
}


@override
int get hashCode => Object.hash(runtimeType,firstHeight,maxHeight);

@override
String toString() {
  return 'TsunamiRegionForecast(firstHeight: $firstHeight, maxHeight: $maxHeight)';
}


}

/// @nodoc
abstract mixin class $TsunamiRegionForecastCopyWith<$Res>  {
  factory $TsunamiRegionForecastCopyWith(TsunamiRegionForecast value, $Res Function(TsunamiRegionForecast) _then) = _$TsunamiRegionForecastCopyWithImpl;
@useResult
$Res call({
 TsunamiForecastFirstHeight? firstHeight, TsunamiForecastMaxHeight? maxHeight
});


$TsunamiForecastFirstHeightCopyWith<$Res>? get firstHeight;$TsunamiForecastMaxHeightCopyWith<$Res>? get maxHeight;

}
/// @nodoc
class _$TsunamiRegionForecastCopyWithImpl<$Res>
    implements $TsunamiRegionForecastCopyWith<$Res> {
  _$TsunamiRegionForecastCopyWithImpl(this._self, this._then);

  final TsunamiRegionForecast _self;
  final $Res Function(TsunamiRegionForecast) _then;

/// Create a copy of TsunamiRegionForecast
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? firstHeight = freezed,Object? maxHeight = freezed,}) {
  return _then(TsunamiRegionForecast(
firstHeight: freezed == firstHeight ? _self.firstHeight : firstHeight // ignore: cast_nullable_to_non_nullable
as TsunamiForecastFirstHeight?,maxHeight: freezed == maxHeight ? _self.maxHeight : maxHeight // ignore: cast_nullable_to_non_nullable
as TsunamiForecastMaxHeight?,
  ));
}
/// Create a copy of TsunamiRegionForecast
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiForecastFirstHeightCopyWith<$Res>? get firstHeight {
    if (_self.firstHeight == null) {
    return null;
  }

  return $TsunamiForecastFirstHeightCopyWith<$Res>(_self.firstHeight!, (value) {
    return _then(_self.copyWith(firstHeight: value));
  });
}/// Create a copy of TsunamiRegionForecast
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiForecastMaxHeightCopyWith<$Res>? get maxHeight {
    if (_self.maxHeight == null) {
    return null;
  }

  return $TsunamiForecastMaxHeightCopyWith<$Res>(_self.maxHeight!, (value) {
    return _then(_self.copyWith(maxHeight: value));
  });
}
}


/// Adds pattern-matching-related methods to [TsunamiRegionForecast].
extension TsunamiRegionForecastPatterns on TsunamiRegionForecast {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TsunamiRegionForecast value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TsunamiRegionForecast() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TsunamiRegionForecast value)  $default,){
final _that = this;
switch (_that) {
case _TsunamiRegionForecast():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TsunamiRegionForecast value)?  $default,){
final _that = this;
switch (_that) {
case _TsunamiRegionForecast() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TsunamiForecastFirstHeight? firstHeight,  TsunamiForecastMaxHeight? maxHeight)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TsunamiRegionForecast() when $default != null:
return $default(_that.firstHeight,_that.maxHeight);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TsunamiForecastFirstHeight? firstHeight,  TsunamiForecastMaxHeight? maxHeight)  $default,) {final _that = this;
switch (_that) {
case _TsunamiRegionForecast():
return $default(_that.firstHeight,_that.maxHeight);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TsunamiForecastFirstHeight? firstHeight,  TsunamiForecastMaxHeight? maxHeight)?  $default,) {final _that = this;
switch (_that) {
case _TsunamiRegionForecast() when $default != null:
return $default(_that.firstHeight,_that.maxHeight);case _:
  return null;

}
}

}

/// @nodoc


class _TsunamiRegionForecast implements TsunamiRegionForecast {
  const _TsunamiRegionForecast({this.firstHeight, this.maxHeight});
  

@override final  TsunamiForecastFirstHeight? firstHeight;
@override final  TsunamiForecastMaxHeight? maxHeight;

/// Create a copy of TsunamiRegionForecast
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiRegionForecastCopyWith<_TsunamiRegionForecast> get copyWith => __$TsunamiRegionForecastCopyWithImpl<_TsunamiRegionForecast>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiRegionForecast&&(identical(other.firstHeight, firstHeight) || other.firstHeight == firstHeight)&&(identical(other.maxHeight, maxHeight) || other.maxHeight == maxHeight));
}


@override
int get hashCode => Object.hash(runtimeType,firstHeight,maxHeight);

@override
String toString() {
  return 'TsunamiRegionForecast(firstHeight: $firstHeight, maxHeight: $maxHeight)';
}


}

/// @nodoc
abstract mixin class _$TsunamiRegionForecastCopyWith<$Res> implements $TsunamiRegionForecastCopyWith<$Res> {
  factory _$TsunamiRegionForecastCopyWith(_TsunamiRegionForecast value, $Res Function(_TsunamiRegionForecast) _then) = __$TsunamiRegionForecastCopyWithImpl;
@override @useResult
$Res call({
 TsunamiForecastFirstHeight? firstHeight, TsunamiForecastMaxHeight? maxHeight
});


@override $TsunamiForecastFirstHeightCopyWith<$Res>? get firstHeight;@override $TsunamiForecastMaxHeightCopyWith<$Res>? get maxHeight;

}
/// @nodoc
class __$TsunamiRegionForecastCopyWithImpl<$Res>
    implements _$TsunamiRegionForecastCopyWith<$Res> {
  __$TsunamiRegionForecastCopyWithImpl(this._self, this._then);

  final _TsunamiRegionForecast _self;
  final $Res Function(_TsunamiRegionForecast) _then;

/// Create a copy of TsunamiRegionForecast
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? firstHeight = freezed,Object? maxHeight = freezed,}) {
  return _then(_TsunamiRegionForecast(
firstHeight: freezed == firstHeight ? _self.firstHeight : firstHeight // ignore: cast_nullable_to_non_nullable
as TsunamiForecastFirstHeight?,maxHeight: freezed == maxHeight ? _self.maxHeight : maxHeight // ignore: cast_nullable_to_non_nullable
as TsunamiForecastMaxHeight?,
  ));
}

/// Create a copy of TsunamiRegionForecast
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiForecastFirstHeightCopyWith<$Res>? get firstHeight {
    if (_self.firstHeight == null) {
    return null;
  }

  return $TsunamiForecastFirstHeightCopyWith<$Res>(_self.firstHeight!, (value) {
    return _then(_self.copyWith(firstHeight: value));
  });
}/// Create a copy of TsunamiRegionForecast
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiForecastMaxHeightCopyWith<$Res>? get maxHeight {
    if (_self.maxHeight == null) {
    return null;
  }

  return $TsunamiForecastMaxHeightCopyWith<$Res>(_self.maxHeight!, (value) {
    return _then(_self.copyWith(maxHeight: value));
  });
}
}

// dart format on
