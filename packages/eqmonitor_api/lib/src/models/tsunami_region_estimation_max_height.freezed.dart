// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tsunami_region_estimation_max_height.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TsunamiRegionEstimationMaxHeight {

@JsonKey(includeIfNull: false, name: 'observed_at') DateTime? get observedAt;/// 津波警報以上でまだ津波の観測値が小さい場合は出現しない
@JsonKey(includeIfNull: false) num? get value;/// 10m超となる時に出現する 取りうる値はtrueのみ.
/// const: true.
@JsonKey(includeIfNull: false, name: 'is_over') bool? get isOver;@JsonKey(includeIfNull: false) QualitativeHeight? get qualitative;/// 津波警報以上でまだ津波の観測値が小さい場合に出現する.
/// const: true.
@JsonKey(includeIfNull: false, name: 'is_observing') bool? get isObserving;@JsonKey(includeIfNull: false) Revise? get revise;
/// Create a copy of TsunamiRegionEstimationMaxHeight
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiRegionEstimationMaxHeightCopyWith<TsunamiRegionEstimationMaxHeight> get copyWith => _$TsunamiRegionEstimationMaxHeightCopyWithImpl<TsunamiRegionEstimationMaxHeight>(this as TsunamiRegionEstimationMaxHeight, _$identity);

  /// Serializes this TsunamiRegionEstimationMaxHeight to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiRegionEstimationMaxHeight&&(identical(other.observedAt, observedAt) || other.observedAt == observedAt)&&(identical(other.value, value) || other.value == value)&&(identical(other.isOver, isOver) || other.isOver == isOver)&&(identical(other.qualitative, qualitative) || other.qualitative == qualitative)&&(identical(other.isObserving, isObserving) || other.isObserving == isObserving)&&(identical(other.revise, revise) || other.revise == revise));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,observedAt,value,isOver,qualitative,isObserving,revise);

@override
String toString() {
  return 'TsunamiRegionEstimationMaxHeight(observedAt: $observedAt, value: $value, isOver: $isOver, qualitative: $qualitative, isObserving: $isObserving, revise: $revise)';
}


}

/// @nodoc
abstract mixin class $TsunamiRegionEstimationMaxHeightCopyWith<$Res>  {
  factory $TsunamiRegionEstimationMaxHeightCopyWith(TsunamiRegionEstimationMaxHeight value, $Res Function(TsunamiRegionEstimationMaxHeight) _then) = _$TsunamiRegionEstimationMaxHeightCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeIfNull: false, name: 'observed_at') DateTime? observedAt,@JsonKey(includeIfNull: false) num? value,@JsonKey(includeIfNull: false, name: 'is_over') bool? isOver,@JsonKey(includeIfNull: false) QualitativeHeight? qualitative,@JsonKey(includeIfNull: false, name: 'is_observing') bool? isObserving,@JsonKey(includeIfNull: false) Revise? revise
});




}
/// @nodoc
class _$TsunamiRegionEstimationMaxHeightCopyWithImpl<$Res>
    implements $TsunamiRegionEstimationMaxHeightCopyWith<$Res> {
  _$TsunamiRegionEstimationMaxHeightCopyWithImpl(this._self, this._then);

  final TsunamiRegionEstimationMaxHeight _self;
  final $Res Function(TsunamiRegionEstimationMaxHeight) _then;

/// Create a copy of TsunamiRegionEstimationMaxHeight
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? observedAt = freezed,Object? value = freezed,Object? isOver = freezed,Object? qualitative = freezed,Object? isObserving = freezed,Object? revise = freezed,}) {
  return _then(_self.copyWith(
observedAt: freezed == observedAt ? _self.observedAt : observedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as num?,isOver: freezed == isOver ? _self.isOver : isOver // ignore: cast_nullable_to_non_nullable
as bool?,qualitative: freezed == qualitative ? _self.qualitative : qualitative // ignore: cast_nullable_to_non_nullable
as QualitativeHeight?,isObserving: freezed == isObserving ? _self.isObserving : isObserving // ignore: cast_nullable_to_non_nullable
as bool?,revise: freezed == revise ? _self.revise : revise // ignore: cast_nullable_to_non_nullable
as Revise?,
  ));
}

}


/// Adds pattern-matching-related methods to [TsunamiRegionEstimationMaxHeight].
extension TsunamiRegionEstimationMaxHeightPatterns on TsunamiRegionEstimationMaxHeight {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TsunamiRegionEstimationMaxHeight value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TsunamiRegionEstimationMaxHeight() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TsunamiRegionEstimationMaxHeight value)  $default,){
final _that = this;
switch (_that) {
case _TsunamiRegionEstimationMaxHeight():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TsunamiRegionEstimationMaxHeight value)?  $default,){
final _that = this;
switch (_that) {
case _TsunamiRegionEstimationMaxHeight() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false, name: 'observed_at')  DateTime? observedAt, @JsonKey(includeIfNull: false)  num? value, @JsonKey(includeIfNull: false, name: 'is_over')  bool? isOver, @JsonKey(includeIfNull: false)  QualitativeHeight? qualitative, @JsonKey(includeIfNull: false, name: 'is_observing')  bool? isObserving, @JsonKey(includeIfNull: false)  Revise? revise)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TsunamiRegionEstimationMaxHeight() when $default != null:
return $default(_that.observedAt,_that.value,_that.isOver,_that.qualitative,_that.isObserving,_that.revise);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false, name: 'observed_at')  DateTime? observedAt, @JsonKey(includeIfNull: false)  num? value, @JsonKey(includeIfNull: false, name: 'is_over')  bool? isOver, @JsonKey(includeIfNull: false)  QualitativeHeight? qualitative, @JsonKey(includeIfNull: false, name: 'is_observing')  bool? isObserving, @JsonKey(includeIfNull: false)  Revise? revise)  $default,) {final _that = this;
switch (_that) {
case _TsunamiRegionEstimationMaxHeight():
return $default(_that.observedAt,_that.value,_that.isOver,_that.qualitative,_that.isObserving,_that.revise);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeIfNull: false, name: 'observed_at')  DateTime? observedAt, @JsonKey(includeIfNull: false)  num? value, @JsonKey(includeIfNull: false, name: 'is_over')  bool? isOver, @JsonKey(includeIfNull: false)  QualitativeHeight? qualitative, @JsonKey(includeIfNull: false, name: 'is_observing')  bool? isObserving, @JsonKey(includeIfNull: false)  Revise? revise)?  $default,) {final _that = this;
switch (_that) {
case _TsunamiRegionEstimationMaxHeight() when $default != null:
return $default(_that.observedAt,_that.value,_that.isOver,_that.qualitative,_that.isObserving,_that.revise);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TsunamiRegionEstimationMaxHeight implements TsunamiRegionEstimationMaxHeight {
  const _TsunamiRegionEstimationMaxHeight({@JsonKey(includeIfNull: false, name: 'observed_at') this.observedAt, @JsonKey(includeIfNull: false) this.value, @JsonKey(includeIfNull: false, name: 'is_over') this.isOver, @JsonKey(includeIfNull: false) this.qualitative, @JsonKey(includeIfNull: false, name: 'is_observing') this.isObserving, @JsonKey(includeIfNull: false) this.revise});
  factory _TsunamiRegionEstimationMaxHeight.fromJson(Map<String, dynamic> json) => _$TsunamiRegionEstimationMaxHeightFromJson(json);

@override@JsonKey(includeIfNull: false, name: 'observed_at') final  DateTime? observedAt;
/// 津波警報以上でまだ津波の観測値が小さい場合は出現しない
@override@JsonKey(includeIfNull: false) final  num? value;
/// 10m超となる時に出現する 取りうる値はtrueのみ.
/// const: true.
@override@JsonKey(includeIfNull: false, name: 'is_over') final  bool? isOver;
@override@JsonKey(includeIfNull: false) final  QualitativeHeight? qualitative;
/// 津波警報以上でまだ津波の観測値が小さい場合に出現する.
/// const: true.
@override@JsonKey(includeIfNull: false, name: 'is_observing') final  bool? isObserving;
@override@JsonKey(includeIfNull: false) final  Revise? revise;

/// Create a copy of TsunamiRegionEstimationMaxHeight
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiRegionEstimationMaxHeightCopyWith<_TsunamiRegionEstimationMaxHeight> get copyWith => __$TsunamiRegionEstimationMaxHeightCopyWithImpl<_TsunamiRegionEstimationMaxHeight>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TsunamiRegionEstimationMaxHeightToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiRegionEstimationMaxHeight&&(identical(other.observedAt, observedAt) || other.observedAt == observedAt)&&(identical(other.value, value) || other.value == value)&&(identical(other.isOver, isOver) || other.isOver == isOver)&&(identical(other.qualitative, qualitative) || other.qualitative == qualitative)&&(identical(other.isObserving, isObserving) || other.isObserving == isObserving)&&(identical(other.revise, revise) || other.revise == revise));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,observedAt,value,isOver,qualitative,isObserving,revise);

@override
String toString() {
  return 'TsunamiRegionEstimationMaxHeight(observedAt: $observedAt, value: $value, isOver: $isOver, qualitative: $qualitative, isObserving: $isObserving, revise: $revise)';
}


}

/// @nodoc
abstract mixin class _$TsunamiRegionEstimationMaxHeightCopyWith<$Res> implements $TsunamiRegionEstimationMaxHeightCopyWith<$Res> {
  factory _$TsunamiRegionEstimationMaxHeightCopyWith(_TsunamiRegionEstimationMaxHeight value, $Res Function(_TsunamiRegionEstimationMaxHeight) _then) = __$TsunamiRegionEstimationMaxHeightCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeIfNull: false, name: 'observed_at') DateTime? observedAt,@JsonKey(includeIfNull: false) num? value,@JsonKey(includeIfNull: false, name: 'is_over') bool? isOver,@JsonKey(includeIfNull: false) QualitativeHeight? qualitative,@JsonKey(includeIfNull: false, name: 'is_observing') bool? isObserving,@JsonKey(includeIfNull: false) Revise? revise
});




}
/// @nodoc
class __$TsunamiRegionEstimationMaxHeightCopyWithImpl<$Res>
    implements _$TsunamiRegionEstimationMaxHeightCopyWith<$Res> {
  __$TsunamiRegionEstimationMaxHeightCopyWithImpl(this._self, this._then);

  final _TsunamiRegionEstimationMaxHeight _self;
  final $Res Function(_TsunamiRegionEstimationMaxHeight) _then;

/// Create a copy of TsunamiRegionEstimationMaxHeight
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? observedAt = freezed,Object? value = freezed,Object? isOver = freezed,Object? qualitative = freezed,Object? isObserving = freezed,Object? revise = freezed,}) {
  return _then(_TsunamiRegionEstimationMaxHeight(
observedAt: freezed == observedAt ? _self.observedAt : observedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as num?,isOver: freezed == isOver ? _self.isOver : isOver // ignore: cast_nullable_to_non_nullable
as bool?,qualitative: freezed == qualitative ? _self.qualitative : qualitative // ignore: cast_nullable_to_non_nullable
as QualitativeHeight?,isObserving: freezed == isObserving ? _self.isObserving : isObserving // ignore: cast_nullable_to_non_nullable
as bool?,revise: freezed == revise ? _self.revise : revise // ignore: cast_nullable_to_non_nullable
as Revise?,
  ));
}


}

// dart format on
