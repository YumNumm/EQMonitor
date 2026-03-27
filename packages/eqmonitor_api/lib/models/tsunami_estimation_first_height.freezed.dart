// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tsunami_estimation_first_height.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TsunamiEstimationFirstHeight {

@JsonKey(name: 'is_already_arrived') bool get isAlreadyArrived;@JsonKey(includeIfNull: false, name: 'arrival_time') DateTime? get arrivalTime;
/// Create a copy of TsunamiEstimationFirstHeight
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiEstimationFirstHeightCopyWith<TsunamiEstimationFirstHeight> get copyWith => _$TsunamiEstimationFirstHeightCopyWithImpl<TsunamiEstimationFirstHeight>(this as TsunamiEstimationFirstHeight, _$identity);

  /// Serializes this TsunamiEstimationFirstHeight to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiEstimationFirstHeight&&(identical(other.isAlreadyArrived, isAlreadyArrived) || other.isAlreadyArrived == isAlreadyArrived)&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isAlreadyArrived,arrivalTime);

@override
String toString() {
  return 'TsunamiEstimationFirstHeight(isAlreadyArrived: $isAlreadyArrived, arrivalTime: $arrivalTime)';
}


}

/// @nodoc
abstract mixin class $TsunamiEstimationFirstHeightCopyWith<$Res>  {
  factory $TsunamiEstimationFirstHeightCopyWith(TsunamiEstimationFirstHeight value, $Res Function(TsunamiEstimationFirstHeight) _then) = _$TsunamiEstimationFirstHeightCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'is_already_arrived') bool isAlreadyArrived,@JsonKey(includeIfNull: false, name: 'arrival_time') DateTime? arrivalTime
});




}
/// @nodoc
class _$TsunamiEstimationFirstHeightCopyWithImpl<$Res>
    implements $TsunamiEstimationFirstHeightCopyWith<$Res> {
  _$TsunamiEstimationFirstHeightCopyWithImpl(this._self, this._then);

  final TsunamiEstimationFirstHeight _self;
  final $Res Function(TsunamiEstimationFirstHeight) _then;

/// Create a copy of TsunamiEstimationFirstHeight
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isAlreadyArrived = null,Object? arrivalTime = freezed,}) {
  return _then(_self.copyWith(
isAlreadyArrived: null == isAlreadyArrived ? _self.isAlreadyArrived : isAlreadyArrived // ignore: cast_nullable_to_non_nullable
as bool,arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [TsunamiEstimationFirstHeight].
extension TsunamiEstimationFirstHeightPatterns on TsunamiEstimationFirstHeight {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TsunamiEstimationFirstHeight value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TsunamiEstimationFirstHeight() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TsunamiEstimationFirstHeight value)  $default,){
final _that = this;
switch (_that) {
case _TsunamiEstimationFirstHeight():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TsunamiEstimationFirstHeight value)?  $default,){
final _that = this;
switch (_that) {
case _TsunamiEstimationFirstHeight() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'is_already_arrived')  bool isAlreadyArrived, @JsonKey(includeIfNull: false, name: 'arrival_time')  DateTime? arrivalTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TsunamiEstimationFirstHeight() when $default != null:
return $default(_that.isAlreadyArrived,_that.arrivalTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'is_already_arrived')  bool isAlreadyArrived, @JsonKey(includeIfNull: false, name: 'arrival_time')  DateTime? arrivalTime)  $default,) {final _that = this;
switch (_that) {
case _TsunamiEstimationFirstHeight():
return $default(_that.isAlreadyArrived,_that.arrivalTime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'is_already_arrived')  bool isAlreadyArrived, @JsonKey(includeIfNull: false, name: 'arrival_time')  DateTime? arrivalTime)?  $default,) {final _that = this;
switch (_that) {
case _TsunamiEstimationFirstHeight() when $default != null:
return $default(_that.isAlreadyArrived,_that.arrivalTime);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TsunamiEstimationFirstHeight implements TsunamiEstimationFirstHeight {
  const _TsunamiEstimationFirstHeight({@JsonKey(name: 'is_already_arrived') required this.isAlreadyArrived, @JsonKey(includeIfNull: false, name: 'arrival_time') this.arrivalTime});
  factory _TsunamiEstimationFirstHeight.fromJson(Map<String, dynamic> json) => _$TsunamiEstimationFirstHeightFromJson(json);

@override@JsonKey(name: 'is_already_arrived') final  bool isAlreadyArrived;
@override@JsonKey(includeIfNull: false, name: 'arrival_time') final  DateTime? arrivalTime;

/// Create a copy of TsunamiEstimationFirstHeight
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiEstimationFirstHeightCopyWith<_TsunamiEstimationFirstHeight> get copyWith => __$TsunamiEstimationFirstHeightCopyWithImpl<_TsunamiEstimationFirstHeight>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TsunamiEstimationFirstHeightToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiEstimationFirstHeight&&(identical(other.isAlreadyArrived, isAlreadyArrived) || other.isAlreadyArrived == isAlreadyArrived)&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isAlreadyArrived,arrivalTime);

@override
String toString() {
  return 'TsunamiEstimationFirstHeight(isAlreadyArrived: $isAlreadyArrived, arrivalTime: $arrivalTime)';
}


}

/// @nodoc
abstract mixin class _$TsunamiEstimationFirstHeightCopyWith<$Res> implements $TsunamiEstimationFirstHeightCopyWith<$Res> {
  factory _$TsunamiEstimationFirstHeightCopyWith(_TsunamiEstimationFirstHeight value, $Res Function(_TsunamiEstimationFirstHeight) _then) = __$TsunamiEstimationFirstHeightCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'is_already_arrived') bool isAlreadyArrived,@JsonKey(includeIfNull: false, name: 'arrival_time') DateTime? arrivalTime
});




}
/// @nodoc
class __$TsunamiEstimationFirstHeightCopyWithImpl<$Res>
    implements _$TsunamiEstimationFirstHeightCopyWith<$Res> {
  __$TsunamiEstimationFirstHeightCopyWithImpl(this._self, this._then);

  final _TsunamiEstimationFirstHeight _self;
  final $Res Function(_TsunamiEstimationFirstHeight) _then;

/// Create a copy of TsunamiEstimationFirstHeight
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isAlreadyArrived = null,Object? arrivalTime = freezed,}) {
  return _then(_TsunamiEstimationFirstHeight(
isAlreadyArrived: null == isAlreadyArrived ? _self.isAlreadyArrived : isAlreadyArrived // ignore: cast_nullable_to_non_nullable
as bool,arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
