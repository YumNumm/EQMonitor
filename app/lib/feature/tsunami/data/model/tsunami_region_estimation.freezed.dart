// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tsunami_region_estimation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TsunamiRegionEstimation {

 TsunamiEstimationFirstHeight get firstHeight; TsunamiEstimationMaxHeight get maxHeight;
/// Create a copy of TsunamiRegionEstimation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiRegionEstimationCopyWith<TsunamiRegionEstimation> get copyWith => _$TsunamiRegionEstimationCopyWithImpl<TsunamiRegionEstimation>(this as TsunamiRegionEstimation, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiRegionEstimation&&(identical(other.firstHeight, firstHeight) || other.firstHeight == firstHeight)&&(identical(other.maxHeight, maxHeight) || other.maxHeight == maxHeight));
}


@override
int get hashCode => Object.hash(runtimeType,firstHeight,maxHeight);

@override
String toString() {
  return 'TsunamiRegionEstimation(firstHeight: $firstHeight, maxHeight: $maxHeight)';
}


}

/// @nodoc
abstract mixin class $TsunamiRegionEstimationCopyWith<$Res>  {
  factory $TsunamiRegionEstimationCopyWith(TsunamiRegionEstimation value, $Res Function(TsunamiRegionEstimation) _then) = _$TsunamiRegionEstimationCopyWithImpl;
@useResult
$Res call({
 TsunamiEstimationFirstHeight firstHeight, TsunamiEstimationMaxHeight maxHeight
});


$TsunamiEstimationFirstHeightCopyWith<$Res> get firstHeight;$TsunamiEstimationMaxHeightCopyWith<$Res> get maxHeight;

}
/// @nodoc
class _$TsunamiRegionEstimationCopyWithImpl<$Res>
    implements $TsunamiRegionEstimationCopyWith<$Res> {
  _$TsunamiRegionEstimationCopyWithImpl(this._self, this._then);

  final TsunamiRegionEstimation _self;
  final $Res Function(TsunamiRegionEstimation) _then;

/// Create a copy of TsunamiRegionEstimation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? firstHeight = null,Object? maxHeight = null,}) {
  return _then(TsunamiRegionEstimation(
firstHeight: null == firstHeight ? _self.firstHeight : firstHeight // ignore: cast_nullable_to_non_nullable
as TsunamiEstimationFirstHeight,maxHeight: null == maxHeight ? _self.maxHeight : maxHeight // ignore: cast_nullable_to_non_nullable
as TsunamiEstimationMaxHeight,
  ));
}
/// Create a copy of TsunamiRegionEstimation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiEstimationFirstHeightCopyWith<$Res> get firstHeight {
  
  return $TsunamiEstimationFirstHeightCopyWith<$Res>(_self.firstHeight, (value) {
    return _then(_self.copyWith(firstHeight: value));
  });
}/// Create a copy of TsunamiRegionEstimation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiEstimationMaxHeightCopyWith<$Res> get maxHeight {
  
  return $TsunamiEstimationMaxHeightCopyWith<$Res>(_self.maxHeight, (value) {
    return _then(_self.copyWith(maxHeight: value));
  });
}
}


/// Adds pattern-matching-related methods to [TsunamiRegionEstimation].
extension TsunamiRegionEstimationPatterns on TsunamiRegionEstimation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TsunamiRegionEstimation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TsunamiRegionEstimation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TsunamiRegionEstimation value)  $default,){
final _that = this;
switch (_that) {
case _TsunamiRegionEstimation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TsunamiRegionEstimation value)?  $default,){
final _that = this;
switch (_that) {
case _TsunamiRegionEstimation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TsunamiEstimationFirstHeight firstHeight,  TsunamiEstimationMaxHeight maxHeight)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TsunamiRegionEstimation() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TsunamiEstimationFirstHeight firstHeight,  TsunamiEstimationMaxHeight maxHeight)  $default,) {final _that = this;
switch (_that) {
case _TsunamiRegionEstimation():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TsunamiEstimationFirstHeight firstHeight,  TsunamiEstimationMaxHeight maxHeight)?  $default,) {final _that = this;
switch (_that) {
case _TsunamiRegionEstimation() when $default != null:
return $default(_that.firstHeight,_that.maxHeight);case _:
  return null;

}
}

}

/// @nodoc


class _TsunamiRegionEstimation implements TsunamiRegionEstimation {
  const _TsunamiRegionEstimation({required this.firstHeight, required this.maxHeight});
  

@override final  TsunamiEstimationFirstHeight firstHeight;
@override final  TsunamiEstimationMaxHeight maxHeight;

/// Create a copy of TsunamiRegionEstimation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiRegionEstimationCopyWith<_TsunamiRegionEstimation> get copyWith => __$TsunamiRegionEstimationCopyWithImpl<_TsunamiRegionEstimation>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiRegionEstimation&&(identical(other.firstHeight, firstHeight) || other.firstHeight == firstHeight)&&(identical(other.maxHeight, maxHeight) || other.maxHeight == maxHeight));
}


@override
int get hashCode => Object.hash(runtimeType,firstHeight,maxHeight);

@override
String toString() {
  return 'TsunamiRegionEstimation(firstHeight: $firstHeight, maxHeight: $maxHeight)';
}


}

/// @nodoc
abstract mixin class _$TsunamiRegionEstimationCopyWith<$Res> implements $TsunamiRegionEstimationCopyWith<$Res> {
  factory _$TsunamiRegionEstimationCopyWith(_TsunamiRegionEstimation value, $Res Function(_TsunamiRegionEstimation) _then) = __$TsunamiRegionEstimationCopyWithImpl;
@override @useResult
$Res call({
 TsunamiEstimationFirstHeight firstHeight, TsunamiEstimationMaxHeight maxHeight
});


@override $TsunamiEstimationFirstHeightCopyWith<$Res> get firstHeight;@override $TsunamiEstimationMaxHeightCopyWith<$Res> get maxHeight;

}
/// @nodoc
class __$TsunamiRegionEstimationCopyWithImpl<$Res>
    implements _$TsunamiRegionEstimationCopyWith<$Res> {
  __$TsunamiRegionEstimationCopyWithImpl(this._self, this._then);

  final _TsunamiRegionEstimation _self;
  final $Res Function(_TsunamiRegionEstimation) _then;

/// Create a copy of TsunamiRegionEstimation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? firstHeight = null,Object? maxHeight = null,}) {
  return _then(_TsunamiRegionEstimation(
firstHeight: null == firstHeight ? _self.firstHeight : firstHeight // ignore: cast_nullable_to_non_nullable
as TsunamiEstimationFirstHeight,maxHeight: null == maxHeight ? _self.maxHeight : maxHeight // ignore: cast_nullable_to_non_nullable
as TsunamiEstimationMaxHeight,
  ));
}

/// Create a copy of TsunamiRegionEstimation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiEstimationFirstHeightCopyWith<$Res> get firstHeight {
  
  return $TsunamiEstimationFirstHeightCopyWith<$Res>(_self.firstHeight, (value) {
    return _then(_self.copyWith(firstHeight: value));
  });
}/// Create a copy of TsunamiRegionEstimation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiEstimationMaxHeightCopyWith<$Res> get maxHeight {
  
  return $TsunamiEstimationMaxHeightCopyWith<$Res>(_self.maxHeight, (value) {
    return _then(_self.copyWith(maxHeight: value));
  });
}
}

// dart format on
