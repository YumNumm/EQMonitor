// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'estimation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Estimation {

@JsonKey(includeIfNull: false, name: 'first_height') TsunamiEstimationFirstHeight? get firstHeight;@JsonKey(includeIfNull: false, name: 'max_height') TsunamiEstimationMaxHeight? get maxHeight;
/// Create a copy of Estimation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EstimationCopyWith<Estimation> get copyWith => _$EstimationCopyWithImpl<Estimation>(this as Estimation, _$identity);

  /// Serializes this Estimation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Estimation&&(identical(other.firstHeight, firstHeight) || other.firstHeight == firstHeight)&&(identical(other.maxHeight, maxHeight) || other.maxHeight == maxHeight));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,firstHeight,maxHeight);

@override
String toString() {
  return 'Estimation(firstHeight: $firstHeight, maxHeight: $maxHeight)';
}


}

/// @nodoc
abstract mixin class $EstimationCopyWith<$Res>  {
  factory $EstimationCopyWith(Estimation value, $Res Function(Estimation) _then) = _$EstimationCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeIfNull: false, name: 'first_height') TsunamiEstimationFirstHeight? firstHeight,@JsonKey(includeIfNull: false, name: 'max_height') TsunamiEstimationMaxHeight? maxHeight
});


$TsunamiEstimationFirstHeightCopyWith<$Res>? get firstHeight;$TsunamiEstimationMaxHeightCopyWith<$Res>? get maxHeight;

}
/// @nodoc
class _$EstimationCopyWithImpl<$Res>
    implements $EstimationCopyWith<$Res> {
  _$EstimationCopyWithImpl(this._self, this._then);

  final Estimation _self;
  final $Res Function(Estimation) _then;

/// Create a copy of Estimation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? firstHeight = freezed,Object? maxHeight = freezed,}) {
  return _then(_self.copyWith(
firstHeight: freezed == firstHeight ? _self.firstHeight : firstHeight // ignore: cast_nullable_to_non_nullable
as TsunamiEstimationFirstHeight?,maxHeight: freezed == maxHeight ? _self.maxHeight : maxHeight // ignore: cast_nullable_to_non_nullable
as TsunamiEstimationMaxHeight?,
  ));
}
/// Create a copy of Estimation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiEstimationFirstHeightCopyWith<$Res>? get firstHeight {
    if (_self.firstHeight == null) {
    return null;
  }

  return $TsunamiEstimationFirstHeightCopyWith<$Res>(_self.firstHeight!, (value) {
    return _then(_self.copyWith(firstHeight: value));
  });
}/// Create a copy of Estimation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiEstimationMaxHeightCopyWith<$Res>? get maxHeight {
    if (_self.maxHeight == null) {
    return null;
  }

  return $TsunamiEstimationMaxHeightCopyWith<$Res>(_self.maxHeight!, (value) {
    return _then(_self.copyWith(maxHeight: value));
  });
}
}


/// Adds pattern-matching-related methods to [Estimation].
extension EstimationPatterns on Estimation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Estimation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Estimation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Estimation value)  $default,){
final _that = this;
switch (_that) {
case _Estimation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Estimation value)?  $default,){
final _that = this;
switch (_that) {
case _Estimation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false, name: 'first_height')  TsunamiEstimationFirstHeight? firstHeight, @JsonKey(includeIfNull: false, name: 'max_height')  TsunamiEstimationMaxHeight? maxHeight)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Estimation() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false, name: 'first_height')  TsunamiEstimationFirstHeight? firstHeight, @JsonKey(includeIfNull: false, name: 'max_height')  TsunamiEstimationMaxHeight? maxHeight)  $default,) {final _that = this;
switch (_that) {
case _Estimation():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeIfNull: false, name: 'first_height')  TsunamiEstimationFirstHeight? firstHeight, @JsonKey(includeIfNull: false, name: 'max_height')  TsunamiEstimationMaxHeight? maxHeight)?  $default,) {final _that = this;
switch (_that) {
case _Estimation() when $default != null:
return $default(_that.firstHeight,_that.maxHeight);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Estimation implements Estimation {
  const _Estimation({@JsonKey(includeIfNull: false, name: 'first_height') this.firstHeight, @JsonKey(includeIfNull: false, name: 'max_height') this.maxHeight});
  factory _Estimation.fromJson(Map<String, dynamic> json) => _$EstimationFromJson(json);

@override@JsonKey(includeIfNull: false, name: 'first_height') final  TsunamiEstimationFirstHeight? firstHeight;
@override@JsonKey(includeIfNull: false, name: 'max_height') final  TsunamiEstimationMaxHeight? maxHeight;

/// Create a copy of Estimation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EstimationCopyWith<_Estimation> get copyWith => __$EstimationCopyWithImpl<_Estimation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EstimationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Estimation&&(identical(other.firstHeight, firstHeight) || other.firstHeight == firstHeight)&&(identical(other.maxHeight, maxHeight) || other.maxHeight == maxHeight));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,firstHeight,maxHeight);

@override
String toString() {
  return 'Estimation(firstHeight: $firstHeight, maxHeight: $maxHeight)';
}


}

/// @nodoc
abstract mixin class _$EstimationCopyWith<$Res> implements $EstimationCopyWith<$Res> {
  factory _$EstimationCopyWith(_Estimation value, $Res Function(_Estimation) _then) = __$EstimationCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeIfNull: false, name: 'first_height') TsunamiEstimationFirstHeight? firstHeight,@JsonKey(includeIfNull: false, name: 'max_height') TsunamiEstimationMaxHeight? maxHeight
});


@override $TsunamiEstimationFirstHeightCopyWith<$Res>? get firstHeight;@override $TsunamiEstimationMaxHeightCopyWith<$Res>? get maxHeight;

}
/// @nodoc
class __$EstimationCopyWithImpl<$Res>
    implements _$EstimationCopyWith<$Res> {
  __$EstimationCopyWithImpl(this._self, this._then);

  final _Estimation _self;
  final $Res Function(_Estimation) _then;

/// Create a copy of Estimation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? firstHeight = freezed,Object? maxHeight = freezed,}) {
  return _then(_Estimation(
firstHeight: freezed == firstHeight ? _self.firstHeight : firstHeight // ignore: cast_nullable_to_non_nullable
as TsunamiEstimationFirstHeight?,maxHeight: freezed == maxHeight ? _self.maxHeight : maxHeight // ignore: cast_nullable_to_non_nullable
as TsunamiEstimationMaxHeight?,
  ));
}

/// Create a copy of Estimation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiEstimationFirstHeightCopyWith<$Res>? get firstHeight {
    if (_self.firstHeight == null) {
    return null;
  }

  return $TsunamiEstimationFirstHeightCopyWith<$Res>(_self.firstHeight!, (value) {
    return _then(_self.copyWith(firstHeight: value));
  });
}/// Create a copy of Estimation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiEstimationMaxHeightCopyWith<$Res>? get maxHeight {
    if (_self.maxHeight == null) {
    return null;
  }

  return $TsunamiEstimationMaxHeightCopyWith<$Res>(_self.maxHeight!, (value) {
    return _then(_self.copyWith(maxHeight: value));
  });
}
}

// dart format on
