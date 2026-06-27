// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'max_height.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MaxHeight {

/// 10m超となる時に出現する 取りうる値はtrueのみ.
/// const: true.
@JsonKey(name: 'is_over') bool get isOver;/// 津波警報以上でまだ津波の観測値が小さい場合に出現する.
/// const: true.
@JsonKey(name: 'is_observing') bool get isObserving;@JsonKey(includeIfNull: false, name: 'observed_at') DateTime? get observedAt;/// 津波警報以上でまだ津波の観測値が小さい場合は出現しない
@JsonKey(includeIfNull: false) num? get value;@JsonKey(includeIfNull: false) QualitativeHeight? get qualitative;@JsonKey(includeIfNull: false) Revise? get revise;
/// Create a copy of MaxHeight
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MaxHeightCopyWith<MaxHeight> get copyWith => _$MaxHeightCopyWithImpl<MaxHeight>(this as MaxHeight, _$identity);

  /// Serializes this MaxHeight to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MaxHeight&&(identical(other.isOver, isOver) || other.isOver == isOver)&&(identical(other.isObserving, isObserving) || other.isObserving == isObserving)&&(identical(other.observedAt, observedAt) || other.observedAt == observedAt)&&(identical(other.value, value) || other.value == value)&&(identical(other.qualitative, qualitative) || other.qualitative == qualitative)&&(identical(other.revise, revise) || other.revise == revise));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isOver,isObserving,observedAt,value,qualitative,revise);

@override
String toString() {
  return 'MaxHeight(isOver: $isOver, isObserving: $isObserving, observedAt: $observedAt, value: $value, qualitative: $qualitative, revise: $revise)';
}


}

/// @nodoc
abstract mixin class $MaxHeightCopyWith<$Res>  {
  factory $MaxHeightCopyWith(MaxHeight value, $Res Function(MaxHeight) _then) = _$MaxHeightCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'is_over') bool isOver,@JsonKey(name: 'is_observing') bool isObserving,@JsonKey(includeIfNull: false, name: 'observed_at') DateTime? observedAt,@JsonKey(includeIfNull: false) num? value,@JsonKey(includeIfNull: false) QualitativeHeight? qualitative,@JsonKey(includeIfNull: false) Revise? revise
});




}
/// @nodoc
class _$MaxHeightCopyWithImpl<$Res>
    implements $MaxHeightCopyWith<$Res> {
  _$MaxHeightCopyWithImpl(this._self, this._then);

  final MaxHeight _self;
  final $Res Function(MaxHeight) _then;

/// Create a copy of MaxHeight
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isOver = null,Object? isObserving = null,Object? observedAt = freezed,Object? value = freezed,Object? qualitative = freezed,Object? revise = freezed,}) {
  return _then(_self.copyWith(
isOver: null == isOver ? _self.isOver : isOver // ignore: cast_nullable_to_non_nullable
as bool,isObserving: null == isObserving ? _self.isObserving : isObserving // ignore: cast_nullable_to_non_nullable
as bool,observedAt: freezed == observedAt ? _self.observedAt : observedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as num?,qualitative: freezed == qualitative ? _self.qualitative : qualitative // ignore: cast_nullable_to_non_nullable
as QualitativeHeight?,revise: freezed == revise ? _self.revise : revise // ignore: cast_nullable_to_non_nullable
as Revise?,
  ));
}

}


/// Adds pattern-matching-related methods to [MaxHeight].
extension MaxHeightPatterns on MaxHeight {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MaxHeight value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MaxHeight() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MaxHeight value)  $default,){
final _that = this;
switch (_that) {
case _MaxHeight():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MaxHeight value)?  $default,){
final _that = this;
switch (_that) {
case _MaxHeight() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'is_over')  bool isOver, @JsonKey(name: 'is_observing')  bool isObserving, @JsonKey(includeIfNull: false, name: 'observed_at')  DateTime? observedAt, @JsonKey(includeIfNull: false)  num? value, @JsonKey(includeIfNull: false)  QualitativeHeight? qualitative, @JsonKey(includeIfNull: false)  Revise? revise)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MaxHeight() when $default != null:
return $default(_that.isOver,_that.isObserving,_that.observedAt,_that.value,_that.qualitative,_that.revise);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'is_over')  bool isOver, @JsonKey(name: 'is_observing')  bool isObserving, @JsonKey(includeIfNull: false, name: 'observed_at')  DateTime? observedAt, @JsonKey(includeIfNull: false)  num? value, @JsonKey(includeIfNull: false)  QualitativeHeight? qualitative, @JsonKey(includeIfNull: false)  Revise? revise)  $default,) {final _that = this;
switch (_that) {
case _MaxHeight():
return $default(_that.isOver,_that.isObserving,_that.observedAt,_that.value,_that.qualitative,_that.revise);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'is_over')  bool isOver, @JsonKey(name: 'is_observing')  bool isObserving, @JsonKey(includeIfNull: false, name: 'observed_at')  DateTime? observedAt, @JsonKey(includeIfNull: false)  num? value, @JsonKey(includeIfNull: false)  QualitativeHeight? qualitative, @JsonKey(includeIfNull: false)  Revise? revise)?  $default,) {final _that = this;
switch (_that) {
case _MaxHeight() when $default != null:
return $default(_that.isOver,_that.isObserving,_that.observedAt,_that.value,_that.qualitative,_that.revise);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MaxHeight implements MaxHeight {
  const _MaxHeight({@JsonKey(name: 'is_over') required this.isOver, @JsonKey(name: 'is_observing') required this.isObserving, @JsonKey(includeIfNull: false, name: 'observed_at') this.observedAt, @JsonKey(includeIfNull: false) this.value, @JsonKey(includeIfNull: false) this.qualitative, @JsonKey(includeIfNull: false) this.revise});
  factory _MaxHeight.fromJson(Map<String, dynamic> json) => _$MaxHeightFromJson(json);

/// 10m超となる時に出現する 取りうる値はtrueのみ.
/// const: true.
@override@JsonKey(name: 'is_over') final  bool isOver;
/// 津波警報以上でまだ津波の観測値が小さい場合に出現する.
/// const: true.
@override@JsonKey(name: 'is_observing') final  bool isObserving;
@override@JsonKey(includeIfNull: false, name: 'observed_at') final  DateTime? observedAt;
/// 津波警報以上でまだ津波の観測値が小さい場合は出現しない
@override@JsonKey(includeIfNull: false) final  num? value;
@override@JsonKey(includeIfNull: false) final  QualitativeHeight? qualitative;
@override@JsonKey(includeIfNull: false) final  Revise? revise;

/// Create a copy of MaxHeight
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MaxHeightCopyWith<_MaxHeight> get copyWith => __$MaxHeightCopyWithImpl<_MaxHeight>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MaxHeightToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MaxHeight&&(identical(other.isOver, isOver) || other.isOver == isOver)&&(identical(other.isObserving, isObserving) || other.isObserving == isObserving)&&(identical(other.observedAt, observedAt) || other.observedAt == observedAt)&&(identical(other.value, value) || other.value == value)&&(identical(other.qualitative, qualitative) || other.qualitative == qualitative)&&(identical(other.revise, revise) || other.revise == revise));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isOver,isObserving,observedAt,value,qualitative,revise);

@override
String toString() {
  return 'MaxHeight(isOver: $isOver, isObserving: $isObserving, observedAt: $observedAt, value: $value, qualitative: $qualitative, revise: $revise)';
}


}

/// @nodoc
abstract mixin class _$MaxHeightCopyWith<$Res> implements $MaxHeightCopyWith<$Res> {
  factory _$MaxHeightCopyWith(_MaxHeight value, $Res Function(_MaxHeight) _then) = __$MaxHeightCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'is_over') bool isOver,@JsonKey(name: 'is_observing') bool isObserving,@JsonKey(includeIfNull: false, name: 'observed_at') DateTime? observedAt,@JsonKey(includeIfNull: false) num? value,@JsonKey(includeIfNull: false) QualitativeHeight? qualitative,@JsonKey(includeIfNull: false) Revise? revise
});




}
/// @nodoc
class __$MaxHeightCopyWithImpl<$Res>
    implements _$MaxHeightCopyWith<$Res> {
  __$MaxHeightCopyWithImpl(this._self, this._then);

  final _MaxHeight _self;
  final $Res Function(_MaxHeight) _then;

/// Create a copy of MaxHeight
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isOver = null,Object? isObserving = null,Object? observedAt = freezed,Object? value = freezed,Object? qualitative = freezed,Object? revise = freezed,}) {
  return _then(_MaxHeight(
isOver: null == isOver ? _self.isOver : isOver // ignore: cast_nullable_to_non_nullable
as bool,isObserving: null == isObserving ? _self.isObserving : isObserving // ignore: cast_nullable_to_non_nullable
as bool,observedAt: freezed == observedAt ? _self.observedAt : observedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as num?,qualitative: freezed == qualitative ? _self.qualitative : qualitative // ignore: cast_nullable_to_non_nullable
as QualitativeHeight?,revise: freezed == revise ? _self.revise : revise // ignore: cast_nullable_to_non_nullable
as Revise?,
  ));
}


}

// dart format on
