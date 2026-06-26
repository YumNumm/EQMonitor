// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tsunami_station_observation_max_height.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TsunamiStationObservationMaxHeight {

/// 観測範囲より津波の高さが超過した場合に使用し、数値情報を補助する.
/// const: true.
@JsonKey(name: 'is_over') bool get isOver;/// 数値情報に付加的情報が必要な場合に出現.
/// const: true.
@JsonKey(name: 'is_rising') bool get isRising;/// 欠測によりデータが現在取得できていない場合に出現する.
/// const: true.
@JsonKey(name: 'is_missing') bool get isMissing;/// 津波の最大波を観測した日時
@JsonKey(includeIfNull: false, name: 'observed_at') DateTime? get observedAt;@JsonKey(includeIfNull: false) num? get value;@JsonKey(includeIfNull: false) ObservationMaxHeightCondition? get condition;@JsonKey(includeIfNull: false) Revise? get revise;
/// Create a copy of TsunamiStationObservationMaxHeight
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiStationObservationMaxHeightCopyWith<TsunamiStationObservationMaxHeight> get copyWith => _$TsunamiStationObservationMaxHeightCopyWithImpl<TsunamiStationObservationMaxHeight>(this as TsunamiStationObservationMaxHeight, _$identity);

  /// Serializes this TsunamiStationObservationMaxHeight to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiStationObservationMaxHeight&&(identical(other.isOver, isOver) || other.isOver == isOver)&&(identical(other.isRising, isRising) || other.isRising == isRising)&&(identical(other.isMissing, isMissing) || other.isMissing == isMissing)&&(identical(other.observedAt, observedAt) || other.observedAt == observedAt)&&(identical(other.value, value) || other.value == value)&&(identical(other.condition, condition) || other.condition == condition)&&(identical(other.revise, revise) || other.revise == revise));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isOver,isRising,isMissing,observedAt,value,condition,revise);

@override
String toString() {
  return 'TsunamiStationObservationMaxHeight(isOver: $isOver, isRising: $isRising, isMissing: $isMissing, observedAt: $observedAt, value: $value, condition: $condition, revise: $revise)';
}


}

/// @nodoc
abstract mixin class $TsunamiStationObservationMaxHeightCopyWith<$Res>  {
  factory $TsunamiStationObservationMaxHeightCopyWith(TsunamiStationObservationMaxHeight value, $Res Function(TsunamiStationObservationMaxHeight) _then) = _$TsunamiStationObservationMaxHeightCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'is_over') bool isOver,@JsonKey(name: 'is_rising') bool isRising,@JsonKey(name: 'is_missing') bool isMissing,@JsonKey(includeIfNull: false, name: 'observed_at') DateTime? observedAt,@JsonKey(includeIfNull: false) num? value,@JsonKey(includeIfNull: false) ObservationMaxHeightCondition? condition,@JsonKey(includeIfNull: false) Revise? revise
});




}
/// @nodoc
class _$TsunamiStationObservationMaxHeightCopyWithImpl<$Res>
    implements $TsunamiStationObservationMaxHeightCopyWith<$Res> {
  _$TsunamiStationObservationMaxHeightCopyWithImpl(this._self, this._then);

  final TsunamiStationObservationMaxHeight _self;
  final $Res Function(TsunamiStationObservationMaxHeight) _then;

/// Create a copy of TsunamiStationObservationMaxHeight
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isOver = null,Object? isRising = null,Object? isMissing = null,Object? observedAt = freezed,Object? value = freezed,Object? condition = freezed,Object? revise = freezed,}) {
  return _then(_self.copyWith(
isOver: null == isOver ? _self.isOver : isOver // ignore: cast_nullable_to_non_nullable
as bool,isRising: null == isRising ? _self.isRising : isRising // ignore: cast_nullable_to_non_nullable
as bool,isMissing: null == isMissing ? _self.isMissing : isMissing // ignore: cast_nullable_to_non_nullable
as bool,observedAt: freezed == observedAt ? _self.observedAt : observedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as num?,condition: freezed == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as ObservationMaxHeightCondition?,revise: freezed == revise ? _self.revise : revise // ignore: cast_nullable_to_non_nullable
as Revise?,
  ));
}

}


/// Adds pattern-matching-related methods to [TsunamiStationObservationMaxHeight].
extension TsunamiStationObservationMaxHeightPatterns on TsunamiStationObservationMaxHeight {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TsunamiStationObservationMaxHeight value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TsunamiStationObservationMaxHeight() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TsunamiStationObservationMaxHeight value)  $default,){
final _that = this;
switch (_that) {
case _TsunamiStationObservationMaxHeight():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TsunamiStationObservationMaxHeight value)?  $default,){
final _that = this;
switch (_that) {
case _TsunamiStationObservationMaxHeight() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'is_over')  bool isOver, @JsonKey(name: 'is_rising')  bool isRising, @JsonKey(name: 'is_missing')  bool isMissing, @JsonKey(includeIfNull: false, name: 'observed_at')  DateTime? observedAt, @JsonKey(includeIfNull: false)  num? value, @JsonKey(includeIfNull: false)  ObservationMaxHeightCondition? condition, @JsonKey(includeIfNull: false)  Revise? revise)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TsunamiStationObservationMaxHeight() when $default != null:
return $default(_that.isOver,_that.isRising,_that.isMissing,_that.observedAt,_that.value,_that.condition,_that.revise);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'is_over')  bool isOver, @JsonKey(name: 'is_rising')  bool isRising, @JsonKey(name: 'is_missing')  bool isMissing, @JsonKey(includeIfNull: false, name: 'observed_at')  DateTime? observedAt, @JsonKey(includeIfNull: false)  num? value, @JsonKey(includeIfNull: false)  ObservationMaxHeightCondition? condition, @JsonKey(includeIfNull: false)  Revise? revise)  $default,) {final _that = this;
switch (_that) {
case _TsunamiStationObservationMaxHeight():
return $default(_that.isOver,_that.isRising,_that.isMissing,_that.observedAt,_that.value,_that.condition,_that.revise);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'is_over')  bool isOver, @JsonKey(name: 'is_rising')  bool isRising, @JsonKey(name: 'is_missing')  bool isMissing, @JsonKey(includeIfNull: false, name: 'observed_at')  DateTime? observedAt, @JsonKey(includeIfNull: false)  num? value, @JsonKey(includeIfNull: false)  ObservationMaxHeightCondition? condition, @JsonKey(includeIfNull: false)  Revise? revise)?  $default,) {final _that = this;
switch (_that) {
case _TsunamiStationObservationMaxHeight() when $default != null:
return $default(_that.isOver,_that.isRising,_that.isMissing,_that.observedAt,_that.value,_that.condition,_that.revise);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TsunamiStationObservationMaxHeight implements TsunamiStationObservationMaxHeight {
  const _TsunamiStationObservationMaxHeight({@JsonKey(name: 'is_over') required this.isOver, @JsonKey(name: 'is_rising') required this.isRising, @JsonKey(name: 'is_missing') required this.isMissing, @JsonKey(includeIfNull: false, name: 'observed_at') this.observedAt, @JsonKey(includeIfNull: false) this.value, @JsonKey(includeIfNull: false) this.condition, @JsonKey(includeIfNull: false) this.revise});
  factory _TsunamiStationObservationMaxHeight.fromJson(Map<String, dynamic> json) => _$TsunamiStationObservationMaxHeightFromJson(json);

/// 観測範囲より津波の高さが超過した場合に使用し、数値情報を補助する.
/// const: true.
@override@JsonKey(name: 'is_over') final  bool isOver;
/// 数値情報に付加的情報が必要な場合に出現.
/// const: true.
@override@JsonKey(name: 'is_rising') final  bool isRising;
/// 欠測によりデータが現在取得できていない場合に出現する.
/// const: true.
@override@JsonKey(name: 'is_missing') final  bool isMissing;
/// 津波の最大波を観測した日時
@override@JsonKey(includeIfNull: false, name: 'observed_at') final  DateTime? observedAt;
@override@JsonKey(includeIfNull: false) final  num? value;
@override@JsonKey(includeIfNull: false) final  ObservationMaxHeightCondition? condition;
@override@JsonKey(includeIfNull: false) final  Revise? revise;

/// Create a copy of TsunamiStationObservationMaxHeight
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiStationObservationMaxHeightCopyWith<_TsunamiStationObservationMaxHeight> get copyWith => __$TsunamiStationObservationMaxHeightCopyWithImpl<_TsunamiStationObservationMaxHeight>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TsunamiStationObservationMaxHeightToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiStationObservationMaxHeight&&(identical(other.isOver, isOver) || other.isOver == isOver)&&(identical(other.isRising, isRising) || other.isRising == isRising)&&(identical(other.isMissing, isMissing) || other.isMissing == isMissing)&&(identical(other.observedAt, observedAt) || other.observedAt == observedAt)&&(identical(other.value, value) || other.value == value)&&(identical(other.condition, condition) || other.condition == condition)&&(identical(other.revise, revise) || other.revise == revise));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isOver,isRising,isMissing,observedAt,value,condition,revise);

@override
String toString() {
  return 'TsunamiStationObservationMaxHeight(isOver: $isOver, isRising: $isRising, isMissing: $isMissing, observedAt: $observedAt, value: $value, condition: $condition, revise: $revise)';
}


}

/// @nodoc
abstract mixin class _$TsunamiStationObservationMaxHeightCopyWith<$Res> implements $TsunamiStationObservationMaxHeightCopyWith<$Res> {
  factory _$TsunamiStationObservationMaxHeightCopyWith(_TsunamiStationObservationMaxHeight value, $Res Function(_TsunamiStationObservationMaxHeight) _then) = __$TsunamiStationObservationMaxHeightCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'is_over') bool isOver,@JsonKey(name: 'is_rising') bool isRising,@JsonKey(name: 'is_missing') bool isMissing,@JsonKey(includeIfNull: false, name: 'observed_at') DateTime? observedAt,@JsonKey(includeIfNull: false) num? value,@JsonKey(includeIfNull: false) ObservationMaxHeightCondition? condition,@JsonKey(includeIfNull: false) Revise? revise
});




}
/// @nodoc
class __$TsunamiStationObservationMaxHeightCopyWithImpl<$Res>
    implements _$TsunamiStationObservationMaxHeightCopyWith<$Res> {
  __$TsunamiStationObservationMaxHeightCopyWithImpl(this._self, this._then);

  final _TsunamiStationObservationMaxHeight _self;
  final $Res Function(_TsunamiStationObservationMaxHeight) _then;

/// Create a copy of TsunamiStationObservationMaxHeight
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isOver = null,Object? isRising = null,Object? isMissing = null,Object? observedAt = freezed,Object? value = freezed,Object? condition = freezed,Object? revise = freezed,}) {
  return _then(_TsunamiStationObservationMaxHeight(
isOver: null == isOver ? _self.isOver : isOver // ignore: cast_nullable_to_non_nullable
as bool,isRising: null == isRising ? _self.isRising : isRising // ignore: cast_nullable_to_non_nullable
as bool,isMissing: null == isMissing ? _self.isMissing : isMissing // ignore: cast_nullable_to_non_nullable
as bool,observedAt: freezed == observedAt ? _self.observedAt : observedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as num?,condition: freezed == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as ObservationMaxHeightCondition?,revise: freezed == revise ? _self.revise : revise // ignore: cast_nullable_to_non_nullable
as Revise?,
  ));
}


}

// dart format on
