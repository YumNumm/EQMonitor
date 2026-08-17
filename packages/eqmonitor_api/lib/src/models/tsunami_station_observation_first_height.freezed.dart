// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tsunami_station_observation_first_height.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TsunamiStationObservationFirstHeight {

/// 欠測時、識別不能時は出現しない
@JsonKey(includeIfNull: false, name: 'arrival_time') DateTime? get arrivalTime;@JsonKey(includeIfNull: false) WaveInitial? get initial;/// 識別不能時に出現する.
/// const: true.
@JsonKey(includeIfNull: false, name: 'is_unidentifiable') bool? get isUnidentifiable;/// 欠測によりデータがない場合出現する.
/// const: true.
@JsonKey(includeIfNull: false, name: 'is_missing') bool? get isMissing;@JsonKey(includeIfNull: false) Revise? get revise;
/// Create a copy of TsunamiStationObservationFirstHeight
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiStationObservationFirstHeightCopyWith<TsunamiStationObservationFirstHeight> get copyWith => _$TsunamiStationObservationFirstHeightCopyWithImpl<TsunamiStationObservationFirstHeight>(this as TsunamiStationObservationFirstHeight, _$identity);

  /// Serializes this TsunamiStationObservationFirstHeight to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiStationObservationFirstHeight&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.initial, initial) || other.initial == initial)&&(identical(other.isUnidentifiable, isUnidentifiable) || other.isUnidentifiable == isUnidentifiable)&&(identical(other.isMissing, isMissing) || other.isMissing == isMissing)&&(identical(other.revise, revise) || other.revise == revise));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,arrivalTime,initial,isUnidentifiable,isMissing,revise);

@override
String toString() {
  return 'TsunamiStationObservationFirstHeight(arrivalTime: $arrivalTime, initial: $initial, isUnidentifiable: $isUnidentifiable, isMissing: $isMissing, revise: $revise)';
}


}

/// @nodoc
abstract mixin class $TsunamiStationObservationFirstHeightCopyWith<$Res>  {
  factory $TsunamiStationObservationFirstHeightCopyWith(TsunamiStationObservationFirstHeight value, $Res Function(TsunamiStationObservationFirstHeight) _then) = _$TsunamiStationObservationFirstHeightCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeIfNull: false, name: 'arrival_time') DateTime? arrivalTime,@JsonKey(includeIfNull: false) WaveInitial? initial,@JsonKey(includeIfNull: false, name: 'is_unidentifiable') bool? isUnidentifiable,@JsonKey(includeIfNull: false, name: 'is_missing') bool? isMissing,@JsonKey(includeIfNull: false) Revise? revise
});




}
/// @nodoc
class _$TsunamiStationObservationFirstHeightCopyWithImpl<$Res>
    implements $TsunamiStationObservationFirstHeightCopyWith<$Res> {
  _$TsunamiStationObservationFirstHeightCopyWithImpl(this._self, this._then);

  final TsunamiStationObservationFirstHeight _self;
  final $Res Function(TsunamiStationObservationFirstHeight) _then;

/// Create a copy of TsunamiStationObservationFirstHeight
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? arrivalTime = freezed,Object? initial = freezed,Object? isUnidentifiable = freezed,Object? isMissing = freezed,Object? revise = freezed,}) {
  return _then(TsunamiStationObservationFirstHeight(
arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,initial: freezed == initial ? _self.initial : initial // ignore: cast_nullable_to_non_nullable
as WaveInitial?,isUnidentifiable: freezed == isUnidentifiable ? _self.isUnidentifiable : isUnidentifiable // ignore: cast_nullable_to_non_nullable
as bool?,isMissing: freezed == isMissing ? _self.isMissing : isMissing // ignore: cast_nullable_to_non_nullable
as bool?,revise: freezed == revise ? _self.revise : revise // ignore: cast_nullable_to_non_nullable
as Revise?,
  ));
}

}


/// Adds pattern-matching-related methods to [TsunamiStationObservationFirstHeight].
extension TsunamiStationObservationFirstHeightPatterns on TsunamiStationObservationFirstHeight {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TsunamiStationObservationFirstHeight value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TsunamiStationObservationFirstHeight() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TsunamiStationObservationFirstHeight value)  $default,){
final _that = this;
switch (_that) {
case _TsunamiStationObservationFirstHeight():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TsunamiStationObservationFirstHeight value)?  $default,){
final _that = this;
switch (_that) {
case _TsunamiStationObservationFirstHeight() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false, name: 'arrival_time')  DateTime? arrivalTime, @JsonKey(includeIfNull: false)  WaveInitial? initial, @JsonKey(includeIfNull: false, name: 'is_unidentifiable')  bool? isUnidentifiable, @JsonKey(includeIfNull: false, name: 'is_missing')  bool? isMissing, @JsonKey(includeIfNull: false)  Revise? revise)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TsunamiStationObservationFirstHeight() when $default != null:
return $default(_that.arrivalTime,_that.initial,_that.isUnidentifiable,_that.isMissing,_that.revise);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false, name: 'arrival_time')  DateTime? arrivalTime, @JsonKey(includeIfNull: false)  WaveInitial? initial, @JsonKey(includeIfNull: false, name: 'is_unidentifiable')  bool? isUnidentifiable, @JsonKey(includeIfNull: false, name: 'is_missing')  bool? isMissing, @JsonKey(includeIfNull: false)  Revise? revise)  $default,) {final _that = this;
switch (_that) {
case _TsunamiStationObservationFirstHeight():
return $default(_that.arrivalTime,_that.initial,_that.isUnidentifiable,_that.isMissing,_that.revise);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeIfNull: false, name: 'arrival_time')  DateTime? arrivalTime, @JsonKey(includeIfNull: false)  WaveInitial? initial, @JsonKey(includeIfNull: false, name: 'is_unidentifiable')  bool? isUnidentifiable, @JsonKey(includeIfNull: false, name: 'is_missing')  bool? isMissing, @JsonKey(includeIfNull: false)  Revise? revise)?  $default,) {final _that = this;
switch (_that) {
case _TsunamiStationObservationFirstHeight() when $default != null:
return $default(_that.arrivalTime,_that.initial,_that.isUnidentifiable,_that.isMissing,_that.revise);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TsunamiStationObservationFirstHeight implements TsunamiStationObservationFirstHeight {
  const _TsunamiStationObservationFirstHeight({@JsonKey(includeIfNull: false, name: 'arrival_time') this.arrivalTime, @JsonKey(includeIfNull: false) this.initial, @JsonKey(includeIfNull: false, name: 'is_unidentifiable') this.isUnidentifiable, @JsonKey(includeIfNull: false, name: 'is_missing') this.isMissing, @JsonKey(includeIfNull: false) this.revise});
  factory _TsunamiStationObservationFirstHeight.fromJson(Map<String, dynamic> json) => _$TsunamiStationObservationFirstHeightFromJson(json);

/// 欠測時、識別不能時は出現しない
@override@JsonKey(includeIfNull: false, name: 'arrival_time') final  DateTime? arrivalTime;
@override@JsonKey(includeIfNull: false) final  WaveInitial? initial;
/// 識別不能時に出現する.
/// const: true.
@override@JsonKey(includeIfNull: false, name: 'is_unidentifiable') final  bool? isUnidentifiable;
/// 欠測によりデータがない場合出現する.
/// const: true.
@override@JsonKey(includeIfNull: false, name: 'is_missing') final  bool? isMissing;
@override@JsonKey(includeIfNull: false) final  Revise? revise;

/// Create a copy of TsunamiStationObservationFirstHeight
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiStationObservationFirstHeightCopyWith<_TsunamiStationObservationFirstHeight> get copyWith => __$TsunamiStationObservationFirstHeightCopyWithImpl<_TsunamiStationObservationFirstHeight>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TsunamiStationObservationFirstHeightToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiStationObservationFirstHeight&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.initial, initial) || other.initial == initial)&&(identical(other.isUnidentifiable, isUnidentifiable) || other.isUnidentifiable == isUnidentifiable)&&(identical(other.isMissing, isMissing) || other.isMissing == isMissing)&&(identical(other.revise, revise) || other.revise == revise));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,arrivalTime,initial,isUnidentifiable,isMissing,revise);

@override
String toString() {
  return 'TsunamiStationObservationFirstHeight(arrivalTime: $arrivalTime, initial: $initial, isUnidentifiable: $isUnidentifiable, isMissing: $isMissing, revise: $revise)';
}


}

/// @nodoc
abstract mixin class _$TsunamiStationObservationFirstHeightCopyWith<$Res> implements $TsunamiStationObservationFirstHeightCopyWith<$Res> {
  factory _$TsunamiStationObservationFirstHeightCopyWith(_TsunamiStationObservationFirstHeight value, $Res Function(_TsunamiStationObservationFirstHeight) _then) = __$TsunamiStationObservationFirstHeightCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeIfNull: false, name: 'arrival_time') DateTime? arrivalTime,@JsonKey(includeIfNull: false) WaveInitial? initial,@JsonKey(includeIfNull: false, name: 'is_unidentifiable') bool? isUnidentifiable,@JsonKey(includeIfNull: false, name: 'is_missing') bool? isMissing,@JsonKey(includeIfNull: false) Revise? revise
});




}
/// @nodoc
class __$TsunamiStationObservationFirstHeightCopyWithImpl<$Res>
    implements _$TsunamiStationObservationFirstHeightCopyWith<$Res> {
  __$TsunamiStationObservationFirstHeightCopyWithImpl(this._self, this._then);

  final _TsunamiStationObservationFirstHeight _self;
  final $Res Function(_TsunamiStationObservationFirstHeight) _then;

/// Create a copy of TsunamiStationObservationFirstHeight
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? arrivalTime = freezed,Object? initial = freezed,Object? isUnidentifiable = freezed,Object? isMissing = freezed,Object? revise = freezed,}) {
  return _then(_TsunamiStationObservationFirstHeight(
arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,initial: freezed == initial ? _self.initial : initial // ignore: cast_nullable_to_non_nullable
as WaveInitial?,isUnidentifiable: freezed == isUnidentifiable ? _self.isUnidentifiable : isUnidentifiable // ignore: cast_nullable_to_non_nullable
as bool?,isMissing: freezed == isMissing ? _self.isMissing : isMissing // ignore: cast_nullable_to_non_nullable
as bool?,revise: freezed == revise ? _self.revise : revise // ignore: cast_nullable_to_non_nullable
as Revise?,
  ));
}


}

// dart format on
