// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tsunami_region_estimation_first_height.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TsunamiRegionEstimationFirstHeight {

/// 1観測地点以上で第1波の時刻を明瞭に観測した場合
@JsonKey(includeIfNull: false, name: 'arrival_time') DateTime? get arrivalTime;/// 早いところでは既に津波到達と推定.
/// const: true.
@JsonKey(includeIfNull: false, name: 'is_already_arrived') bool? get isAlreadyArrived;@JsonKey(includeIfNull: false) Revise? get revise;
/// Create a copy of TsunamiRegionEstimationFirstHeight
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiRegionEstimationFirstHeightCopyWith<TsunamiRegionEstimationFirstHeight> get copyWith => _$TsunamiRegionEstimationFirstHeightCopyWithImpl<TsunamiRegionEstimationFirstHeight>(this as TsunamiRegionEstimationFirstHeight, _$identity);

  /// Serializes this TsunamiRegionEstimationFirstHeight to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiRegionEstimationFirstHeight&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.isAlreadyArrived, isAlreadyArrived) || other.isAlreadyArrived == isAlreadyArrived)&&(identical(other.revise, revise) || other.revise == revise));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,arrivalTime,isAlreadyArrived,revise);

@override
String toString() {
  return 'TsunamiRegionEstimationFirstHeight(arrivalTime: $arrivalTime, isAlreadyArrived: $isAlreadyArrived, revise: $revise)';
}


}

/// @nodoc
abstract mixin class $TsunamiRegionEstimationFirstHeightCopyWith<$Res>  {
  factory $TsunamiRegionEstimationFirstHeightCopyWith(TsunamiRegionEstimationFirstHeight value, $Res Function(TsunamiRegionEstimationFirstHeight) _then) = _$TsunamiRegionEstimationFirstHeightCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeIfNull: false, name: 'arrival_time') DateTime? arrivalTime,@JsonKey(includeIfNull: false, name: 'is_already_arrived') bool? isAlreadyArrived,@JsonKey(includeIfNull: false) Revise? revise
});




}
/// @nodoc
class _$TsunamiRegionEstimationFirstHeightCopyWithImpl<$Res>
    implements $TsunamiRegionEstimationFirstHeightCopyWith<$Res> {
  _$TsunamiRegionEstimationFirstHeightCopyWithImpl(this._self, this._then);

  final TsunamiRegionEstimationFirstHeight _self;
  final $Res Function(TsunamiRegionEstimationFirstHeight) _then;

/// Create a copy of TsunamiRegionEstimationFirstHeight
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? arrivalTime = freezed,Object? isAlreadyArrived = freezed,Object? revise = freezed,}) {
  return _then(_self.copyWith(
arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,isAlreadyArrived: freezed == isAlreadyArrived ? _self.isAlreadyArrived : isAlreadyArrived // ignore: cast_nullable_to_non_nullable
as bool?,revise: freezed == revise ? _self.revise : revise // ignore: cast_nullable_to_non_nullable
as Revise?,
  ));
}

}


/// Adds pattern-matching-related methods to [TsunamiRegionEstimationFirstHeight].
extension TsunamiRegionEstimationFirstHeightPatterns on TsunamiRegionEstimationFirstHeight {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TsunamiRegionEstimationFirstHeight value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TsunamiRegionEstimationFirstHeight() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TsunamiRegionEstimationFirstHeight value)  $default,){
final _that = this;
switch (_that) {
case _TsunamiRegionEstimationFirstHeight():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TsunamiRegionEstimationFirstHeight value)?  $default,){
final _that = this;
switch (_that) {
case _TsunamiRegionEstimationFirstHeight() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false, name: 'arrival_time')  DateTime? arrivalTime, @JsonKey(includeIfNull: false, name: 'is_already_arrived')  bool? isAlreadyArrived, @JsonKey(includeIfNull: false)  Revise? revise)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TsunamiRegionEstimationFirstHeight() when $default != null:
return $default(_that.arrivalTime,_that.isAlreadyArrived,_that.revise);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false, name: 'arrival_time')  DateTime? arrivalTime, @JsonKey(includeIfNull: false, name: 'is_already_arrived')  bool? isAlreadyArrived, @JsonKey(includeIfNull: false)  Revise? revise)  $default,) {final _that = this;
switch (_that) {
case _TsunamiRegionEstimationFirstHeight():
return $default(_that.arrivalTime,_that.isAlreadyArrived,_that.revise);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeIfNull: false, name: 'arrival_time')  DateTime? arrivalTime, @JsonKey(includeIfNull: false, name: 'is_already_arrived')  bool? isAlreadyArrived, @JsonKey(includeIfNull: false)  Revise? revise)?  $default,) {final _that = this;
switch (_that) {
case _TsunamiRegionEstimationFirstHeight() when $default != null:
return $default(_that.arrivalTime,_that.isAlreadyArrived,_that.revise);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TsunamiRegionEstimationFirstHeight implements TsunamiRegionEstimationFirstHeight {
  const _TsunamiRegionEstimationFirstHeight({@JsonKey(includeIfNull: false, name: 'arrival_time') this.arrivalTime, @JsonKey(includeIfNull: false, name: 'is_already_arrived') this.isAlreadyArrived, @JsonKey(includeIfNull: false) this.revise});
  factory _TsunamiRegionEstimationFirstHeight.fromJson(Map<String, dynamic> json) => _$TsunamiRegionEstimationFirstHeightFromJson(json);

/// 1観測地点以上で第1波の時刻を明瞭に観測した場合
@override@JsonKey(includeIfNull: false, name: 'arrival_time') final  DateTime? arrivalTime;
/// 早いところでは既に津波到達と推定.
/// const: true.
@override@JsonKey(includeIfNull: false, name: 'is_already_arrived') final  bool? isAlreadyArrived;
@override@JsonKey(includeIfNull: false) final  Revise? revise;

/// Create a copy of TsunamiRegionEstimationFirstHeight
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiRegionEstimationFirstHeightCopyWith<_TsunamiRegionEstimationFirstHeight> get copyWith => __$TsunamiRegionEstimationFirstHeightCopyWithImpl<_TsunamiRegionEstimationFirstHeight>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TsunamiRegionEstimationFirstHeightToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiRegionEstimationFirstHeight&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.isAlreadyArrived, isAlreadyArrived) || other.isAlreadyArrived == isAlreadyArrived)&&(identical(other.revise, revise) || other.revise == revise));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,arrivalTime,isAlreadyArrived,revise);

@override
String toString() {
  return 'TsunamiRegionEstimationFirstHeight(arrivalTime: $arrivalTime, isAlreadyArrived: $isAlreadyArrived, revise: $revise)';
}


}

/// @nodoc
abstract mixin class _$TsunamiRegionEstimationFirstHeightCopyWith<$Res> implements $TsunamiRegionEstimationFirstHeightCopyWith<$Res> {
  factory _$TsunamiRegionEstimationFirstHeightCopyWith(_TsunamiRegionEstimationFirstHeight value, $Res Function(_TsunamiRegionEstimationFirstHeight) _then) = __$TsunamiRegionEstimationFirstHeightCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeIfNull: false, name: 'arrival_time') DateTime? arrivalTime,@JsonKey(includeIfNull: false, name: 'is_already_arrived') bool? isAlreadyArrived,@JsonKey(includeIfNull: false) Revise? revise
});




}
/// @nodoc
class __$TsunamiRegionEstimationFirstHeightCopyWithImpl<$Res>
    implements _$TsunamiRegionEstimationFirstHeightCopyWith<$Res> {
  __$TsunamiRegionEstimationFirstHeightCopyWithImpl(this._self, this._then);

  final _TsunamiRegionEstimationFirstHeight _self;
  final $Res Function(_TsunamiRegionEstimationFirstHeight) _then;

/// Create a copy of TsunamiRegionEstimationFirstHeight
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? arrivalTime = freezed,Object? isAlreadyArrived = freezed,Object? revise = freezed,}) {
  return _then(_TsunamiRegionEstimationFirstHeight(
arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,isAlreadyArrived: freezed == isAlreadyArrived ? _self.isAlreadyArrived : isAlreadyArrived // ignore: cast_nullable_to_non_nullable
as bool?,revise: freezed == revise ? _self.revise : revise // ignore: cast_nullable_to_non_nullable
as Revise?,
  ));
}


}

// dart format on
